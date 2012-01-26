

<%@ page import="gr.ekt.applicanttracker.Candidate" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'candidate.label', default: 'Candidate')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/common/menu" model="['type':'5']"/>
	
        <div class="body">
            <h1><g:message code="Επεξεργασία στοιχείων" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${candidateInstance}">
            <div class="errors">
                <g:renderErrors bean="${candidateInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="adminupdate" method="post"  >
                <g:hiddenField name="id" value="${candidateInstance?.id}" />
                <g:hiddenField name="version" value="${candidateInstance?.version}" />
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
   
   							<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="candidateEvaluation"><g:message code="application.bioFileCheckStatus.label" default="Αξιολόγηση Υποψηφίου" /></label>
                                </td>
                                <td>
                                	<g:select name="candidateEvaluation.candidateEvalLevel" from="${gr.ekt.applicanttracker.CandidateEvaluationLevel?.values()}" optionKey="key" optionValue="value"  value="${candidateInstance.candidateEvaluation?.candidateEvalLevel?.getKey() }"/>
                                </td>
                            </tr>
                        
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="candidateEvaluation"><g:message code="application.phone.label" default="Σημειώσεις αξιολόγησης" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textArea name="candidateEvaluation.notes" value="${ candidateInstance.candidateEvaluation?.notes}" />
								 </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="educationalLevel"><g:message code="application.bioFileCheckStatus.label" default="Επίπεδο Εκπαίδευσης" /></label>
                                </td>
                                <td>
                                	<g:select name="educationalLevel" from="${gr.ekt.applicanttracker.EducationLevel?.values()}" optionKey="key" optionValue="value"  value="${candidateInstance.educationalLevel?.getKey() }"/>
                                </td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                
                <div style="text-align: center; padding-top: 20p; width:705px"><input style="width:250px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Αποθήκευση Στοιχείων" /></div>
                
            </g:form>
        </div>
    </body>
</html>
