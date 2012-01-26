package gr.ekt.applicanttracker

class ApplicationEvaluation extends Evaluation {

	ApplicationEvaluationLevel applicationEvalLevel
	
    static constraints = {
		applicationEvalLevel (nullable:false, blank: false)
    }
	
	static belongsTo = [Application]
}
