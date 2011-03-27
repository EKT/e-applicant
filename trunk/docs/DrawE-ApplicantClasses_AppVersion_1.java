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
 * @assoc 1..* - 1 Project  
 * @assoc 0..* - 1..* Skill
 */
class Application {
}

/**
 */
class Skill {
}

/**
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



