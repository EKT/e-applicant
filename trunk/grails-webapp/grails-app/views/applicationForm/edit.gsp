

<%@ page import="gr.ekt.applicanttracker.ApplicationForm" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'applicationForm.label', default: 'ApplicationForm')}" />
        <title><g:message code="Επεξεργασία αίτησης" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/common/menu" model="['type':'1']"/>
        <br/><br/>
        <div class="body">
            <h1><g:message code="Επεξεργασία αίτησης" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${applicationFormInstance}">
            <div class="errors">
                <g:renderErrors bean="${applicationFormInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" action="update">
                <g:hiddenField name="id" value="${applicationFormInstance?.id}" />
                <g:hiddenField name="version" value="${applicationFormInstance?.version}" />
                <div class="dialog">
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
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="applicationForm.appFormApplications.label" default="Κωδικοί έργων" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${applicationFormInstance.appFormApplications}" var="a">
                                    <li><g:link controller="project" action="show" id="${a?.project?.id}">${a?.project?.code}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr> 
						<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bioFileCheckStatus"><g:message code="application.bioFileCheckStatus.label" default="Κατάσταση Βιογραφικού" /></label>
                                </td>
                                <td>
                                	<g:select name="bioFileCheckStatus" from="${gr.ekt.applicanttracker.FileCheckStatus?.values()}" optionKey="key" optionValue="value" value="${applicationFormInstance.bioFileCheckStatus?.getKey() }" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="appFormFileCheckStatus"><g:message code="application.appFormFileCheckStatus.label" default="Κατάσταση Υπ. Δήλωσης" /></label>
                                </td>
                                <td>
                                	<g:select name="appFormFileCheckStatus" from="${gr.ekt.applicanttracker.FileCheckStatus?.values()}" optionKey="key" value="${applicationFormInstance.appFormFileCheckStatus?.getKey() }"/>
                                </td>
                            </tr>
                        
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fileStatusNotes"><g:message code="application.fileStatusNotes.label" default="Σημειώσεις κατάστασης αρχείων" /></label>
                                </td>
                                <td>
                               	 	<g:textArea name="fileStatusNotes" value="${applicationFormInstance.fileStatusNotes }" rows="5" cols="60"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                 <div style="text-align: center; padding-top: 20p; width:705px"><input style="width:250px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Αποθήκευση" /></div>

            </g:form>
        </div>
    </body>
</html>
