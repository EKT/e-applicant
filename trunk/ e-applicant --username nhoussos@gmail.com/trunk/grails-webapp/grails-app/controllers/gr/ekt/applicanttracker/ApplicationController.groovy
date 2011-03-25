package gr.ekt.applicanttracker

import java.io.File;
import java.util.Date;

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;
import org.springframework.mail.MailException;

import groovy.text.SimpleTemplateEngine;

class ApplicationController {
	
	static allowedMethods = [save: "POST", update: "POST"]
	
	EmailerService emailerService
	ExcelExporterService excelExporterService
	
	def index = {
		redirect(action: "list", params: params)
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def list = {
		params.max = Math.min(params.max ? params.int('max') : 50, 100)
		def selectedProject = params.selectedProject
		//println selectedProject
		def appList = Application.list(params)
		def totalItems = Application.count()
		Project proj = Project.findByCode(selectedProject)
		if (selectedProject && !selectedProject.equals("all") && !selectedProject.equals("")){
			def c = Application.createCriteria()
			appList = c.list(
					max: params.max,
					offset: params.offset,
					sort: params.sort,
					order: params.order) {
						projects {
							eq('code',proj.code)
						}
					}
			
			/*appList.each {  
				Application apple = Application.get(it.id)
				print(apple.lastname + " : "+apple.projects.size())
				def projects = apple.projects
				projects.eachWithIndex { val, i -> 
					print "("+(i+1)+") "+val?.code;	
				}
				println ""
			}*/

			totalItems = appList.totalCount
		}
		
		
		
		//println totalItems
		
		[applicationInstanceList: appList, applicationInstanceTotal: totalItems]
	}
	
	def create = {
		def applicationInstance = new Application()
		if (params.invid != null){
			applicationInstance.properties = params
			
			Invitation invitation = Invitation.get(params.invid)
			if (invitation == null){
				redirect(action: 'list');
			}
			else if (!invitation.isInvitationEnabled()){
				redirect(action: 'disabled');
			}
			else {
				applicationInstance.invitation = invitation
				return [applicationInstance: applicationInstance]
			}
		}
		else {
			redirect(action: 'list');
		}
	}
	
	def disabled = {
		
	}
	
	def save = {
		def applicationInstance = new Application(params)
		
		Invitation invitation = Invitation.get(params.invid)
		applicationInstance.invitation = invitation
		
		def f = request.getFile('bioFile')
		if(!f.empty && f.getSize()>0) {
			applicationInstance.bioFilepath = f.getOriginalFilename()
		}
		def f2 = request.getFile('appFile')
		if(!f2.empty && f2.getSize()>0) {
			applicationInstance.applicationFilepath = f2.getOriginalFilename()
		}
		
		if (f.getSize()>10485760){
			applicationInstance.errors.rejectValue("bioFilepath","message.code","Το αρχείο του βιογραφικού δεν μπορεί να είναι μεγαλύτερο από 10ΜΒ");
			render(view: "create", model: [applicationInstance: applicationInstance])
		}
		else if (f2.getSize()>10485760){
			applicationInstance.errors.rejectValue("applicationFilepath","message.code","Το αρχείο του βιογραφικού δεν μπορεί να είναι μεγαλύτερο από 10ΜΒ");
			render(view: "create", model: [applicationInstance: applicationInstance])
		}
		else {
			if (applicationInstance.validate()) {
				
				applicationInstance.dateIssued = new Date();
				
				applicationInstance.save(flush: true);
				//sendNotificationEmail(applicationInstance);
				
				//System.out.println(grailsAttributes.getApplicationCont.get.getResource("/").getFile().toString() );
				String test = grailsAttributes.getApplicationContext().getResource("/").getFile().toString();
				test = test.substring(0, test.lastIndexOf(File.separator));
				File dirFile = new File(test+File.separator+"tenders-uploads");
				if (!dirFile.exists()){
					dirFile.mkdir();
				}
				
				File dirFile2 = new File(test+File.separator+"tenders-uploads/"+applicationInstance.id);
				if (!dirFile2.exists()){
					dirFile2.mkdir();
				}
				
				f.transferTo( new File(test+File.separator+"tenders-uploads/"+applicationInstance.id+File.separator+f.getOriginalFilename()) )
				f2.transferTo( new File(test+File.separator+"tenders-uploads/"+applicationInstance.id+File.separator+f2.getOriginalFilename())  )
				
				flash.message = "${message(code: 'default.created.message', args: [message(code: 'application.label', default: 'Application'), applicationInstance.id])}"
				//redirect(action: "show", id: applicationInstance.id, method: "POST")
				render(view: "success", model: [applicationInstance: applicationInstance])
			}
			else {
				render(view: "create", model: [applicationInstance: applicationInstance])
			}
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def show = {
		def applicationInstance = Application.get(params.id)
		if (!applicationInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
			redirect(action: "list")
		}
		else {
			[applicationInstance: applicationInstance]
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def downloadbio = {
		def applicationInstance = Application.get(params.id)
		String test = grailsAttributes.getApplicationContext().getResource("/").getFile().toString();
		test = test.substring(0, test.lastIndexOf(File.separator));
		File bioFile = new File(test+File.separator+"tenders-uploads"+File.separator+applicationInstance.id+File.separator+applicationInstance.bioFilepath);
		
		response.setContentType( "application-xdownload")
		response.setHeader("Content-Disposition", "attachment; filename=${applicationInstance.bioFilepath}")
		response.getOutputStream() << new ByteArrayInputStream( getBytesFromFile(bioFile))
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def downloadapp = {
		def applicationInstance = Application.get(params.id)
		String test = grailsAttributes.getApplicationContext().getResource("/").getFile().toString();
		test = test.substring(0, test.lastIndexOf(File.separator));
		File bioFile = new File(test+File.separator+"tenders-uploads"+File.separator+applicationInstance.id+File.separator+applicationInstance.applicationFilepath);
		
		response.setContentType( "application-xdownload")
		response.setHeader("Content-Disposition", "attachment; filename=${applicationInstance.applicationFilepath}")
		response.getOutputStream() << new ByteArrayInputStream( getBytesFromFile(bioFile))
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def excel = {
		params.max = 10000
		def applicationList = Application.list(params)
		def selectedProject = params.selectedProject
		
		def skillList = []
		def wishSkillList = []
		
		if (selectedProject && !selectedProject.equals("all") && !selectedProject.equals("")){
			def c = Application.createCriteria()
			applicationList = c.list(
					max: params.max,
					offset: params.offset,
					sort: params.sort,
					order: params.order) {
						projects {
							eq('code',selectedProject)
						}
					}
			
			Project tmpProject = Project.findByCode(selectedProject)
			skillList = tmpProject.skills
			wishSkillList = tmpProject.wishSkills
		}
		
		
		String test = grailsAttributes.getApplicationContext().getResource("/").getFile().toString();
		test = test.substring(0, test.lastIndexOf(File.separator));
		File dirFile = new File(test+File.separator+"tenders_excel_reports");
		if (!dirFile.exists()){
			dirFile.mkdir();
		}
		
		String filepath = excelExporterService.exportListInExcel(applicationList, test+File.separator+"tenders_excel_reports", skillList, wishSkillList)
		
		File reportFile = new File(filepath)
		
		response.setContentType( "application-xdownload")
		response.setHeader("Content-Disposition", "attachment filename=report.xls")
		response.getOutputStream() << new ByteArrayInputStream( getBytesFromFile(reportFile))
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def edit = {
		def applicationInstance = Application.get(params.id)
		applicationInstance.emailVerification = applicationInstance.email
		if (!applicationInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [applicationInstance: applicationInstance]
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def update = {
		def applicationInstance = Application.get(params.id)
		applicationInstance.isEdit = true
		applicationInstance.emailVerification = applicationInstance.email
		if (applicationInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (applicationInstance.version > version) {
					
					applicationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'application.label', default: 'Application')] as Object[], "Another user has updated this Application while you were editing")
					render(view: "edit", model: [applicationInstance: applicationInstance])
					return
				}
			}
			applicationInstance.properties = params
			if (!applicationInstance.hasErrors() && applicationInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'application.label', default: 'Application'), applicationInstance.id])}"
				redirect(action: "show", id: applicationInstance.id)
			}
			else {
				render(view: "edit", model: [applicationInstance: applicationInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
			redirect(action: "list")
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
	def delete = {
		def applicationInstance = Application.get(params.id)
		
		//delete his files as well
		
		if (applicationInstance) {
			try {
				applicationInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
			redirect(action: "list")
		}
	}
	
	private sendNotificationEmail(Application application){
		File tplFile = grailsAttributes.getApplicationContext().getResource( File.separator + "WEB-INF" + File.separator + "email_notification.gtpl").getFile();
		def binding = ["application": application] 
		def engine = new SimpleTemplateEngine()
		def template = engine.createTemplate(tplFile).make(binding)
		def body = template.toString()
		
		def email = [
					to: [application.email], // "to" expects a List
					subject: "Επιβεβαίωση υποβολής αίτησης στο Εθνικό Κέντρο Τεκμηρίωσης",
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
	
	private static byte[] getBytesFromFile(File file) throws IOException {
		
		InputStream is = new FileInputStream(file);
		System.out.println("\nDEBUG: FileInputStream is " + file);
		
		// Get the size of the file
		long length = file.length();
		System.out.println("DEBUG: Length of " + file + " is " + length + "\n");
		
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
}
