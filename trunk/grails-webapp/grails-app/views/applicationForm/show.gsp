
<%@ page import="gr.ekt.applicanttracker.ApplicationForm" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'applicationForm.label', default: 'ApplicationForm')}" />
        <title><g:message code="Προβολή Αίτησης" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/common/menu" model="['type':'1']"/>
        <br/><br/>
        <div class="body">
            <h1><g:message code="Προβολή Αίτησης" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog" style="width:705px">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="applicationForm.id.label" default="Κωδικός αίτησης" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance, field: "id")}</strong></td>
                            
                        </tr>
                    
                    	<tr class="prop">
                            <td valign="top" class="name"><g:message code="applicationForm.id.label" default="Πρόσκληση" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance.appFormApplications[0].project.invitation, field: "code")}</strong></td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="applicationForm.dateInitial.label" default="Ημ. Εισαγωγής" /></td>
                            
                            <td valign="top" class="value"><strong><g:formatDate date="${applicationFormInstance?.dateInitial}" /></strong></td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="applicationForm.dateIssued.label" default="Ημ. Τελευταίας Αλλαγής" /></td>
                            
                            <td valign="top" class="value"><strong><g:formatDate date="${applicationFormInstance?.dateIssued}" /></strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="applicationForm.bioFilepath.label" default="Αρχείο βιογραφικού" /></td>
                            <g:set var="appformid" value="${applicationFormInstance.id}" />
                            <td valign="top" class="value"><g:link title="Βιογραφικό Σημείωμα" controller="candidate" action="downloadbio" id="${applicationFormInstance.appFormCandidate.id}" params="[appformid:appformid]" method="POST">${fieldValue(bean: applicationFormInstance, field: "bioFilepath")}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="applicationForm.applicationFilepath.label" default="Αρχείο Υπ. Δήλωσης" /></td>
                            <g:set var="appformid" value="${applicationFormInstance.id}" />
                            <td valign="top" class="value"><g:link title="Υπεύθυνη Δήλωση" controller="candidate" action="downloadapp" id="${applicationFormInstance.appFormCandidate.id}" params="[appformid:appformid]" method="POST">${fieldValue(bean: applicationFormInstance, field: "applicationFilepath")}</g:link></td>

                        </tr>
                    
                    <tr class="prop" style="background-color: #eee">
                        		<td valign="top" class="name"><g:message code="application.hasValidBio.label" default="Κατάσταση Βιογραφικού" /></td>
                            	<td valign="top" class="value">
                            		<g:if test="${applicationFormInstance.bioFileCheckStatus == null || applicationFormInstance.bioFileCheckStatus.equals('')}">
                            		Δεν έχει ελεγχθεί</g:if>
                            		<g:else>${applicationFormInstance.bioFileCheckStatus}</g:else>
                            		
                            	</td>
                            </tr>
                            <tr class="prop" style="background-color: #eee">
                            	<td valign="top" class="name"><g:message code="application.hasValidAppForm.label" default="Καστάσταση Υπ. Δήλωσης" /></td>
                            
                            	<td valign="top" class="value">
                            		<g:if test="${applicationFormInstance.bioFileCheckStatus == null || applicationFormInstance.appFormFileCheckStatus.equals('')}">
                            		Δεν έχει ελεγχθεί</g:if>
                            		<g:else>${applicationFormInstance.appFormFileCheckStatus}</g:else>
                            	</td>
                            </tr>
                            
                            <tr class="prop" style="background-color: #eee">
                            	<td valign="top" class="name"><g:message code="application.fileStatusNotes.label" default="Σημειώσεις κατάστασης αρχείων" /></td>
                            
                            	<td valign="top" class="value">
                            		${applicationFormInstance.fileStatusNotes}
                            	</td>
                            </tr>
                            
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="applicationForm.appFormApplications.label" default="Κωδικοί έργων" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${applicationFormInstance.appFormApplications}" status="i" var="a">
                                    <li>
                                    	<g:link title="Πληροφορίες για το έργο" controller="project" action="show" id="${a?.project?.id}">${a?.project?.code}</g:link>
                                    	<g:set var="candID" value="${applicationFormInstance?.appFormCandidate?.id }"></g:set>
                                    	<g:link style="position:relative; top:5px" title="Επεξεργασία για το συγκεκριμένο έργο" controller="application" action="edit" id="${applicationFormInstance.appFormApplications[i].id}" params="['candidateID' : candID]"><img style="width:20px" src="${request.getContextPath()}/images/edit_icon.png"/></g:link>
                                    	<g:if test="${applicationFormInstance.appFormApplications[i]?.applicationEvaluation?.applicationEvalLevel?.toString() != null }">
                                    		&nbsp;&nbsp; (${applicationFormInstance.appFormApplications[i]?.applicationEvaluation?.applicationEvalLevel?.toString() }) 
                                    	</g:if><br/>
                                    	<div id="result" style="margin-top: 5px">
                                    	<b>Αποτέλεσμα:</b><i> ${applicationFormInstance.appFormApplications[i]?.applicationResult?.notes}</i>
                                    	</div>
                                    	<div id="result" style="margin-top: 5px"></div>
                                    </li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
                
                <g:link title="Επεξεργασία" action="edit" id="${applicationFormInstance?.id}" method="POST"><img src="${request.getContextPath()}/images/edit_icon.png"></g:link>
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
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance?.appFormCandidate, field: "firstname")}</strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.lastname.label" default="Επίθετο" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance?.appFormCandidate, field: "lastname")}</strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance?.appFormCandidate, field: "email")}</strong></td>
                            
                        </tr>
                    
                   	 	<tr class="prop">
                            <td valign="top" class="name"><g:message code="application.street.label" default="Οδός" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance?.appFormCandidate, field: "street")}</strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.streetno.label" default="Αριθμός" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance?.appFormCandidate, field: "streetno")}</strong></td>
                            
                        </tr>
                        
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.postalcode.label" default="Ταχυδρομικός Κώδικας" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance?.appFormCandidate, field: "postalcode")}</strong></td>
                            
                        </tr>
                        
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.city.label" default="Πόλη" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance?.appFormCandidate, field: "city")}</strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.country.label" default="Χώρα" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance?.appFormCandidate, field: "country")}</strong></td>
                            
                        </tr>
  
                          <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.phone.label" default="Τηλέφωνο" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance?.appFormCandidate, field: "phone")}</strong></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.yearOfBirth.label" default="Έτος Γέννησης" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance?.appFormCandidate, field: "yearOfBirth")}</strong></td>
                            
                        </tr>
                             
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Website" /></td>
                            
                            <td valign="top" class="value"><strong>${fieldValue(bean: applicationFormInstance?.appFormCandidate, field: "website")}</strong></td>
                            
                        </tr>
                    
                    <tr class="prop" style="background-color: #ddd">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Επίπεδο Εκπαίδευσης" /></td>
                            
                            <td valign="top" class="value"><strong>${applicationFormInstance?.appFormCandidate?.educationalLevel}</strong></td>
                            
                        </tr>
                        
                    	<tr class="prop" style="background-color: #ddd">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Αξιολόγηση" /></td>
                            
                            <td valign="top" class="value"><strong>${applicationFormInstance?.appFormCandidate?.candidateEvaluation?.candidateEvalLevel}</strong></td>
                            
                        </tr>
                        
                        <tr class="prop" style="background-color: #ddd">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Σημειώσεις αξιολόγησης" /></td>
                            
                            <td valign="top" class="value"><strong>${applicationFormInstance?.appFormCandidate?.candidateEvaluation?.notes}</strong></td>
                            
                        </tr>
                        
                    <tr><td colspan="2">
                    	<g:link title="Προβολή υποψηφίου" controller="candidate" action="show" id="${applicationFormInstance?.appFormCandidate.id}" method="POST"><img src="${request.getContextPath()}/images/show_icon.png"></g:link>
                         <g:link title="Επεξεργασία υποψηφίου" controller="candidate" action="adminedit" id="${applicationFormInstance?.appFormCandidate.id}" method="POST"><img src="${request.getContextPath()}/images/edit_icon.png"></g:link>
 					</td></tr>
                    </tbody>
                </table>
  
            </div>
        </div>
    </body>
</html>
