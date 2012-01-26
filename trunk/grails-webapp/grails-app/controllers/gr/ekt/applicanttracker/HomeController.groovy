package gr.ekt.applicanttracker

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

class HomeController {

	@Secured(["ROLE_ADMIN", "ROLE_SYS_ADMIN", "ROLE_REVIEWER"])
    def index = {
        
    }
}
