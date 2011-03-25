package gr.ekt.applicanttracker

import java.util.ArrayList;
import java.util.List;

class Application {

	String firstname
	String lastname
	String yearOfBirth
	String street
	String streetno
	String postalcode
	String city
	String country
	String phone	
	String email
	String emailVerification
	
	String bioFilepath
	String applicationFilepath
	
	String website
	
	Invitation invitation
	
	List projects = []

	java.util.Date dateIssued
	
	FileCheckStatus appFormFileCheckStatus = FileCheckStatus.NOT_CHECKED
	FileCheckStatus bioFileCheckStatus  = FileCheckStatus.NOT_CHECKED
	String fileStatusNotes;
	String skillNotes;
	
	boolean isEdit
	
	List appSkills = []
	
	Boolean throughPost
		
	static hasMany = [projects: Project, appSkills: Skill]
	
	static transients = ['emailVerification', 'isEdit', 'validSkills']
	
    static constraints = {
		dateIssued(nullable:true, blank:true)
		firstname(blank:false)
		lastname(blank:false)
		//email (unique:true, email:true, blank:false)
		emailVerification(blank:false, validator:{val, obj ->
			if (!val?.equals(obj.email)){
				return false;
			}
		})
		projects (minSize:1)
		bioFilepath(blank:false, nullable:false)
		applicationFilepath(blank:false, nullable:false, validator:{val, obj ->
			def myformat = [val]
			def validFormats = ['jpg', 'jpeg', 'bmp', 'png', 'tif', 'tiff', 'pdf']
			boolean found = false;
		
			for (String validFormat : validFormats){
				if (val.endsWith(validFormat)){
					found = true
					break
				}
			}
			
			if (obj.isEdit)
			found = true;
			
			if (!found){
				return 'invalidFormat'
			}
		})
		//website(url: true)
		street(blank:false)
		streetno(blank:false)
		postalcode(blank:false)
		city(blank:false)
		country(blank:false)
		phone(blank:false)
		invitation(nullable:false)
		fileStatusNotes (maxSize: 5000, nullable:true, blank:true)
		skillNotes (maxSize: 5000, nullable:true, blank:true)
		throughPost (nullable:true)
    }
	
	def getValidSkills(){
		ArrayList<Skill> result = new ArrayList<Skill>()
		projects.each { 
			it.skills.eachWithIndex() { obj, i ->
				if (!result.contains(obj))
					result.add obj	
			}	
			it.wishSkills.eachWithIndex() { obj, i ->
				if (!result.contains(obj))
					result.add obj
			}
		}
		return result
	}
	
}
