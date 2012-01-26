package gr.ekt.applicanttracker

class Interview {

	String notes
	Date interviewDate
	
	static belongsTo = [interviewApplication: Application, interviewCandidate: Candidate]
	
    static constraints = {
		interviewDate (nullable: false)
		interviewApplication()
		interviewCandidate()
    }
}
