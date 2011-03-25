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

class SkillController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [skillInstanceList: Skill.list(params), skillInstanceTotal: Skill.count()]
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def create = {
        def skillInstance = new Skill()
        skillInstance.properties = params
        return [skillInstance: skillInstance]
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def save = {
        def skillInstance = new Skill(params)
        if (skillInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'skill.label', default: 'Skill'), skillInstance.id])}"
            redirect(action: "show", id: skillInstance.id)
        }
        else {
            render(view: "create", model: [skillInstance: skillInstance])
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def show = {
        def skillInstance = Skill.get(params.id)
        if (!skillInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])}"
            redirect(action: "list")
        }
        else {
            [skillInstance: skillInstance]
        }
    }
	
	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def edit = {
        def skillInstance = Skill.get(params.id)
        if (!skillInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [skillInstance: skillInstance]
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def update = {
        def skillInstance = Skill.get(params.id)
        if (skillInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (skillInstance.version > version) {
                    
                    skillInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'skill.label', default: 'Skill')] as Object[], "Another user has updated this Skill while you were editing")
                    render(view: "edit", model: [skillInstance: skillInstance])
                    return
                }
            }
            skillInstance.properties = params
            if (!skillInstance.hasErrors() && skillInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'skill.label', default: 'Skill'), skillInstance.id])}"
                redirect(action: "show", id: skillInstance.id)
            }
            else {
                render(view: "edit", model: [skillInstance: skillInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])}"
            redirect(action: "list")
        }
    }

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN"])
    def delete = {
        def skillInstance = Skill.get(params.id)
        if (skillInstance) {
            try {
                skillInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'skill.label', default: 'Skill'), params.id])}"
            redirect(action: "list")
        }
    }
}
