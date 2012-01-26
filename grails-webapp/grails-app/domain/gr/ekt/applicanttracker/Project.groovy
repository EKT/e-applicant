package gr.ekt.applicanttracker

class Project {

	String code
	String title
	String description
	String discipline
	
	String duration
	String noOfJobs
	
	List skills = []
	List wishSkills = []
	List projectApplications = []
	
	EATResult projectResult
	
	EvaluationCommittee projectEvaluationCommittee
	
	static fetchMode = [projectApplications:"eager"]
	
    static constraints = {
		projectResult(nullable:true)
    	code (blank:false)
		title (blank:false)
		discipline (blank:false)
		description (blank:true, nullable:true, maxSize: 5000)
		skills (nullable:false, minSize:1)
		
		duration (blank:true, nullable:true)
		noOfJobs (blank:true, nullable:true)
		
		projectEvaluationCommittee (nullable: true)

	}
	
	static hasMany = [skills: Skill, wishSkills: Skill, projectApplications: Application]
	
	static mappedBy = [skills:"projects", wishSkills:"wishProjects"]
	
	static belongsTo = [invitation: Invitation]
}
