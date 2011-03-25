import gr.ekt.applicanttracker.Invitation;
import gr.ekt.applicanttracker.Project;
import gr.ekt.applicanttracker.Skill;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.springframework.context.MessageSource


class BootStrap {
	
	def messageSource
	def grailsApplication
	def authenticateService
	
	def init = { servletContext ->
		grailsApplication.getDomainClasses().each { domainClass ->
			if (domainClass.clazz.name.contains("gr.ekt.applicanttracker")) {//only add it to the domains in my plugin
				domainClass.metaClass.retrieveErrors = {
					def list = delegate?.errors?.allErrors?.collect{messageSource.getMessage(it,null)}
					return list?.join('\n')
				}
			}
		}
		
		
		//Bootstrap code for the first time
		if (EATRole.count() == 0){
			//1st role
			role = new EATRole()
			role.authority = "ROLE_SYS_ADMIN"
			role.description = "system administrator"
			role.save()
			
			user = new EATUser()
			user.username = "sysadmin"
			user.userRealName = "System Administrator"
			user.email = "ekt-sys-administrator@ekt.gr"
			def password = authenticateService.passwordEncoder("sysadmin")
			user.passwd = password
			user.enabled = true
			user.save()
			
			role.addToPeople(user)
			role.save()
			
			//2nd role
			role = new EATRole()
			role.authority = "ROLE_ADMIN"
			role.description = "invitation & project administrator"
			role.save()
			
			user = new EATUser()
			user.username = "admin"
			user.userRealName = "Administrator"
			user.email = "ekt-administrator@ekt.gr"
			password = authenticateService.passwordEncoder("admin")
			user.passwd = password
			user.enabled = true
			user.save()
			
			role.addToPeople(user)
			role.save()
			
			//3rd role
			role = new EATRole()
			role.authority = "ROLE_REVIEWER"
			role.description = "Reviewer"
			role.save()
			
			user = new EATUser()
			user.username = "reviewer"
			user.userRealName = "Reviewer"
			user.email = "ekt-administrator@ekt.gr"
			password = authenticateService.passwordEncoder("reviewer")
			user.passwd = password
			user.enabled = true
			user.save()
			
			role.addToPeople(user)
			role.save()
		}
		
	}
	
	def destroy = {
		
	}
	
}
