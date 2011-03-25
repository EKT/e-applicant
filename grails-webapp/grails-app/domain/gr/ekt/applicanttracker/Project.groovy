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

class Project {

	String code
	String title
	String description
	String discipline
	
	String duration
	String noOfJobs
	
	List skills = []
	List wishSkills = []
	
    static constraints = {
    	code (blank:false)
		title (blank:false)
		discipline (blank:false)
		description (blank:true, nullable:true, maxSize: 5000)
		invitation ()
		skills (nullable:false, minSize:1)
		
		duration (blank:true, nullable:true)
		noOfJobs (blank:true, nullable:true)
	}
	
	static hasMany = [skills: Skill, wishSkills: Skill]
	
	static mappedBy = [skills:"projects", wishSkills:"wishProjects"]
	
	static belongsTo = [invitation: Invitation]
}
