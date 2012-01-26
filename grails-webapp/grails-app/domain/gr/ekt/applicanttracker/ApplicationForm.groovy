package gr.ekt.applicanttracker

import java.util.List;

class ApplicationForm {

	String bioFilepath
	String applicationFilepath
	java.util.Date dateIssued
	java.util.Date dateInitial
	
	List appFormApplications = []
	
	FileCheckStatus appFormFileCheckStatus = FileCheckStatus.NOT_CHECKED
	FileCheckStatus bioFileCheckStatus  = FileCheckStatus.NOT_CHECKED
	String fileStatusNotes;
	
	Boolean throughPost
	
	static hasMany = [appFormApplications: Application]
	
	static mapping = {
		appFormApplications cascade:"all,delete-orphan"
	}
	
	static belongsTo = [appFormCandidate: Candidate]
	
    static constraints = {
		dateIssued(nullable:true, blank:true)
		dateInitial(nullable:true, blank:true)
		bioFilepath(blank:false, nullable:false)
		//applicationFilepath(blank:false, nullable:false)
		applicationFilepath(blank:false, nullable:false, validator:{val, obj ->
			def myformat = [val]
			def validFormats = ['jpg', 'jpeg', 'bmp', 'png', 'tif', 'tiff', 'pdf']
			boolean found = false;
			
			for (String validFormat : validFormats){
				if (val.endsWith(validFormat)){
					found = true;
					break
				}
			}
			
			found = true; //Remove if you want validation
			
			if (!found){
				return 'invalidFormat'
			}
		})
		appFormCandidate (nullable: true)
		fileStatusNotes (maxSize: 5000, nullable:true, blank:true)
		throughPost (nullable:true)
    }
}
