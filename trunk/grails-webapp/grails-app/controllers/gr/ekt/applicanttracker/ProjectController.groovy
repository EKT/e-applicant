package gr.ekt.applicanttracker

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

class ProjectController {

    static allowedMethods = [save: "POST", update: "POST"]

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def index = {
        redirect(action: "list", params: params)
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 100, 100)
		
		def projectList = Project.list()

		if (params['selectedInvitation'] && !params['selectedInvitation'].equals("all")){
			Invitation tmp = Invitation.get(Integer.parseInt(params['selectedInvitation']));
			projectList = Project.findAllByInvitation (tmp)
		}
		
        [projectInstanceList: projectList, projectInstanceTotal: projectList.size(), selectedInvitation: params['selectedInvitation']]
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def create = {
        def projectInstance = new Project()
        projectInstance.properties = params
        return [projectInstance: projectInstance]
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def save = {
        def projectInstance = new Project(params)
		def invitation = projectInstance.invitation
		invitation.addToProjects(projectInstance)
		
        if (projectInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])}"
            redirect(action: "show", id: projectInstance.id)
        }
        else {
            render(view: "create", model: [projectInstance: projectInstance])
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def show = {
        def projectInstance = Project.get(params.id)
        if (!projectInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
            redirect(action: "list")
        }
        else {
            [projectInstance: projectInstance]
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def edit = {
        def projectInstance = Project.get(params.id)
        if (!projectInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [projectInstance: projectInstance]
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def update = {
        def projectInstance = Project.get(params.id)
        if (projectInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (projectInstance.version > version) {
                    
                    projectInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'project.label', default: 'Project')] as Object[], "Another user has updated this Project while you were editing")
                    render(view: "edit", model: [projectInstance: projectInstance])
                    return
                }
            }
            projectInstance.properties = params
            if (!projectInstance.hasErrors() && projectInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'project.label', default: 'Project'), projectInstance.id])}"
                redirect(action: "show", id: projectInstance.id)
            }
            else {
                render(view: "edit", model: [projectInstance: projectInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
            redirect(action: "list")
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def delete = {
        def projectInstance = Project.get(params.id)
        if (projectInstance) {
            try {
                projectInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'project.label', default: 'Project'), params.id])}"
            redirect(action: "list")
        }
    }
}
