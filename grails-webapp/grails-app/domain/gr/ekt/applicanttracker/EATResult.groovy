package gr.ekt.applicanttracker

class EATResult {

	String notes

	static belongsTo = [Application, Project]
	
    static constraints = {
    }
}
