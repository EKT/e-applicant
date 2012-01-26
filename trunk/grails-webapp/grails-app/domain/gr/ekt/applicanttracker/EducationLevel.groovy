package gr.ekt.applicanttracker

/**
* @author Kostas Stamatis
*/
enum EducationLevel {

   NOT_COMPLETED("Δεν έχει συμπληρωθεί"),
	
   AEI("Πτυχίο ΤΕΙ"),

   TEI("Πτυχίο ΑΕΙ"),
   
   MASTER("Μεταπτυχιακό"),
   
   PHD("Διδακτορικό")
   
   final String value
   
   EducationLevel (String value) {
	  this.value = value
	}
   String toString() { value }
   String getKey() { name() }
   
}