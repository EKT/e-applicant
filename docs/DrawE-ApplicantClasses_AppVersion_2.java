import java.util.Date;

/*
 * Draw domain model of 
 * Applicant Tracker application from National Documentation Centre (EKT)
 */

/**
 * @opt operations
 * @opt attributes
 * @opt types
 * @hidden
 */
class UMLOptions {}

/* Define some types we use */
/** @hidden */
class Name {}
/** @hidden */
class Number {}

/**
 * @assoc 1 - 1..* Project
 */
class Invitation {
	String code;
	Date startDate;
	Date endDate;
}

/**
 * @assoc 1 - 1 Results 
 * @assoc 1..* Required 1..* Skill
 * @assoc 1..* Desired 0..* Skill
 */
class Project {
	String code;
	String description;
	String discipline;
	String durationInMonths;
	int numOfPositions;
}

/**
 * @assoc 1..* - 1 Candidate
 * @assoc 1 - 1..* Application
 */
class ApplicationForm {
	String bioFilepath;
	String applicationFilepath;
	Date submissionDate;
}

/**
 * @assoc 1..* - 1 Candidate
 * @assoc 1..* - 1 Project  
 * @assoc 1 CommitteeEvaluation 1 CommitteeApplicationEvaluation
 * @assoc 1 ReviewerEvaluations 0..* ReviewerApplicationEvaluation
 * @assoc 0..* - 1..* Skill
 */
class Application {
}

/**
 */
class Skill {
}

/**
 */
class Candidate {
	String firstname;
	String lastname;
	String yearOfBirth;
	String street;
	String streetno;
	String postalcode;
	String city;
	String country;
	String phone;	
	String email;
	String emailVerification;
	String website;
}

/**
 * @assoc 1..* - 1..* EvaluationCommittee 
 */
class Reviewer {
	String firstname;
	String lastname;
}

/**
 * @assoc 1 - 1 Candidate
 * @assoc 1 - 1 Reviewer 
 * @assoc 1..* - 1..* Role 
 */
class User {
	String username;
	String userRealName;
	String passwd;
	boolean enabled;
	String email;
}

/**
 */
class Role {
	String description;
	/** ROLE String */
	String authority;
}

/**
 * @assoc 1 - 1 Project 
 */
class EvaluationCommittee {
}

/**
 */
class Evaluation {
	String notes;
}

/**
 */
class CandidateEvaluation extends Evaluation {
	/** CANDIDATE_EVAL_LEVEL String */
	String candidateEvalLevel;
}

/**
 */
class ApplicationEvaluation extends Evaluation {
	/** APPLICATION_EVAL_LEVEL String */
	String applicationEvalLevel;
}

/**
 * @assoc 0..1 - 1 Reviewer 
 */
class ReviewerApplicationEvaluation extends ApplicationEvaluation {
}

/**
 * @assoc 1 - 1 EvaluationCommittee 
 */
class CommitteeApplicationEvaluation extends ApplicationEvaluation {
}

/**
 * @assoc 1 Ranking 1..* Application 
 */
class Results {
	String notes;
}

/**
 * @assoc 1..* - 1 Candidate 
 * @assoc 1..* - 1..* Application 
 */
class Interview {
	String notes;
	Date interviewDate;
}

