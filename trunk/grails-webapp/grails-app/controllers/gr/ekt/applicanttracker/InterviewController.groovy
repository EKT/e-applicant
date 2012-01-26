package gr.ekt.applicanttracker

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

class InterviewController {

    static allowedMethods = [save: "POST", update: "POST"]

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
    def index = {
        redirect(action: "list", params: params)
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [interviewInstanceList: Interview.list(params), interviewInstanceTotal: Interview.count()]
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
    def create = {
		Application applicationInstance = Application.get(params.applicationID)
		Candidate candidateInstance = Candidate.get(params.candidateID)
        def interviewInstance = new Interview()
        interviewInstance.properties = params
        return [interviewInstance: interviewInstance, candidateInstance: candidateInstance, applicationInstance: applicationInstance]
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
    def save = {
        def interviewInstance = new Interview(params)
		Application applicationInstance = Application.get(params.applicationID)
		Candidate candidateInstance = Candidate.get(params.candidateID)
		
		interviewInstance.interviewApplication = applicationInstance
		interviewInstance.interviewCandidate = candidateInstance
		
		if (interviewInstance.validate()){
			
			//interviewInstance.save(flush: true)
			candidateInstance.addToCandidateInterviews(interviewInstance)
			applicationInstance.applicationInterview = interviewInstance
			applicationInstance.save(flush: true)
			
			//interviewInstance.save(flush: true)
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'interview.label', default: 'Interview'), interviewInstance.id])}"
            
			
			
			
			
			redirect(controller: "applicationForm", action: "show", id: applicationInstance?.applicationForm?.id)
        }
        else {
            render(view: "create", model: [interviewInstance: interviewInstance, candidateInstance: candidateInstance, applicationInstance: applicationInstance])
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
    def show = {
        def interviewInstance = Interview.get(params.id)
        if (!interviewInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'interview.label', default: 'Interview'), params.id])}"
            redirect(action: "list")
        }
        else {
            [interviewInstance: interviewInstance]
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
    def edit = {
        def interviewInstance = Interview.get(params.id)
		
		if (!interviewInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'interview.label', default: 'Interview'), params.id])}"
            redirect(action: "list")
        }
        else {
	
            return [interviewInstance: interviewInstance, candidateInstance: interviewInstance.interviewCandidate, applicationInstance: interviewInstance.interviewApplication]
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
    def update = {
        def interviewInstance = Interview.get(params.id)
        if (interviewInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (interviewInstance.version > version) {
                    
                    interviewInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'interview.label', default: 'Interview')] as Object[], "Another user has updated this Interview while you were editing")
                    render(view: "edit", model: [interviewInstance: interviewInstance, candidateInstance: interviewInstance.interviewCandidate, applicationInstance: interviewInstance.interviewApplication])
                    return
                }
            }
            interviewInstance.properties = params
            if (!interviewInstance.hasErrors() && interviewInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'interview.label', default: 'Interview'), interviewInstance.id])}"
                redirect(action: "list")
            }
            else {
                render(view: "edit", model: [interviewInstance: interviewInstance, candidateInstance: interviewInstance.interviewCandidate, applicationInstance: interviewInstance.interviewApplication])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'interview.label', default: 'Interview'), params.id])}"
            redirect(action: "list")
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
    def delete = {
        def interviewInstance = Interview.get(params.id)
        if (interviewInstance) {
            try {
				Application applicationInstance = Application.get(interviewInstance.interviewApplication.id)
				applicationInstance.setApplicationInterview(null)
				//interviewInstance.interviewCandidate.removeFromCandidateInterviews(interviewInstance)
				applicationInstance.save(flush: true)

				//interviewInstance.interviewCandidate?.save(flush:true)
                interviewInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'interview.label', default: 'Interview'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'interview.label', default: 'Interview'), params.id])}"
                redirect(action: "list")
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'interview.label', default: 'Interview'), params.id])}"
            redirect(action: "list")
        }
    }
}
