package gr.ekt.applicanttracker

class CandidateEvaluation extends Evaluation{

	CandidateEvaluationLevel candidateEvalLevel
	
    static constraints = {
    	candidateEvalLevel (blank:false)
	}
	
	static belongsTo = [Candidate]
}
