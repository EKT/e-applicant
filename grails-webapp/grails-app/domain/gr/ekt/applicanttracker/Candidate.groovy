package gr.ekt.applicanttracker

import java.util.List

class Candidate {

	String firstname
	String lastname
	String yearOfBirth
	String street
	String streetno
	String postalcode
	String city
	String country
	String phone
	String email
	String emailVerification
	String website
	
	EATUser user //EATUser
	
	CandidateEvaluation candidateEvaluation
	
	EducationLevel educationalLevel
	
	List candidateApplicationForms = []
	List candidateApplications = []
	List candidateInterviews = []
	
	ApplicationForm currentApplicationForm
	
	static hasMany = [candidateApplications: Application, candidateApplicationForms: ApplicationForm,  candidateInterviews: Interview]
	
	static transients = ['emailVerification', 'currentApplicationForm']
	
    static constraints = {
		firstname(blank:false)
		lastname(blank:false)
		email (unique:true, email:true, blank:false)
		emailVerification(blank:false, validator:{val, obj ->
			if (!val?.equals(obj.email)){
				return false;
			}
		})
		street(blank:false)
		streetno(blank:false)
		postalcode(blank:false)
		city(blank:false)
		country(blank:false)
		phone(blank:false)
		user(nullable:true, blank:true)
		candidateEvaluation(nullable:true, blank:true)
		educationalLevel(nullable:true)
    }
}
