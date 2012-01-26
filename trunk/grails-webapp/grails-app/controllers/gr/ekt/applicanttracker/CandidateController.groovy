package gr.ekt.applicanttracker

import groovy.text.SimpleTemplateEngine;

import java.io.File;
import javax.persistence.Id;
import org.codehaus.groovy.grails.plugins.springsecurity.Secured;
import org.springframework.mail.MailException;

class CandidateController {
	
	def authenticateService
	EmailerService emailerService
	def userCache
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
	def index = {
		redirect(controller: "home", action: "index", params: params)
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
	def list = {
		params.max = Math.min(params.max ? params.int('max') : 100, 100)
		
		def candidateList
		def total
		if (params['candidateLastname']){
			candidateList = Candidate.findAllByLastnameIlike("%"+params['candidateLastname']+"%", 
					[offset:params['offset'], 
						sort:params['sort'],
						order:params['order']])
			if (candidateList instanceof Candidate){
				total=1;
				def candList = []
				candList[0] = candidateList
				[candidateInstanceList: candList, candidateInstanceTotal: total, candidateLastname: params['candidateLastname']]
			}
			else {
				def candidateList2 = Candidate.findAllByLastnameIlike("%"+params['candidateLastname']+"%")
				total = candidateList2?.size()
				[candidateInstanceList: candidateList, candidateInstanceTotal: total, candidateLastname: params['candidateLastname']]
			}
		}
		else {
			candidateList = Candidate.list(params)
			total = Candidate.count()
			[candidateInstanceList: candidateList, candidateInstanceTotal: total, candidateLastname: params['candidateLastname']]
		}
		
		
		
	}
	
	def createWithNoInvitationId = {
		redirect(action: "create", params:["invitationid":params.id])
	}
	
	def create = {
		if (params.invitationid != null){
			Invitation invitation = Invitation.get(params.invitationid)
			if (invitation == null){
				redirect(action: 'list');
			}
			else if (!invitation.isInvitationEnabled()){
				redirect(action: 'disabled');
			}
			else {
				def candidateInstance = new Candidate()
				candidateInstance.properties = params
				return [candidateInstance: candidateInstance, invitationInstance: invitation]
			}
		}
		else{
			redirect(action: 'list');
		}
		
	}
	
	def disabled = {
		
	}
	
	def notallowed = {
		
	}
	
	def save = {
		def candidateInstance = new Candidate(params)
		ApplicationForm appForm = new ApplicationForm(params)
		appForm.dateIssued = new Date()
		appForm.dateInitial = appForm.dateIssued
		candidateInstance.addToCandidateApplicationForms(appForm)
		
		def projectsSelected = params.myCandidateApplicationForms
		List projSelected = new ArrayList()
		if (projectsSelected instanceof String ){
			int projectid = Integer.parseInt(projectsSelected)
			Project project = Project.get(projectid)
			println "From params user has selected: "+project.code
			projSelected.add project
		}
		else {
			projectsSelected.each{
				int projectid = Integer.parseInt(it)
				Project project = Project.get(projectid)
				println "From params user has selected: "+project.code
				projSelected.add project
				
				/*Application application = new Application()
				 project.addToProjectApplications(application)
				 project.save()
				 appForm.addToAppFormApplications(application)
				 candidateInstance.addToCandidateApplications(application)
				 */
			}
		}
		
		def f = request.getFile('bioFilepath')
		def f2 = request.getFile('applicationFilepath')
		
		if (!projectsSelected || projectsSelected.size()==0){
			candidateInstance.errors.rejectValue("candidateApplications","message.code","Πρέπει να επιλέξετε τουλάχιστον ένα κωδικό έργου");
			render(view: "create", model: [candidateInstance: candidateInstance, invitationInstance: Invitation.get(params.invitationid)])
		}
		else if (f.getSize()>10485760){
			candidateInstance.errors.rejectValue("candidateApplicationForms","message.code","Το αρχείο του βιογραφικού δεν μπορεί να είναι μεγαλύτερο από 10ΜΒ");
			render(view: "create", model: [candidateInstance: candidateInstance, invitationInstance: Invitation.get(params.invitationid), projectsSelected: projSelected])
		}
		else if (f2.getSize()>10485760){
			candidateInstance.errors.rejectValue("candidateApplicationForms","message.code","Το αρχείο του βιογραφικού δεν μπορεί να είναι μεγαλύτερο από 10ΜΒ");
			render(view: "create", model: [candidateInstance: candidateInstance, invitationInstance: Invitation.get(params.invitationid), projectsSelected: projSelected])
		}
		else{
			appForm.bioFilepath = f.getOriginalFilename()
			appForm.applicationFilepath = f2.getOriginalFilename()
			
			if (candidateInstance.save(flush: true)) {
				
				println "Saving applications"
				projSelected.each{
					Project project = it
					println "Project = " + project.code
					Application application = new Application()
					project.addToProjectApplications(application)
					//project.save()
					appForm.addToAppFormApplications(application)
					candidateInstance.addToCandidateApplications(application)
					
				}
				
				def user = new EATUser()
				user.username = candidateInstance.email
				user.email = candidateInstance.email
				user.userRealName = candidateInstance.firstname + " " + candidateInstance.lastname
				String validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
				def passwordAutmatic = ""
				for (int i=1; i<12; i++ ) {
					passwordAutmatic = passwordAutmatic + String.valueOf( validChars.charAt((int)( Math.random() * validChars.length()) ) );
				}
				
				def password = authenticateService.passwordEncoder(passwordAutmatic)
				user.passwd = password
				user.enabled = true
				user.save()
				
				EATRole candidateRole = EATRole.findByAuthority("ROLE_CANDIDATE")
				candidateRole.addToPeople(user)
				candidateRole.save()
				
				candidateInstance.user = user;
				candidateInstance.save(flush: true);
				
				//Save files
				String test = grailsAttributes.getApplicationContext().getResource("/").getFile().toString();
				test = test.substring(0, test.lastIndexOf(File.separator));
				File dirFile = new File(test+File.separator+"tenders-uploads");
				if (!dirFile.exists()){
					dirFile.mkdir();
				}
				
				File dirFile2 = new File(test+File.separator+"tenders-uploads/"+candidateInstance.id);
				if (!dirFile2.exists()){
					dirFile2.mkdir();
				}
				
				File dirFile3 = new File(test+File.separator+"tenders-uploads/"+candidateInstance.id+"/"+appForm.appFormApplications[0].project.invitation.id);
				if (!dirFile3.exists()){
					dirFile3.mkdir();
				}
				
				f.transferTo( new File(test+File.separator+"tenders-uploads/"+candidateInstance.id+File.separator+appForm.appFormApplications[0].project.invitation.id+File.separator+f.getOriginalFilename()) )
				f2.transferTo( new File(test+File.separator+"tenders-uploads/"+candidateInstance.id+File.separator+appForm.appFormApplications[0].project.invitation.id+File.separator+f2.getOriginalFilename())  )
				
				candidateInstance.currentApplicationForm = appForm
				
				//print grailsAttributes.getApplicationContext().
				sendNotificationEmail(candidateInstance, passwordAutmatic, "");
				
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'candidate.label', default: 'Candidate'), candidateInstance.id])}"
				render(view: "success", model: [candidateInstance: candidateInstance, password: passwordAutmatic ])
			}
			else {
				render(view: "create", model: [candidateInstance: candidateInstance, invitationInstance: Invitation.get(params.invitationid), projectsSelected: projSelected])
			}
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def show = {
		def candidateInstance = Candidate.get(params.id)
		if (!candidateInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
			redirect(action: "list")
		}
		else {
			[candidateInstance: candidateInstance]
		}
	}
	
	def appformcreate = {
		if (authenticateService.isLoggedIn()){
			EATUser loggedUser = authenticateService.userDomain()
			Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
			
			if (params.id.toLong()==candidateInstanceLogged.id){
				def candidateInstance = Candidate.get(params.id)
				
				def applicationFormInstance = new ApplicationForm()
				applicationFormInstance.properties = params
				
				if (!applicationFormInstance) {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'invitation.label', default: 'Invitation'), params.id])}"
					redirect(action: "list")
				}
				else {
					def invitationInstance = Invitation.get(params.invitationid)
					return [candidateInstance: candidateInstance, applicationFormInstance: applicationFormInstance, invitationInstance: invitationInstance]
				}
				
			}
			else {
				redirect(action: 'notallowed');
			}
		}
		else {
			redirect(action: 'profile');
		}
	}
	
	def appformsave = {
		EATUser loggedUser = authenticateService.userDomain()
		Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
		
		if (params.id.toLong()==candidateInstanceLogged.id){
			
			def candidateInstance = Candidate.get(params.id)
			def invitationInstance = Invitation.get(params.invitationid)
			def appFormInstance = new ApplicationForm(params)
			appFormInstance.dateIssued = new Date()
			appFormInstance.dateInitial = appFormInstance.dateIssued
			
			def projectsSelected = params.myCandidateApplicationForms
			List projSelected = new ArrayList()
			if (projectsSelected instanceof String ){
				int projectid = Integer.parseInt(projectsSelected)
				Project project = Project.get(projectid)
				println "From params user has selected: "+project.code
				projSelected.add project
			}
			else {
				projectsSelected.each{
					int projectid = Integer.parseInt(it)
					Project project = Project.get(projectid)
					println "From params user has selected: "+project.code
					projSelected.add project
				}
			}
			
			def f = request.getFile('bioFilepath')
			def f2 = request.getFile('applicationFilepath')
			
			if (!projectsSelected || projectsSelected.size()==0){
				appFormInstance.errors.rejectValue("appFormApplications","message.code","Πρέπει να επιλέξετε τουλάχιστον ένα κωδικό έργου");
				render(view: "appformcreate", model: [candidateInstance: candidateInstance, applicationFormInstance: appFormInstance, projectsSelected: projectsSelected, invitationInstance: invitationInstance])
			}
			else if (f.getSize()>10485760){
				candidateInstance.errors.rejectValue("bioFilepath","message.code","Το αρχείο του βιογραφικού δεν μπορεί να είναι μεγαλύτερο από 10ΜΒ");
				render(view: "appformcreate", model: [candidateInstance: candidateInstance, applicationFormInstance: appFormInstance, projectsSelected: projectsSelected, invitationInstance: invitationInstance])
			}
			else if (f2.getSize()>10485760){
				candidateInstance.errors.rejectValue("applicationFilepath","message.code","Το αρχείο του βιογραφικού δεν μπορεί να είναι μεγαλύτερο από 10ΜΒ");
				render(view: "appformcreate", model: [candidateInstance: candidateInstance, applicationFormInstance: appFormInstance, projectsSelected: projectsSelected, invitationInstance: invitationInstance])
			}
			else{
				if (appFormInstance) {
					if (params.version) {
						def version = params.version.toLong()
						if (appFormInstance.version > version) {
							
							appFormInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'invitation.label', default: 'ApplicarionForm')] as Object[], "Another user has updated this Invitation while you were editing")
							render(view: "appformcreate", model: [candidateInstance: candidateInstance, applicationFormInstance: appFormInstance, projectsSelected:projectsSelected, invitationInstance: invitationInstance])
							return
						}
					}
					appFormInstance.properties = params
					
					appFormInstance.bioFilepath = f.getOriginalFilename()
					appFormInstance.applicationFilepath = f2.getOriginalFilename()
					
					if (!appFormInstance.hasErrors() && appFormInstance.validate()) {
						
						candidateInstance.addToCandidateApplicationForms(appFormInstance)
						appFormInstance.save(flush: true)
						
						//Create new applications for the selected projects
						projSelected.each{
							Project project = it
							Application application = new Application()
							project.addToProjectApplications(application)
							appFormInstance.addToAppFormApplications(application)
							candidateInstance.addToCandidateApplications(application)
							application.save(flush: true)
						}
						
						//Save files
						String test = grailsAttributes.getApplicationContext().getResource("/").getFile().toString();
						test = test.substring(0, test.lastIndexOf(File.separator));
						File dirFile = new File(test+File.separator+"tenders-uploads");
						if (!dirFile.exists()){
							dirFile.mkdir();
						}
						
						File dirFile2 = new File(test+File.separator+"tenders-uploads/"+candidateInstance.id);
						if (!dirFile2.exists()){
							dirFile2.mkdir();
						}
						
						File dirFile3 = new File(test+File.separator+"tenders-uploads/"+candidateInstance.id+"/"+appFormInstance.appFormApplications[0].project.invitation.id);
						if (!dirFile3.exists()){
							dirFile3.mkdir();
						}
						//Delete all old files
						for (File file : dirFile3.listFiles()){
							file.delete()
						}
						
						f.transferTo( new File(test+File.separator+"tenders-uploads/"+candidateInstance.id+File.separator+appFormInstance.appFormApplications[0].project.invitation.id+File.separator+f.getOriginalFilename()) )
						f2.transferTo( new File(test+File.separator+"tenders-uploads/"+candidateInstance.id+File.separator+appFormInstance.appFormApplications[0].project.invitation.id+File.separator+f2.getOriginalFilename())  )
						
						
						flash.message = "Η αίτησή σας αποθηκεύθηκε επιτυχώς"
						redirect(action: "profile")
					}
					else {
						render(view: "appformcreate", model: [candidateInstance: candidateInstance, applicationFormInstance: appFormInstance, projectsSelected:projectsSelected, invitationInstance: invitationInstance])
					}
				}
			}
		}
	}
	
	def appformshow = {
		if (authenticateService.isLoggedIn()){
			EATUser loggedUser = authenticateService.userDomain()
			Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
			
			boolean isHisForm = false;
			boolean isValidInvitation = false;
			candidateInstanceLogged.candidateApplicationForms.each {
				if (it.id == Integer.parseInt(params.appformid)){
					isHisForm = true;
				}
			}
			
			if (isHisForm && ApplicationForm.get(params.appformid).appFormApplications[0].project.invitation.isInvitationEnabled())
				isValidInvitation = true;
			
			if (params.id.toLong()==candidateInstanceLogged.id && isHisForm && isValidInvitation){
				
				def candidateInstance = Candidate.get(params.id)
				def appFormInstance = ApplicationForm.get(params.appformid)
				
				if (!candidateInstance) {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
					redirect(action: "list")
				}
				else {
					return [candidateInstance: candidateInstance, appFormInstance: appFormInstance]
				}
			}
			else {
				redirect(action: 'notallowed');
			}
		}
		else {
			redirect(action: 'profile');
		}
	}
	
	def appformedit = {
		if (authenticateService.isLoggedIn()){
			EATUser loggedUser = authenticateService.userDomain()
			Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
			
			boolean isHisForm = false;
			boolean isValidInvitation = false;
			candidateInstanceLogged.candidateApplicationForms.each {
				if (it.id == Integer.parseInt(params.appformid)){
					isHisForm = true;
				}
			}
			
			if (isHisForm && ApplicationForm.get(params.appformid).appFormApplications[0].project.invitation.isInvitationEnabled())
				isValidInvitation = true;
			
			
			if (params.id.toLong()==candidateInstanceLogged.id && isHisForm && isValidInvitation){
				def candidateInstance = Candidate.get(params.id)
				def appFormInstance = ApplicationForm.get(params.appformid)
				
				String[] projectsSelected = new String[appFormInstance.appFormApplications.size()]
				int counter = 0;
				for (Application application: appFormInstance.appFormApplications){
					projectsSelected[counter] = Project.get(application.project.id).id
					counter++
				}
				projectsSelected.each{
					println it
				}
				if (!appFormInstance) {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'invitation.label', default: 'Invitation'), params.id])}"
					redirect(action: "list")
				}
				else {
					def invitationInstance = Invitation.get(appFormInstance.appFormApplications[0].project.invitation.id)
					return [candidateInstance: candidateInstance, applicationFormInstance: appFormInstance, projectsSelected: projectsSelected, invitationInstance: invitationInstance, oldApplicationFormInstance: appFormInstance]
				}
				
			}
			else {
				redirect(action: 'notallowed');
			}
		}
		else {
			redirect(action: 'profile');
		}
	}
	
	def appformupdate = {
		
		EATUser loggedUser = authenticateService.userDomain()
		Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
		
		if (params.id.toLong()==candidateInstanceLogged.id){
			
			def candidateInstance = Candidate.get(params.id)
			def appFormInstance = new ApplicationForm()
			def invitationInstance = Invitation.get(params.invitationid)
			def oldApplicationFormInstance = ApplicationForm.get(params.oldappformid)
			
			def projectsSelected = params.myCandidateApplicationForms
			List projSelected = new ArrayList()
			if (projectsSelected instanceof String ){
				int projectid = Integer.parseInt(projectsSelected)
				Project project = Project.get(projectid)
				println "From params user has selected: "+project.code
				projSelected.add project
			}
			else {
				projectsSelected.each{
					int projectid = Integer.parseInt(it)
					Project project = Project.get(projectid)
					println "From params user has selected: "+project.code
					projSelected.add project
				}
			}
			
			def f = request.getFile('bioFilepath')
			def f2 = request.getFile('applicationFilepath')
			
			if (!projectsSelected || projectsSelected.size()==0){
				appFormInstance.errors.rejectValue("appFormApplications","message.code","Πρέπει να επιλέξετε τουλάχιστον ένα κωδικό έργου");
				render(view: "appformedit", model: [candidateInstance: candidateInstance, applicationFormInstance: appFormInstance, projectsSelected: projectsSelected, invitationInstance: invitationInstance, oldApplicationFormInstance: oldApplicationFormInstance])
			}
			else if (f.getSize()>10485760){
				candidateInstance.errors.rejectValue("bioFilepath","message.code","Το αρχείο του βιογραφικού δεν μπορεί να είναι μεγαλύτερο από 10ΜΒ");
				render(view: "appformedit", model: [candidateInstance: candidateInstance, applicationFormInstance: appFormInstance, projectsSelected: projectsSelected, invitationInstance: invitationInstance, oldApplicationFormInstance: oldApplicationFormInstance])
			}
			else if (f2.getSize()>10485760){
				candidateInstance.errors.rejectValue("applicationFilepath","message.code","Το αρχείο του βιογραφικού δεν μπορεί να είναι μεγαλύτερο από 10ΜΒ");
				render(view: "appformedit", model: [candidateInstance: candidateInstance, applicationFormInstance: appFormInstance, projectsSelected: projectsSelected, invitationInstance: invitationInstance, oldApplicationFormInstance: oldApplicationFormInstance])
			}
			else{
				if (appFormInstance) {
					if (params.version) {
						def version = params.version.toLong()
						if (appFormInstance.version > version) {
							
							appFormInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'invitation.label', default: 'ApplicarionForm')] as Object[], "Another user has updated this Invitation while you were editing")
							render(view: "appformedit", model: [candidateInstance: candidateInstance, applicationFormInstance: appFormInstance, projectsSelected:projectsSelected, invitationInstance: invitationInstance, oldApplicationFormInstance: oldApplicationFormInstance])
							return
						}
					}
					appFormInstance.properties = params
					
					appFormInstance.bioFilepath = f.getOriginalFilename()
					appFormInstance.applicationFilepath = f2.getOriginalFilename()
					
					if (!appFormInstance.hasErrors() && appFormInstance.validate()) {
						
						//Delete previous application
						def tmp=[]
						Application.findAllByApplicationForm(oldApplicationFormInstance)?.each{
							tmp << it 
						}
						tmp.each{
							try {
								oldApplicationFormInstance.removeFromAppFormApplications(it)
								candidateInstance.removeFromCandidateApplications(it)
								it.project.removeFromProjectApplications(it)
								it.delete(flush:true)
							}
							catch (Exception e){
								e.printStackTrace()
							}
						}
						
						//Create new applications for the selected projects
						try {
							projSelected.each{
								Project project = it
								Application application = new Application()
								project.addToProjectApplications(application)
								oldApplicationFormInstance.addToAppFormApplications(application)
								candidateInstance.addToCandidateApplications(application)
								project.save(flush:true)
								oldApplicationFormInstance.save(flush:true)
								candidateInstance.save(flush:true)
								
							}
						}
						catch (Exception e){
							e.printStackTrace()
						}
						
						oldApplicationFormInstance.bioFilepath = f.getOriginalFilename()
						oldApplicationFormInstance.applicationFilepath = f2.getOriginalFilename()
						oldApplicationFormInstance.dateIssued = new Date();
						
						oldApplicationFormInstance.save(flush:true)
						
						//Save files
						String test = grailsAttributes.getApplicationContext().getResource("/").getFile().toString();
						test = test.substring(0, test.lastIndexOf(File.separator));
						File dirFile = new File(test+File.separator+"tenders-uploads");
						if (!dirFile.exists()){
							dirFile.mkdir();
						}
						
						File dirFile2 = new File(test+File.separator+"tenders-uploads/"+candidateInstance.id);
						if (!dirFile2.exists()){
							dirFile2.mkdir();
						}
						
						File dirFile3 = new File(test+File.separator+"tenders-uploads/"+candidateInstance.id+"/"+oldApplicationFormInstance.appFormApplications[0].project.invitation.id);
						if (!dirFile3.exists()){
							dirFile3.mkdir();
						}
						//Delete all old files
						for (File file : dirFile3.listFiles()){
							file.delete()
						}
						
						f.transferTo( new File(test+File.separator+"tenders-uploads/"+candidateInstance.id+File.separator+oldApplicationFormInstance.appFormApplications[0].project.invitation.id+File.separator+f.getOriginalFilename()) )
						f2.transferTo( new File(test+File.separator+"tenders-uploads/"+candidateInstance.id+File.separator+oldApplicationFormInstance.appFormApplications[0].project.invitation.id+File.separator+f2.getOriginalFilename())  )
						
						
						flash.message = "Η αίτησή σας αποθηκεύθηκε επιτυχώς"
						redirect(action: "profile")
					}
					else {
						render(view: "appformedit", model: [candidateInstance: candidateInstance, applicationFormInstance: appFormInstance, projectsSelected:projectsSelected, invitationInstance: invitationInstance, oldApplicationFormInstance: oldApplicationFormInstance])
					}
				}
			}
		}
		
		//redirect(action: 'appformshow', model:[candidateInstance: candidateInstance, appFormInstance: appFormInstance, projectsSelected:projSelected])
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_CANDIDATE"])
	def profile = {
		EATUser loggedUser = authenticateService.userDomain()
		Candidate candidateInstance = Candidate.findByUser(loggedUser)
		
		[candidateInstance: candidateInstance]
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def adminedit = {
		
		def candidateInstance = Candidate.get(params.id)
		candidateInstance.emailVerification = candidateInstance.email
		if (!candidateInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [candidateInstance: candidateInstance]
		}
	}
	
	def edit = {
		if (authenticateService.isLoggedIn()){
			EATUser loggedUser = authenticateService.userDomain()
			Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
			
			if (params.id.toLong()==candidateInstanceLogged.id){
				
				def candidateInstance = Candidate.get(params.id)
				candidateInstance.emailVerification = candidateInstance.email
				if (!candidateInstance) {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
					redirect(action: "list")
				}
				else {
					return [candidateInstance: candidateInstance]
				}
			}
			else {
				redirect(action: 'notallowed');
			}
		}
		else {
			redirect(action: 'profile');
		}
	}
	
	def listinvitations = {
		if (authenticateService.isLoggedIn()){
			EATUser loggedUser = authenticateService.userDomain()
			Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
			
			if (params.id.toLong()==candidateInstanceLogged.id){
				
				def candidateInstance = Candidate.get(params.id)
				if (!candidateInstance) {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
					redirect(action: "profile")
				}
				else {
					
					def filteredInvitationInstanceList=[]
					Invitation.list().each{
						boolean isInvitationEnabled = it.isInvitationEnabled()
						boolean hasAlreadyApplied = false;
						candidateInstance.candidateApplications.each { obj ->
							//println "here1 - "+obj.project.invitation.code
							if (obj.project.invitation.code.equals(it.code))	{
								hasAlreadyApplied = true;
							}
						}
						
						if (isInvitationEnabled && !hasAlreadyApplied)
							filteredInvitationInstanceList << it
					}
					
					return [candidateInstance: candidateInstance, invitationInstanceList: filteredInvitationInstanceList]
				}
			}
			else {
				redirect(action: 'notallowed');
			}
		}
		else {
			redirect(action: 'profile');
		}
	}
	
	def listforms = {
		if (authenticateService.isLoggedIn()){
			EATUser loggedUser = authenticateService.userDomain()
			Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
			
			if (params.id.toLong()==candidateInstanceLogged.id){
				
				def candidateInstance = Candidate.get(params.id)
				if (!candidateInstance) {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
					redirect(action: "profile")
				}
				else {
					
					def applicationFormList = candidateInstance.candidateApplicationForms
					def tmp=[]
					applicationFormList?.each{
						if (it.appFormApplications[0]?.project?.invitation?.isInvitationEnabled()){
							tmp << it
						}
					}
					
					return [candidateInstance: candidateInstance, applicationFormList: tmp]
				}
			}
			else {
				redirect(action: 'notallowed');
			}
		}
		else {
			redirect(action: 'profile');
		}
	}
	
	
	
	def changepasswd = {
		if (authenticateService.isLoggedIn()){
			EATUser loggedUser = authenticateService.userDomain()
			Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
			
			def changePasswordInfo = new ChangePasswordInfo()
			changePasswordInfo.properties = params
			
			if (params.id.toLong()==candidateInstanceLogged.id){
				
				def candidateInstance = Candidate.get(params.id)
				if (!candidateInstance) {
					flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
					redirect(action: "list")
				}
				else {
					return [candidateInstance: candidateInstance, changePasswordInfo: changePasswordInfo]
				}
			}
			else {
				redirect(action: 'notallowed');
			}
		}
		else {
			redirect(action: 'profile');
		}
	}
	
	def updatepasswd = {
		EATUser loggedUser = authenticateService.userDomain()
		Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
		
		def changePasswordInfo = new ChangePasswordInfo(params)
		
		if (params.id.toLong()==candidateInstanceLogged.id){
			//print loggedUser.passwd
			def oldPasswd = authenticateService.passwordEncoder(params.oldPasswd)
			if (!loggedUser.passwd.equals(oldPasswd)){
				changePasswordInfo.errors.rejectValue("oldPasswd","message.code","Ο παλιός κωδικός δεν είναι σωστός");
				render(view: "changepasswd", model: [candidateInstance: candidateInstanceLogged, changePasswordInfo: changePasswordInfo])
			}
			else if (!changePasswordInfo.validate()){
				render(view: "changepasswd", model: [candidateInstance: candidateInstanceLogged, changePasswordInfo: changePasswordInfo])
			}
			else {
				
				def newEncodedPass = authenticateService.passwordEncoder(params.newPasswd)
				EATUser theUser = EATUser.get(loggedUser.id)
				theUser.passwd = newEncodedPass
				theUser.save()
				userCache.removeUserFromCache(theUser.username)
				flash.message = "Ο κωδικός σας άλλαξε επιτυχώς"
				redirect(action: "profile")
			}
		}
		else {
			redirect(action: 'notallowed');
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def adminupdate = {
		
		def candidateInstance = Candidate.get(params.id)
		if (candidateInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (candidateInstance.version > version) {
					
					candidateInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'candidate.label', default: 'Candidate')] as Object[], "Another user has updated this Candidate while you were editing")
					render(view: "edit", model: [candidateInstance: candidateInstance])
					return
				}
			}
			candidateInstance.properties = params
			if (!candidateInstance.hasErrors() && candidateInstance.save(flush: true)) {
				
				if (candidateInstance.candidateEvaluation){
					
				}
				else {
					CandidateEvaluation evaluation = new CandidateEvaluation(params["candidateEvaluation"])
					//evaluation.candidateEvalLevel = params.candidateEvaluationLevel
					//evaluation.notes = params.candidateEvaluationNotes
					//evaluation.save(flush: true)
					candidateInstance.candidateEvaluation = evaluation
					candidateInstance.save(flush: true)
				}
				
				flash.message = "Τα στοιχεία αποθηκεύτηκαν επιτυχώς"
				render(view: "show", model: [candidateInstance: candidateInstance])
			}
			else {
				render(view: "adminedit", model: [candidateInstance: candidateInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
			redirect(action: "list")
		}
	}
	
	def update = {
		EATUser loggedUser = authenticateService.userDomain()
		Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
		
		if (params.id.toLong()==candidateInstanceLogged.id){
			
			def candidateInstance = Candidate.get(params.id)
			if (candidateInstance) {
				if (params.version) {
					def version = params.version.toLong()
					if (candidateInstance.version > version) {
						
						candidateInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'candidate.label', default: 'Candidate')] as Object[], "Another user has updated this Candidate while you were editing")
						render(view: "edit", model: [candidateInstance: candidateInstance])
						return
					}
				}
				candidateInstance.properties = params
				if (!candidateInstance.hasErrors() && candidateInstance.save(flush: true)) {
					flash.message = "Τα στοιχεία αποθηκεύτηκαν επιτυχώς"
					redirect(action: "profile")
				}
				else {
					render(view: "edit", model: [candidateInstance: candidateInstance])
				}
			}
			else {
				flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
				redirect(action: "list")
			}
		}
		else {
			redirect(action: 'notallowed');
		}
	}
	
	def delete = {
		def candidateInstance = Candidate.get(params.id)
		if (candidateInstance) {
			try {
				candidateInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'candidate.label', default: 'Candidate'), params.id])}"
			redirect(action: "list")
		}
	}
	
	private static byte[] getBytesFromFile(File file) throws IOException {
		
		InputStream is = new FileInputStream(file);
		//System.out.println("\nDEBUG: FileInputStream is " + file);
		
		// Get the size of the file
		long length = file.length();
		//System.out.println("DEBUG: Length of " + file + " is " + length + "\n");
		
		/*
		 * You cannot create an array using a long type. It needs to be an int
		 * type. Before converting to an int type, check to ensure that file is
		 * not loarger than Integer.MAX_VALUE;
		 */
		if (length > Integer.MAX_VALUE) {
			System.out.println("File is too large to process");
			return null;
		}
		
		// Create the byte array to hold the data
		byte[] bytes = new byte[(int)length];
		
		// Read in the bytes
		int offset = 0;
		int numRead = 0;
		while ( (offset < bytes.length)
		&&
		( (numRead=is.read(bytes, offset, bytes.length-offset)) >= 0) ) {
			
			offset += numRead;
			
		}
		
		// Ensure all the bytes have been read in
		if (offset < bytes.length) {
			throw new IOException("Could not completely read file " + file.getName());
		}
		
		is.close();
		return bytes;
	}
	
	private sendNotificationEmail(Candidate candidateInstance, String password, String url){
		File tplFile = grailsAttributes.getApplicationContext().getResource( File.separator + "WEB-INF" + File.separator + "email_notification.gtpl").getFile();
		def binding = ["candidateInstance": candidateInstance, "password": password, "url": url]
		def engine = new SimpleTemplateEngine()
		def template = engine.createTemplate(tplFile).make(binding)
		def body = template.toString()
		
		def email = [
					to: [candidateInstance.email], // "to" expects a List
					subject: "Επιβεβαίωση υποβολής αίτησης στο Εθνικό Κέντρο Τεκμηρίωσης - Δημιουργία Χρήστη",
					text: 	body
				]
		
		try {
			emailerService.sendEmail(email)
		} catch (MailException ex) {
			log.error("Failed to send emails", ex)
			return false
		}
		return true
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER", "ROLE_CANDIDATE"])
	def downloadbio = {
		if (authenticateService.isLoggedIn()){
			EATUser loggedUser = authenticateService.userDomain()
			Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
			
			def principal = authenticateService.principal()
			//println principal.getUsername()//get username
			def authorities = loggedUser.authorities//get authorities
			boolean isAdmin = false;
			authorities.each{
				def tmp = it
				//println it
				if (tmp.authority.equals("ROLE_SYS_ADMIN") || tmp.authority.equals("ROLE_ADMIN") || tmp.authority.equals("ROLE_REVIEWER")){
					isAdmin = true;
				}
			}
			
			boolean isHisForm = false;
			boolean isValidInvitation = false;
			if (!isAdmin)
				candidateInstanceLogged.candidateApplicationForms.each {
					if (it.id == Integer.parseInt(params.appformid)){
						isHisForm = true;
					}
				}
			
			if (isHisForm && ApplicationForm.get(params.appformid).appFormApplications[0].project.invitation.isInvitationEnabled())
				isValidInvitation = true;
			
			if (isAdmin || (params.id.toLong()==candidateInstanceLogged.id && isHisForm && isValidInvitation)){
				def candidateInstance = Candidate.get(params.id)
				
				def appFormInstance = ApplicationForm.get(params.appformid)
				String test = grailsAttributes.getApplicationContext().getResource("/").getFile().toString();
				test = test.substring(0, test.lastIndexOf(File.separator));
				File bioFile = new File(test+File.separator+"tenders-uploads/"+candidateInstance.id+File.separator+appFormInstance.appFormApplications[0].project.invitation.id+File.separator+appFormInstance.bioFilepath);
				
				response.setContentType( "application-xdownload")
				response.setHeader("Content-Disposition", "attachment; filename=${appFormInstance.bioFilepath}")
				response.getOutputStream() << new ByteArrayInputStream( getBytesFromFile(bioFile))
				
			}
			else {
				redirect(action: 'notallowed');
			}
		}
		else {
			redirect(action: 'profile');
		}
		
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER", "ROLE_CANDIDATE"])
	def downloadapp = {
		if (authenticateService.isLoggedIn()){
			EATUser loggedUser = authenticateService.userDomain()
			Candidate candidateInstanceLogged = Candidate.findByUser(loggedUser)
			
			def principal = authenticateService.principal()
			//println principal.getUsername()//get username
			def authorities = loggedUser.authorities//get authorities
			boolean isAdmin = false;
			authorities.each{
				def tmp = it
				//println it
				if (tmp.authority.equals("ROLE_SYS_ADMIN") || tmp.authority.equals("ROLE_ADMIN") || tmp.authority.equals("ROLE_REVIEWER")){
					isAdmin = true;
				}
			}
			
			boolean isHisForm = false;
			boolean isValidInvitation = false;
			if (!isAdmin)
				candidateInstanceLogged.candidateApplicationForms.each {
					if (it.id == Integer.parseInt(params.appformid)){
						isHisForm = true;
					}
				}
			
			if (isHisForm && ApplicationForm.get(params.appformid).appFormApplications[0].project.invitation.isInvitationEnabled())
				isValidInvitation = true;
			
			if (isAdmin || (params.id.toLong()==candidateInstanceLogged.id && isHisForm && isValidInvitation)){
				def candidateInstance = Candidate.get(params.id)
				
				def appFormInstance = ApplicationForm.get(params.appformid)
				String test = grailsAttributes.getApplicationContext().getResource("/").getFile().toString();
				test = test.substring(0, test.lastIndexOf(File.separator));
				File applicationFilepath = new File(test+File.separator+"tenders-uploads/"+candidateInstance.id+File.separator+appFormInstance.appFormApplications[0].project.invitation.id+File.separator+appFormInstance.applicationFilepath);
				
				response.setContentType( "application-xdownload")
				response.setHeader("Content-Disposition", "attachment; filename=${appFormInstance.applicationFilepath}")
				response.getOutputStream() << new ByteArrayInputStream( getBytesFromFile(applicationFilepath))
				
			}
			else {
				redirect(action: 'notallowed');
			}
		}
		else {
			redirect(action: 'profile');
		}
		
	}
	
}
