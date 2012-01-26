package gr.ekt.applicanttracker

import java.io.File;

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;
import org.hibernate.criterion.CriteriaSpecification;

class ApplicationFormController {
	
	ExcelExporterService excelExporterService
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def index = {
		redirect(action: "list", params: params)
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def list = {
		params.max = Math.min(params.max ? params.int('max') : 100, 100)
		
		def selectedProject = params.selectedProject
		def selectedInvitation = params.selectedInvitation
		def appFormList = ApplicationForm.list(params)
		def totalItems = ApplicationForm.count()
		
		if (selectedProject && !selectedProject.equals("all") && !selectedProject.equals("")){
			Project proj = Project.findByCode(selectedProject)
			
			def d = Application.createCriteria()
			def applications = d.list() {
				project {
					eq('code',proj.code)
				}
			}
			def tmp=[]
			applications?.each{
				tmp << it.id
			}
			
			if (tmp.size()==0){
				appFormList = []
				totalItems = 0
			}
			else {
				def c = ApplicationForm.createCriteria()
				appFormList = c.list(
						max: params.max,
						offset: params.offset,
						sort: params.sort,
						order: params.order) {
							appFormApplications{
								'in'('id',tmp)
							}
						}
				
				totalItems = appFormList.totalCount
			}
		}
		else if (selectedProject && selectedProject.equals("all") && !selectedInvitation.equals("all")){
			Invitation invitation = Invitation.get(Integer.parseInt(selectedInvitation))
			def projects = invitation.projects
			
			def allcodes=[]
			projects?.each{
				allcodes << it.code
			}
					
			if (!params.sort) params.sort = "id"
			
			def c = ApplicationForm.createCriteria()
			def appFormList2 = c.listDistinct(
					) {
						appFormApplications{
							project {
								'in'('code',allcodes)
							}
						}
						order (params.sort, "asc")
					}
			totalItems = appFormList2.size()
			if (!params.offset) params.offset=0; else params.offset = Integer.parseInt(params.offset)
			appFormList.clear()
			for (int i=params.offset; i< Math.min(params.offset+params.max, totalItems); i++){
				appFormList.add(appFormList2.get(i))
			}
		}
		
		[applicationFormInstanceList: appFormList, applicationFormInstanceTotal: totalItems, selectedProject: selectedProject, selectedInvitation: selectedInvitation]
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def create = {
		def applicationFormInstance = new ApplicationForm()
		applicationFormInstance.properties = params
		return [applicationFormInstance: applicationFormInstance]
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def save = {
		def applicationFormInstance = new ApplicationForm(params)
		if (applicationFormInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'applicationForm.label', default: 'ApplicationForm'), applicationFormInstance.id])}"
			redirect(action: "show", id: applicationFormInstance.id)
		}
		else {
			render(view: "create", model: [applicationFormInstance: applicationFormInstance])
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def show = {
		def applicationFormInstance = ApplicationForm.get(params.id)
		if (!applicationFormInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'applicationForm.label', default: 'ApplicationForm'), params.id])}"
			redirect(action: "list")
		}
		else {
			[applicationFormInstance: applicationFormInstance]
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def edit = {
		def applicationFormInstance = ApplicationForm.get(params.id)
		if (!applicationFormInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'applicationForm.label', default: 'ApplicationForm'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [applicationFormInstance: applicationFormInstance]
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def update = {
		def applicationFormInstance = ApplicationForm.get(params.id)
		if (applicationFormInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (applicationFormInstance.version > version) {
					
					applicationFormInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'applicationForm.label', default: 'ApplicationForm')] as Object[], "Another user has updated this ApplicationForm while you were editing")
					render(view: "edit", model: [applicationFormInstance: applicationFormInstance])
					return
				}
			}
			applicationFormInstance.properties = params
			if (!applicationFormInstance.hasErrors() && applicationFormInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'applicationForm.label', default: 'ApplicationForm'), applicationFormInstance.id])}"
				redirect(action: "show", id: applicationFormInstance.id)
			}
			else {
				render(view: "edit", model: [applicationFormInstance: applicationFormInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'applicationForm.label', default: 'ApplicationForm'), params.id])}"
			redirect(action: "list")
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def delete = {
		def applicationFormInstance = ApplicationForm.get(params.id)
		if (applicationFormInstance) {
			try {
				applicationFormInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'applicationForm.label', default: 'ApplicationForm'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'applicationForm.label', default: 'ApplicationForm'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'applicationForm.label', default: 'ApplicationForm'), params.id])}"
			redirect(action: "list")
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def excel = {
		params.max = 10000
		def appFormList = ApplicationForm.list(params)
		def selectedProject = params.selectedProject
		def selectedInvitation = params.selectedInvitation
		
		def skillList = []
		def wishSkillList = []
		
		if (selectedProject && !selectedProject.equals("all") && !selectedProject.equals("")){
			Project proj = Project.findByCode(selectedProject)
			
			def d = Application.createCriteria()
			def applications = d.list() {
				project {
					eq('code',proj.code)
				}
			}
			def tmp=[]
			applications?.each{
				tmp << it.id
			}
			
			if (tmp.size()==0){
				appFormList = []
				totalItems = 0
			}
			else {
				def c = ApplicationForm.createCriteria()
				appFormList = c.list(
						max: params.max,
						offset: params.offset,
						sort: params.sort,
						order: params.order) {
							appFormApplications{
								'in'('id',tmp)
							}
						}
				
				Project tmpProject = Project.findByCode(selectedProject)
				skillList = tmpProject.skills
				wishSkillList = tmpProject.wishSkills
			}
		}
		else if (selectedProject && selectedProject.equals("all") && !selectedInvitation.equals("all")){
			Invitation invitation = Invitation.get(selectedInvitation)
			def projects = invitation.projects
			
			def allcodes=[]
			projects?.each{
				allcodes << it.code
			}
			
			if (!params.sort) params.sort = "id"
			
			def c = ApplicationForm.createCriteria()
			def appFormList2 = c.listDistinct(
					) {
						appFormApplications{
							project {
								'in'('code',allcodes)
							}
						}
						order (params.sort, "asc")
					}
			int totalItems = appFormList2.size()
			if (!params.offset) params.offset=0; else params.offset = Integer.parseInt(params.offset)
			appFormList.clear()
			for (int i=params.offset; i< totalItems; i++){
				appFormList.add(appFormList2.get(i))
			}

		}
		
		String test = grailsAttributes.getApplicationContext().getResource("/").getFile().toString();
		test = test.substring(0, test.lastIndexOf(File.separator));
		File dirFile = new File(test+File.separator+"tenders_excel_reports");
		if (!dirFile.exists()){
			dirFile.mkdir();
		}
		
		String filepath = excelExporterService.exportListInExcel(appFormList, test+File.separator+"tenders_excel_reports", skillList, wishSkillList, selectedProject)
		
		File reportFile = new File(filepath)
		
		response.setContentType( "application-xdownload")
		response.setHeader("Content-Disposition", "attachment filename=report.xls")
		response.getOutputStream() << new ByteArrayInputStream( getBytesFromFile(reportFile))
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
