package gr.ekt.applicanttracker

import java.util.List;

class Application {
	
	Interview applicationInterview
	List applicationReviewerEvaluations = []
	CommitteeApplicationEvaluation applicationCommitteeEvaluation
	List applicationSkills = []
	
	String skillNotes
	
	EATResult applicationResult
	
	ApplicationEvaluation applicationEvaluation
	
	static hasMany = [applicationReviewerEvaluations: ReviewerApplicationEvaluation, applicationSkills: Skill]
	
	static belongsTo = [project : Project, candidate : Candidate, applicationForm: ApplicationForm]
	
	static constraints = {
		candidate ()
		applicationCommitteeEvaluation(nullable: true)
		applicationResult(nullable:true)
		skillNotes(nullable:true, blank:true)
		applicationEvaluation(nullable:true, blank:true)
		applicationInterview(nullable: true)
	}
	
	static transients = ['validSkills']
	
	
	def getValidSkills(){
		ArrayList<Skill> result = new ArrayList<Skill>()
		
		project.skills.eachWithIndex() { obj, i ->
			if (!result.contains(obj))
				result.add obj
		}
		project.wishSkills.eachWithIndex() { obj, i ->
			if (!result.contains(obj))
				result.add obj
		}
		return result
	}
}
