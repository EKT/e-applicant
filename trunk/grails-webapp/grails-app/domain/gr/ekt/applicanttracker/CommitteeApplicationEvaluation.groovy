package gr.ekt.applicanttracker

class CommitteeApplicationEvaluation extends ApplicationEvaluation{

	EvaluationCommittee evaluationCommittee
	
	static belongsTo = [Application, EvaluationCommittee]
	
    static constraints = {
    }
}
