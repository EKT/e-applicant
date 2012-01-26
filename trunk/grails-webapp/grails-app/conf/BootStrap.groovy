import gr.ekt.applicanttracker.Invitation;
import gr.ekt.applicanttracker.Project;
import gr.ekt.applicanttracker.Skill;
import gr.ekt.applicanttracker.EATUser;
import gr.ekt.applicanttracker.EATRole;

import org.apache.commons.io.output.ByteArrayOutputStream;
import org.springframework.context.MessageSource


class BootStrap {
	
	def messageSource
	def grailsApplication
	def authenticateService
	
	def init = { servletContext ->
		grailsApplication.getDomainClasses().each { domainClass ->
			if (domainClass.clazz.name.contains("gr.kstamatis.grappindex")) {//only add it to the domains in my plugin
				domainClass.metaClass.retrieveErrors = {
					def list = delegate?.errors?.allErrors?.collect{messageSource.getMessage(it,null)}
					return list?.join('\n')
				}
			}
		}

		if (EATRole.count() == 0){
			//1st role
			def role = new EATRole()
			role.authority = "ROLE_SYS_ADMIN"
			role.description = "system administrator"
			role.save()
			
			def user = new EATUser()
			user.username = "sysadmin"
			user.userRealName = "System Administrator"
			user.email = "changeme@ekt.gr"
			def password = authenticateService.passwordEncoder("changeme")
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
			user.email = "changeme@ekt.gr"
			password = authenticateService.passwordEncoder("changeme")
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
			user.email = "changeme@ekt.gr"
			password = authenticateService.passwordEncoder("changeme")
			user.passwd = password
			user.enabled = true
			user.save()
			
			role.addToPeople(user)
			role.save()
			
			//4th role
			role = new EATRole()
			role.authority = "ROLE_CANDIDATE"
			role.description = "Candidate"
			role.save()
			
		}

		
	}
	
	def destroy = {
		
	}
	
}
