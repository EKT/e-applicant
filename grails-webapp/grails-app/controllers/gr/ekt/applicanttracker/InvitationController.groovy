*/
* Copyright 2011 Hellenic National Documentation Centre (EKT) www.ekt.gr
*
* Contributors:
* Kostas Stamatis, Nikos Houssos
*
* Licensed under the EUPL, Version 1.1 or – as soon they will be approved by the European Commission 
* - subsequent  versions of the EUPL (the "Licence"); 
* You may not use this work except in compliance with the Licence. 
* You may obtain a copy of the Licence at: 
*
* http://ec.europa.eu/idabc/eupl
*
* Unless required by applicable law or agreed to in writing, software distributed 
* under the Licence is distributed on an "AS IS" basis, 
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
* See the Licence for the specific language governing permissions and limitations under the Licence. 
*/

package gr.ekt.applicanttracker

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

class InvitationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def index = {
        redirect(action: "list", params: params)
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 50, 100)
        [invitationInstanceList: Invitation.list(params), invitationInstanceTotal: Invitation.count()]
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def create = {
        def invitationInstance = new Invitation()
        invitationInstance.properties = params
        return [invitationInstance: invitationInstance]
    }

	def showForm = {
		redirect(controller:"application", action: "create", params:["invid":params.id])
	}
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def save = {
        def invitationInstance = new Invitation(params)
        if (invitationInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'invitation.label', default: 'Invitation'), invitationInstance.id])}"
            redirect(action: "show", id: invitationInstance.id)
        }
        else {
            render(view: "create", model: [invitationInstance: invitationInstance])
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def show = {
        def invitationInstance = Invitation.get(params.id)
        if (!invitationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'invitation.label', default: 'Invitation'), params.id])}"
            redirect(action: "list")
        }
        else {
            [invitationInstance: invitationInstance]
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def edit = {
        def invitationInstance = Invitation.get(params.id)
        if (!invitationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'invitation.label', default: 'Invitation'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [invitationInstance: invitationInstance]
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def update = {
        def invitationInstance = Invitation.get(params.id)
        if (invitationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (invitationInstance.version > version) {
                    
                    invitationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'invitation.label', default: 'Invitation')] as Object[], "Another user has updated this Invitation while you were editing")
                    render(view: "edit", model: [invitationInstance: invitationInstance])
                    return
                }
            }
            invitationInstance.properties = params
            if (!invitationInstance.hasErrors() && invitationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'invitation.label', default: 'Invitation'), invitationInstance.id])}"
                redirect(action: "show", id: invitationInstance.id)
            }
            else {
                render(view: "edit", model: [invitationInstance: invitationInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'invitation.label', default: 'Invitation'), params.id])}"
            redirect(action: "list")
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def delete = {
        def invitationInstance = Invitation.get(params.id)
        if (invitationInstance) {
            try {
                invitationInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'invitation.label', default: 'Invitation'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'invitation.label', default: 'Invitation'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'invitation.label', default: 'Invitation'), params.id])}"
            redirect(action: "list")
        }
    }
}
