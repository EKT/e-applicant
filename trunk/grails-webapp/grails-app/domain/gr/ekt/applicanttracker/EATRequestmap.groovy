package gr.ekt.applicanttracker


/**
 * Request Map domain class.
 */
class EATRequestmap {

	String url
	String configAttribute

	static constraints = {
		url(blank: false, unique: true)
		configAttribute(blank: false)
	}
}
