package gr.ekt.applicanttracker

class ReviewerApplicationEvaluation extends ApplicationEvaluation{

	Reviewer reviewer
	
	static belongsTo = [Application, Reviewer]
	
    static constraints = {
    }
}
