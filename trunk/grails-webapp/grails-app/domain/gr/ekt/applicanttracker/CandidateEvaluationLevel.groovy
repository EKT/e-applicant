package gr.ekt.applicanttracker

/**
* @author Kostas Stamatis
*/
enum CandidateEvaluationLevel {

   NOT_EVALUATED("Δεν έχει γίνει αξιολόγηση"),
   
   NOT_SUITABLE("Ακατάλληλος"),

   FOR_INVESTIGATION_IN_THE_FUTURE("Για διερέυνηση στο μέλλον"),

   FOR_INVESTIGATION_NOW("Για διερεύνηση τώρα"),
   
   SUITABLE("Κατάλληλος"),
   
   EXCELLENT("Εξαιρετικός")
   
   final String value
   
   CandidateEvaluationLevel (String value) {
	  this.value = value
	}
   String toString() { value }
   String getKey() { name() }
   
}