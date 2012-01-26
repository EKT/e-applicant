package gr.ekt.applicanttracker
class EATUserController {

	def authenticateService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [EATUserInstanceList: EATUser.list(params), EATUserInstanceTotal: EATUser.count()]
    }

    def create = {
        def EATUserInstance = new EATUser()
        EATUserInstance.properties = params
        return [EATUserInstance: EATUserInstance]
    }

    def save = {
		params.passwd = authenticateService.passwordEncoder(params.passwd)
        def EATUserInstance = new EATUser(params)
        if (EATUserInstance.save(flush: true)) {
			println params.authorities.size()
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'EATUser.label', default: 'EATUser'), EATUserInstance.id])}"
            redirect(action: "show", id: EATUserInstance.id)
        }
        else {
            render(view: "create", model: [EATUserInstance: EATUserInstance])
        }
    }

    def show = {
        def EATUserInstance = EATUser.get(params.id)
        if (!EATUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'EATUser.label', default: 'EATUser'), params.id])}"
            redirect(action: "list")
        }
        else {
            [EATUserInstance: EATUserInstance]
        }
    }

    def edit = {
        def EATUserInstance = EATUser.get(params.id)
        if (!EATUserInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'EATUser.label', default: 'EATUser'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [EATUserInstance: EATUserInstance]
        }
    }

    def update = {
        def EATUserInstance = EATUser.get(params.id)
        if (EATUserInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (EATUserInstance.version > version) {
                    
                    EATUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'EATUser.label', default: 'EATUser')] as Object[], "Another user has updated this EATUser while you were editing")
                    render(view: "edit", model: [EATUserInstance: EATUserInstance])
                    return
                }
            }
            EATUserInstance.properties = params
            if (!EATUserInstance.hasErrors() && EATUserInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'EATUser.label', default: 'EATUser'), EATUserInstance.id])}"
                redirect(action: "show", id: EATUserInstance.id)
            }
            else {
                render(view: "edit", model: [EATUserInstance: EATUserInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'EATUser.label', default: 'EATUser'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def EATUserInstance = EATUser.get(params.id)
        if (EATUserInstance) {
            try {
                EATUserInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'EATUser.label', default: 'EATUser'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'EATUser.label', default: 'EATUser'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'EATUser.label', default: 'EATUser'), params.id])}"
            redirect(action: "list")
        }
    }
}
