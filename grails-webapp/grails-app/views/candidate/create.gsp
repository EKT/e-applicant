

<%@ page import="gr.ekt.applicanttracker.Candidate" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'candidate.label', default: 'Candidate')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
 
        <div class="body">
            
            <div style="width:730px; font-size:22px; font-family: Verdana, Yahoma, Helverica; font-weight: bold; color: #888; text-align: center">Αίτηση</div>
<div style="width:730px; font-size:18px; font-family: Verdana, Yahoma, Helverica; font-weight: bold; color: #888; text-align: center">Πρόσκληση εκδήλωσης ενδιαφέροντος ${invitationInstance?.code}</div>
        	
        	
        	<br/>
        	<br/>
        	<div style="text-align: center; width:730px; "><b>Σημείωση: Τα πεδία που είναι σημειωμένα με * πρέπει να συμπληρωθούν υποχρεωτικά.<b></div> 
        	<div style="text-align: center; width:730px; "><b>Οπου υπάρχει η ένδειξη <img style = "padding-top: 5px" width="16" height="16" border="0" src="${request.getContextPath()}/images/help_icon.png"/> είναι διαθέσιμο βοηθητικό κείμενο.<b></div> 
            <br/>
            <br/>
            
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${candidateInstance}">
            <div class="errors">
                <g:renderErrors bean="${candidateInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" enctype="multipart/form-data" onSubmit="return jcap();"> 
           	 	<g:hiddenField name="invitationid" value="${invitationInstance?.id }"></g:hiddenField>
                 <div class="dialog">
                    <table>
                        <tbody>
                        
                        <!-- Candidate fields -->
                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstname"><strong><g:message code="candidate.firstname.label" default="Όνομα *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'firstname', 'errors')}">
                                    <g:textField name="firstname" value="${candidateInstance?.firstname}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastname"><strong><g:message code="andidate.lastname.label" default="Επώνυμο *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'lastname', 'errors')}">
                                    <g:textField name="lastname" value="${candidateInstance?.lastname}" />
                                </td>
                            </tr>
                        
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><strong><g:message code="application.email.label" default="Email *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${candidateInstance?.email}" />
                                </td>
                            </tr>
                        
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="emailVerification"><strong><g:message code="application.email.label" default="Επιβεβαίωση Email *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'emailVerification', 'errors')}">
                                    <g:textField name="emailVerification" value="${candidateInstance?.emailVerification}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="street"><strong><g:message code="application.street.label" default="Οδός *" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'street', 'errors')}">
                                    <g:textField name="street" value="${candidateInstance?.street}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="streetno"><strong><g:message code="application.streetno.label" default="Αριθμός *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'streetno', 'errors')}">
                                	    <g:textField name="streetno" value="${fieldValue(bean: candidateInstance, field: 'streetno')}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="postalcode"><strong><g:message code="application.postalcode.label" default="Ταχυδρομικός Κώδικας *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'postalcode', 'errors')}">
                                    <g:textField name="postalcode" value="${candidateInstance?.postalcode}" />
                                    <img src="${request.getContextPath()}/images/help_icon.png" title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Ταχυδρομικός Κώδικας] body=[Π.χ. 11635]" style="vertical-align:middle;font-family:arial;font-size:20px;font-weight:bold;color:#ABABAB;cursor:pointer"/>
 
                                </td>
                           	</tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city"><strong><g:message code="application.city.label" default="Πόλη *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'city', 'errors')}">
                                    <g:textField name="city" value="${candidateInstance?.city}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="country"><strong><g:message code="application.country.label" default="Χώρα *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'country', 'errors')}">
                                    <g:textField name="country" value="${candidateInstance?.country}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="phone"><strong><g:message code="application.phone.label" default="Τηλέφωνο *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'phone', 'errors')}">
                                    <g:textField name="phone" value="${candidateInstance?.phone}" />
									<img src="${request.getContextPath()}/images/help_icon.png" title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Τηλέφωνο] body=[Π.χ. 2107273900 ή +302107273900]" style="vertical-align:middle;font-family:arial;font-size:20px;font-weight:bold;color:#ABABAB;cursor:pointer"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="yearOfBirth"><g:message code="application.yearOfBirth.label" default="Έτος Γέννησης" /></label>
                                </td>
                                 <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'yearOfBirth', 'errors')}">
                                	<g:if test="${candidateInstance?.yearOfBirth == 0}">
                                		<g:textField name="appFormCandidate.yearOfBirth" value=""/>
                                	</g:if>
                                	<g:else>
                                	    <g:textField class="appFormCandidate.yearOfBirth" name="yearOfBirth" value="${fieldValue(bean: candidateInstance, field: 'yearOfBirth')}" />
                                	</g:else>
                                </td>
                            </tr>
                            
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="website"><g:message code="application.website.label" default="Ιστοσελίδες" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'website', 'errors')}">
                                    <g:textField name="website" value="${fieldValue(bean: candidateInstance, field: 'website')}" />
 	                                 <img src="${request.getContextPath()}/images/help_icon.png" title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Ιστοσελίδες] body=[Διεύθυνση προσωπικής ιστοσελίδας, σελίδων blog, twitter ή και professional networking tools (π.χ. LinkedIn, Spoke, Viadeo). Μπορείτε να προσδιορίσετε περισσότερες από μία ιστοσελίδες με κόμματα ανάμεσά τους.]" style="vertical-align:middle;font-family:arial;font-size:20px;font-weight:bold;color:#ABABAB;cursor:pointer"/>
  
                                </td>
                            </tr>
                             
                             <!-- Projects -->
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projects"><strong><g:message code="application.projects.label" default="Κωδικός έργου *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'candidateApplicationForms', 'errors')}">
                                   		<span style="font-size: 12px"><i>(Επιλέξτε έναν ή περισσότερους κωδικούς έργων τους οποίους αφορά η αίτηση)</i></span>
                                   		<br/><br/>
                                   		<g:select multiple="multiple" optionKey="id" optionValue='code' from="${invitationInstance?.projects}" name="myCandidateApplicationForms" value="${projectsSelected}"></g:select>
                                	
                                <script type="text/javascript">
  									$(document).ready(function () {
    								$('select').selectList({ 
    									addAnimate: function (item, callback) {
    							        $(item).slideDown(500, callback);
    							      },
    							      removeAnimate: function (item, callback) {
    							        $(item).slideUp(500, callback);
    							      }  
  									});
  									});
								</script>

                            </tr>

                            <!-- ApplicationForm bio file -->
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projects"><strong><g:message code="application.bioFilepath.label" default="Βιογραφικό Σημείωμα *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'bioFilepath', 'errors')}">
                                   <input type="file" name="bioFilepath" value="Δεν έχει επιλεγεί αρχείο" />
                                  <img src="${request.getContextPath()}/images/help_icon.png" title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Βιογραφικό Σημείωμα] body=[Αναλυτικό Βιογραφικό Σημείωμα, κατά προτίμηση σύμφωνα με το πρότυπο βιογραφικό σημείωμα Europass σε μορφή αρχείου Open Document Text (.odt) ή .doc/.docx (μέγιστο μέγεθος αρχείου: 10ΜΒ). Για την παραγωγή των παραπάνω μορφών αρχείων μπορούν να χρησιμοποιηθούν προγράμματα επεξεργασίας κειμένου όπως Libre Office Writer, Open Office Writer, Microsoft Word. Πληροφορίες για τη δημιουργία βιογραφικού σημειώματος Europass παρέχονται στο διαδικτυακό τόπο http://europass.cedefop.europa.eu]" style="vertical-align:middle;font-family:arial;font-size:20px;font-weight:bold; color:#ABABAB;cursor:pointer"/>
                                   
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projects"><strong><g:message code="application.applicationFilepath.label" default="Υπεύθυνη Δήλωση *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: candidateInstance, field: 'applicationFilepath', 'errors')}">
                                 <span style="font-size: 12px"><b><i>(Παρακαλούμε πολύ ελέγξτε ότι η υπεύθυνη δήλωση που υποβάλετε<br/> είναι σύμφωνη με τα οριζόμενα στην πρόσκληση.)</i></b></span>
                                   		<br/><br/>
                                   <input type="file" name="applicationFilepath" />
								<img src="${request.getContextPath()}/images/help_icon.png" title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Υπεύθυνη Δήλωση] body=[Το σαρωμένο (scanned) αρχείο της υπογεγραμμένης Υπεύθυνης Δήλωσης του Ν.1599/1986, κατά προτίμηση σε μορφή JPEG ή PDF]" style="vertical-align:middle;font-family:arial;font-size:20px;font-weight:bold;color:#ABABAB;cursor:pointer"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                                <br/><br/>
                
                <div style="text-align: center; width:730px;">
                
                <p>Παρακαλώ, εισάγετε τον κωδικό ελέγχου που βλέπετε παρακάτω στο αντίστοιχο πεδίο:</p> 

				<p><i>Το πεδίο αυτό αποτρέπει την αυτόματη αποστολή αιτήσεων στο σύστημα</i></p>

				<script type="text/javascript">sjcap();</script>

				<noscript><p>[This resource requires a Javascript enabled browser.]</p></noscript>
                </div>
                <br/><br/>
                
                <br/>
                <br/>
                <div style="width:705px;">
                <div style="font-weight: bold">Εμπιστευτικότητα και Προστασία Προσωπικών Δεδομένων</div>
                <div style="width:705px; font-weight: normal;">
                <p>Η συλλογή και επεξεργασία των πληροφοριών που παρέχετε πραγματοποιείται σύμφωνα με τις ρυθμίσεις και τις εγγυήσεις της νομοθεσίας για την προστασία των δεδομένων προσωπικού χαρακτήρα (Ν. 2472/97 όπως ισχύει).Οι πληροφορίες που θα παρέχετε με τη συμπλήρωση της παρούσας αίτησης αντιμετωπίζονται ως απόρρητες και κοινοποιούνται αποκλειστικά στα πρόσωπα στα οποία έχει ανατεθεί η διεξαγωγή της προαναφερόμενης επιλογής συνεργατών και δεσμεύονται από ρητές υποχρεώσεις εμπιστευτικότητας.</p>
                <p>Τα δεδομένα αυτά δεν διαβιβάζονται σε τρίτους.</p>
                <p>Τα δεδομένα που συλλέγονται θα χρησιμοποιηθούν αποκλειστικά για την επιλογή συνεργατών και δεν θα δημοσιευτούν σε μορφή που επιτρέπει τον προσδιορισμό της ταυτότητας φυσικών προσώπων.</p>
                <p>Σας ενημερώνουμε ότι σύμφωνα με τη νομοθεσία για την προστασία δεδομένων προσωπικού χαρακτήρα δικαιούστε οποτεδήποτε να ασκήσετε το δικαίωμα πρόσβασης στα δεδομένα που σας αφορούν, καθώς και τα άλλα δικαιώματα που προβλέπει η οικεία νομοθεσία (άρθρα 12-13 Ν. 2472/97, όπως ισχύει).</p>
                </div>
                
                </div>
                
                <div style="text-align: center; padding-top: 20px; width:705px"><input style="width:200px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Υποβολή Αίτησης" /></div>
                <!-- <div class="buttons">
                
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div> -->
            </g:form>
        </div>
    </body>
</html>
