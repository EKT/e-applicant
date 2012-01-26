package gr.ekt.applicanttracker

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

class ApplicationController {
	
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def index = {
		redirect(action: "list", params: params)
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[applicationInstanceList: Application.list(params), applicationInstanceTotal: Application.count()]
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def create = {
		def applicationInstance = new Application()
		applicationInstance.properties = params
		return [applicationInstance: applicationInstance]
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def save = {
		def applicationInstance = new Application(params)
		if (applicationInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'application.label', default: 'Application'), applicationInstance.id])}"
			redirect(action: "show", id: applicationInstance.id)
		}
		else {
			render(view: "create", model: [applicationInstance: applicationInstance])
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
	def edit = {
		def applicationInstance = Application.get(params.id)
		def candidateInstance = Candidate.get(params.candidateID)
		if (!applicationInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'application.label', default: 'Application'), params.id])}"
			redirect(action: "list")
		}
		else {
			
			def mySkills = []//new ArrayList<Skill>()
			def shouldSave = false
			def shouldInterview = true;
			if (applicationInstance.applicationSkills)
				mySkills = applicationInstance.applicationSkills
			else {
				def appForm = applicationInstance.applicationForm;
				shouldSave = true
				appForm.appFormApplications.each {
					it.applicationSkills.eachWithIndex() { obj, i ->
						//if (!mySkills.containts(obj)){
						mySkills << obj
						//}
					}
				}
			}
			
			if (applicationInstance.applicationInterview != null)
				shouldInterview = false;
			
			return [applicationInstance: applicationInstance, candidateInstance: candidateInstance, mySkills: mySkills, shouldSave: shouldSave, shouldInterview: shouldInterview]
		}
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def update = {
		def applicationInstance = Application.get(params.id)
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
				
				if (applicationInstance.applicationEvaluation){
					
				}
				else {
					ApplicationEvaluation evaluation = new ApplicationEvaluation(params["applicationEvaluation"])
					//evaluation.candidateEvalLevel = params.candidateEvaluationLevel
					//evaluation.notes = params.candidateEvaluationNotes
					//evaluation.save(flush: true)
					applicationInstance.applicationEvaluation = evaluation
					
					EATResult result = new EATResult(params["applicationResult"])
					applicationInstance.applicationResult = result
					
					applicationInstance.save(flush: true)
				}
				
				
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'application.label', default: 'Application'), applicationInstance.id])}"
				
				redirect(controller: "applicationForm", action: "show", params: ['id': applicationInstance.applicationForm.id])
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
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
	def delete = {
		def applicationInstance = Application.get(params.id)
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
}
