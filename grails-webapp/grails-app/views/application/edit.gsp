

<%@ page import="gr.ekt.applicanttracker.Application" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}" />
        <title><g:message code="Επεξεργασία Αίτησης Έργου" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/common/menu" model="['type':'1']"/>
        <div class="body">
            <h1><g:message code="Επεξεργασία Αίτησης Έργου για το έργο: ${applicationInstance?.project?.code }" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${applicationInstance}">
            <div class="errors">
                <g:renderErrors bean="${applicationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="update" method="post" >
                <g:hiddenField name="id" value="${applicationInstance?.id}" />
                <g:hiddenField name="version" value="${applicationInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                     
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="applicationSkills"><g:message code="application.applicationSkills.label" default="Απαραίτητα Προσόντα" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'applicationSkills', 'errors')}">
                                    <g:select style="width:450px; height:250px" name="applicationSkills" from="${applicationInstance?.getValidSkills()}" multiple="yes" optionKey="id" optionValue="title" size="5" value="${mySkills*.id}" />
                                	<br/><div style="width:450px"><strong><g:if test="${shouldSave }">ΠΡΟΣΟΧΗ: Αν υπάρχουν επιλεγμένες εγγραφές, αυτές έχουν επιλεχθεί με αυτόματο τρόπο. Παρακαλώ, πατήστε "Αποθήκευση" για αποθήκευση</g:if></strong></div>
                                </td>
                            </tr>

							<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="skillNotes"><g:message code="application.applicationSkills.label" default="Σημειώσεις προσόντων" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'skillNotes', 'errors')}">
                                    <g:textArea style="width:450px;" name="skillNotes" value="${applicationInstance?.skillNotes }"></g:textArea>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="applicationEvaluation"><g:message code="application.bioFileCheckStatus.label" default="Αξιολόγηση Αίτησης Έργου" /></label>
                                </td>
                                <td>
                                	<g:select name="applicationEvaluation.applicationEvalLevel" from="${gr.ekt.applicanttracker.ApplicationEvaluationLevel?.values()}" optionKey="key" optionValue="value"  value="${applicationInstance.applicationEvaluation?.applicationEvalLevel?.getKey() }"/>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="applicationEvaluation"><g:message code="application.phone.label" default="Σημειώσεις αξιολόγησης" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textArea name="applicationEvaluation.notes" value="${ applicationInstance.applicationEvaluation?.notes}" />
								 </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="applicationEvaluation"><g:message code="application.phone.label" default="Αποτέλεσμα" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textArea name="applicationResult.notes" value="${ applicationInstance?.applicationResult?.notes}" />
								 </td>
                            </tr>
                            
                            <tr class="prop">
                            	<td valign="top" class="name" colspan="2">
                            		<g:set var="candID" value="${candidateInstance.id }"></g:set>
                            		<g:set var="applicID" value="${applicationInstance.id }"></g:set>
                            		<g:if test="${shouldInterview }">
                            			<g:link controller="interview" action="create" params="[candidateID: candID, applicationID: applicID]">Δημιουργία συνέντευξης</g:link>
                            		</g:if>
                            		<g:else>
                            			Έχετε ήδη δημιουργήσει συνέντευξη για την αίτηση αυτή
                            		</g:else>
                            	</td>
                            </tr>
                            
                        </tbody>
                    </table>
                    <br/>
                <br/>
                <table style="background-color: #eee; width: 700px">
                    <tbody>
                    	<tr>
                    		<td colspan="2" style="font-size: 15px"><strong>Αναλυτικά στοιχεία υποψηφίου</strong></td>
                    	</tr>
                    	<tr><td colspan="2"></td> </tr>
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
                    
                    	<tr class="prop" style="background-color: #ddd">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Αξιολόγηση" /></td>
                            
                            <td valign="top" class="value"><strong>${candidateInstance?.candidateEvaluation?.candidateEvalLevel}</strong></td>
                            
                        </tr>
                        
                        <tr class="prop" style="background-color: #ddd">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Σημειώσεις αξιολόγησης" /></td>
                            
                            <td valign="top" class="value"><strong>${candidateInstance?.candidateEvaluation?.notes}</strong></td>
                            
                        </tr>

                    </tbody>
                </table>
                </div>
                 <div style="text-align: center; padding-top: 20p; width:705px"><input style="width:250px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Αποθήκευση" /></div>

            </g:form>
        </div>
    </body>
</html>
