package gr.ekt.applicanttracker

class Reviewer {

	String firstname
	String lastname
	
	def user //EATUser
	
	List evaluationCommittees = []
	
	static hasMany = [evaluationCommittees: EvaluationCommittee]
	
	static belongsTo = [EvaluationCommittee]
	
    static constraints = {
		firstname (blank: false)
		lastname (blank: false)
    }
}
