



/**
 * Authority domain class.
 */
class EATRole {

	static hasMany = [people: EATUser]

	/** description */
	String description
	/** ROLE String */
	String authority

	static constraints = {
		authority(blank: false, unique: true)
		description()
	}
}
