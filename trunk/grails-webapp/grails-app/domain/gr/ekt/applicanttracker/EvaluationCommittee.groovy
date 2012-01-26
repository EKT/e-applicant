package gr.ekt.applicanttracker

import java.util.List;

class EvaluationCommittee {

	List reviewers = []
	
	static hasMany = [reviewers: Reviewer]
	
	static belongsTo = [evalProject: Project]
	
    static constraints = {
    }
}
