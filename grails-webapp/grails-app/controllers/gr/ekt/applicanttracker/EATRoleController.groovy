package gr.ekt.applicanttracker
class EATRoleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [EATRoleInstanceList: EATRole.list(params), EATRoleInstanceTotal: EATRole.count()]
    }

    def create = {
        def EATRoleInstance = new EATRole()
        EATRoleInstance.properties = params
        return [EATRoleInstance: EATRoleInstance]
    }

    def save = {
        def EATRoleInstance = new EATRole(params)
        if (EATRoleInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'EATRole.label', default: 'EATRole'), EATRoleInstance.id])}"
            redirect(action: "show", id: EATRoleInstance.id)
        }
        else {
            render(view: "create", model: [EATRoleInstance: EATRoleInstance])
        }
    }

    def show = {
        def EATRoleInstance = EATRole.get(params.id)
        if (!EATRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'EATRole.label', default: 'EATRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            [EATRoleInstance: EATRoleInstance]
        }
    }

    def edit = {
        def EATRoleInstance = EATRole.get(params.id)
        if (!EATRoleInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'EATRole.label', default: 'EATRole'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [EATRoleInstance: EATRoleInstance]
        }
    }

    def update = {
        def EATRoleInstance = EATRole.get(params.id)
        if (EATRoleInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (EATRoleInstance.version > version) {
                    
                    EATRoleInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'EATRole.label', default: 'EATRole')] as Object[], "Another user has updated this EATRole while you were editing")
                    render(view: "edit", model: [EATRoleInstance: EATRoleInstance])
                    return
                }
            }
            EATRoleInstance.properties = params
            if (!EATRoleInstance.hasErrors() && EATRoleInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'EATRole.label', default: 'EATRole'), EATRoleInstance.id])}"
                redirect(action: "show", id: EATRoleInstance.id)
            }
            else {
                render(view: "edit", model: [EATRoleInstance: EATRoleInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'EATRole.label', default: 'EATRole'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def EATRoleInstance = EATRole.get(params.id)
        if (EATRoleInstance) {
            try {
                EATRoleInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'EATRole.label', default: 'EATRole'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'EATRole.label', default: 'EATRole'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'EATRole.label', default: 'EATRole'), params.id])}"
            redirect(action: "list")
        }
    }
}
