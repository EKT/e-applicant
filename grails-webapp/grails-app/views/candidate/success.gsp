
<%@ page import="gr.ekt.applicanttracker.Application" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    	<!-- 
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        -->
        <div class="body">
        <h1>Η αίτησή σας αποθηκεύτηκε. Σας έχει αποσταλεί email επιβεβαίωσης</h1>
            <!-- <h1><g:message code="default.show.label" args="[entityName]" /></h1> -->
           <!--  <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if> -->
            <div class="dialog">
            
                <table>
                    <tbody>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.id.label" default="Πρόσκληση" /></td>
                            
                            <td valign="top" class="value"><strong>${candidateInstance.currentApplicationForm.appFormApplications[0].project.invitation.code}</strong></td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.id.label" default="Kωδικός αίτησης" /></td>
                            
                            <td valign="top" class="value"><strong>${candidateInstance.currentApplicationForm.id}</strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.firstname.label" default="Όνομα" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: candidateInstance, field: "firstname")}</strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.lastname.label" default="Επίθετο" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: candidateInstance, field: "lastname")}</strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: candidateInstance, field: "email")}</strong></td>
                            
                        </tr>
                    
                   	 	<tr class="prop">
                            <td valign="top" class="name"><g:message code="application.street.label" default="Οδός" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: candidateInstance, field: "street")}</strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.streetno.label" default="Αριθμός" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: candidateInstance, field: "streetno")}</strong></td>
                            
                        </tr>
                        
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.postalcode.label" default="Ταχυδρομικός Κώδικας" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: candidateInstance, field: "postalcode")}</strong></td>
                            
                        </tr>
                        
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.city.label" default="Πόλη" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: candidateInstance, field: "city")}</strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.country.label" default="Χώρα" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: candidateInstance, field: "country")}</strong></td>
                            
                        </tr>
  
                          <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.phone.label" default="Τηλέφωνο" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: candidateInstance, field: "phone")}</strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.yearOfBirth.label" default="Έτος Γέννησης" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: candidateInstance, field: "yearOfBirth")}</strong></td>
                            
                        </tr>
                             
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Website" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: candidateInstance, field: "website")}</strong></td>
                            
                        </tr>
                                         
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.projects.label" default="Κωδικοί έργων" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${candidateInstance.currentApplicationForm.appFormApplications}" var="p">
                                    <li><strong>${p.project.code}</strong></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        </tbody>
                </table>
                <br/><br/>
               <div style="width:705px;"> Μέχρι τη λήξη της προθεσμίας υποβολής αιτήσεων έχετε τη δυνατότητα να δείτε και να διορθώσετε / επεξεργαστείτε τα στοιχεία της αίτησής σας μετά από σύνδεση στο σύστημα με προσωπικό κωδικό.</div>
                <br/><br/>
				Τα στοιχεία σύνδεσης στην υπηρεσία είναι:<br /><br />
                <table>
                    <tbody>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Website" /></td>
                            
                            <td valign="top" class="value"><a href="http://tenders-forms.ekt.gr/tenders/candidate/profile">http://tenders-forms.ekt.gr/tenders/candidate/profile</a></td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Συνθηματικό Χρήστη" /></td>
                            
                            <td valign="top" class="value"><strong>${candidateInstance.user.username}</strong></td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Κωδικός Χρήστη" /></td>
                            
                            <td valign="top" class="value"><strong>${password}</strong></td>
                            
                        </tr>
                    </tbody>
                </table>
                <br/><br/>
                <div style="width:705px;">Για οποιοδήποτε ζήτημα σχετικά με την υποβολή αιτήσεων μέσω του συστήματος μπορείτε να επικοινωνείτε μέσω ηλεκτρονικού ταχυδρομείου στην παρακάτω διεύθυνση:</div>
				<br/><br/>
				<div style="width:705px; padding-left: 20px"><a href="mailto:epsetkd_tenders@ekt.gr">epsetkd_tenders@ekt.gr</a></div>
			
				<br /><br/>
				Ευχαριστούμε θερμά για την αίτησή σας!<br /><br/>
		
            </div>
        </div>
    </body>
</html>
