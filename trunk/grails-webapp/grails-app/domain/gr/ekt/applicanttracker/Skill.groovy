package gr.ekt.applicanttracker

class Skill {

	String title
	String description 
	
    static constraints = {
		title (blank:false, nullable: false)
		description (nullable:true, blank:true, maxSize: 5000)
    }
	
	static hasMany = [projects: Project, wishProjects: Project]
	
	static belongsTo = [Project, Application]
}
