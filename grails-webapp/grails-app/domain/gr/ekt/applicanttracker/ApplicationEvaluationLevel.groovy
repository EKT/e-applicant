package gr.ekt.applicanttracker

/**
* @author Kostas Stamatis
*/
enum ApplicationEvaluationLevel {

   NOT_EVALUATED("Δεν έχει γίνει αξιολόγηση"),
	
   NOT_SUITABLE("Ακατάλληλη"),

   MARGINALLY_SUITABLE("Οριακά κατάλληλη"),
   
   SUITABLE("Κατάλληλη"),
   
   EXCELLENT("Σαφώς κατάλληλη")
   
   final String value
   
   ApplicationEvaluationLevel (String value) {
	  this.value = value
	}
   String toString() { value }
   String getKey() { name() }
   
}