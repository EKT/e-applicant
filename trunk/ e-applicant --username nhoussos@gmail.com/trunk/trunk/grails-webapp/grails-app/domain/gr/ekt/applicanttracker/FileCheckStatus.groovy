package gr.ekt.applicanttracker

/**
* @author Kostas Stamatis
*/
enum FileCheckStatus {

   NOT_CHECKED("Δεν έχει ελεγχθεί"),

   VALID("Έγκυρο"),

   INVALID("Άκυρο")
   
   final String value
   
   FileCheckStatus (String value) {
	  this.value = value
	}
   String toString() { value }
   String getKey() { name() }
   
}