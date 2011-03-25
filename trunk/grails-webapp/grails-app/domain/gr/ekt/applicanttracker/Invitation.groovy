*/
* Copyright 2011 Hellenic National Documentation Centre (EKT) www.ekt.gr
*
* Contributors:
* Kostas Stamatis, Nikos Houssos
*
* Licensed under the EUPL, Version 1.1 or � as soon they will be approved by the European Commission 
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
