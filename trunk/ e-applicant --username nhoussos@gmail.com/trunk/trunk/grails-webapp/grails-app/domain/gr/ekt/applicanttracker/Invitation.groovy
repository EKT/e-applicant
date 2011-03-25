package gr.ekt.applicanttracker

import java.util.List;
import java.util.Date;

class Invitation {

	List projects = []
	String code
	
	Boolean enabled = true
	Date startDate
	Date endDate
	
	static hasMany = [projects: Project]
	
    static constraints = {
		code (blank: false)
    }
	
	def isInvitationEnabled() {
		
		Date now = new Date()
		boolean dateOK = false
		
		if (now.compareTo(startDate)>=0 && now.compareTo(endDate)<=0)
			dateOK = true;
		
		return enabled && dateOK
		//in the future, return something more advanced, like a combination of property 'enabled' and properties for date from/date to of invitation
	}
	
}
