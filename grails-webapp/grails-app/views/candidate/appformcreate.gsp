

<%@ page import="gr.ekt.applicanttracker.ApplicationForm" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'applicationForm.label', default: 'ApplicationForm')}" />
        <title><g:message code="Δημιουργία Αίτησης" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/common/profilemenu"
	model="['candidateInstance':candidateInstance]" />
        <div class="body">
            <h1><g:message code="Δημιουργία Αίτησης" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${applicationFormInstance}">
            <div class="errors">
                <g:renderErrors bean="${applicationFormInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="appformsave" method="post" enctype="multipart/form-data">
                <g:hiddenField name="id" value="${candidateInstance?.id}" />
                <g:hiddenField name="version" value="${applicationFormInstance?.version}" />
                <g:hiddenField name="invitationid" value="${invitationInstance.id}" />
                
                <div class="dialog">
                    <table>
                        <tbody>
                        
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
                                   <input type="file" name="applicationFilepath" />
								<img src="${request.getContextPath()}/images/help_icon.png" title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Υπεύθυνη Δήλωση] body=[Το σαρωμένο (scanned) αρχείο της υπογεγραμμένης Υπεύθυνης Δήλωσης του Ν.1599/1986, κατά προτίμηση σε μορφή JPEG ή PDF]" style="vertical-align:middle;font-family:arial;font-size:20px;font-weight:bold;color:#ABABAB;cursor:pointer"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <br/><br/>
                <div style="text-align: center; padding-top: 20p; width:705px"><input style="width:250px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Αποθήκευση αίτησης" /></div>
            </g:form>
        </div>
    </body>
</html>
