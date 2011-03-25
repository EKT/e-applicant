
<%@ page import="gr.ekt.applicanttracker.Application" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <!-- div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="Αρχική" /></g:link></span>
        </div>-->
        <g:render template="/common/menu" model="['type':'1']"/>
        <div class="body">
            <h1><g:message code="Αίτηση" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                    	<tr class="prop">
                            <td valign="top" class="name"><g:message code="application.invitation.label" default="Πρόσκληση" /></td>
                            
                            <td valign="top" class="value"><g:link title="Δείτε την πρόσκληση" action="show" controller="invitation" id="${applicationInstance.invitation?.id}">${fieldValue(bean: applicationInstance, field: "invitation.code")}</g:link></td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.id.label" default="Kωδικός αίτησης" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.firstname.label" default="Όνομα" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "firstname")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.lastname.label" default="Επίθετο" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "lastname")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "email")}</td>
                            
                        </tr>
                    
                   	 	<tr class="prop">
                            <td valign="top" class="name"><g:message code="application.street.label" default="Οδός" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "street")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.streetno.label" default="Αριθμός" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "streetno")}</td>
                            
                        </tr>
                        
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.postalcode.label" default="Ταχυδρομικός Κώδικας" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "postalcode")}</td>
                            
                        </tr>
                        
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.city.label" default="Πόλη" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "city")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.country.label" default="Χώρα" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "country")}</td>
                            
                        </tr>
  
                          <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.phone.label" default="Τηλέφωνο" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "phone")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.yearOfBirth.label" default="Έτος Γέννησης" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "yearOfBirth")}</td>
                            
                        </tr>
                             
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Website" /></td>
                            
                            <td valign="top" class="value"><a target="_blank" href="${fieldValue(bean: applicationInstance, field: "website")}">${fieldValue(bean: applicationInstance, field: "website")}</a></td>
                            
                        </tr>
                                         
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.projects.label" default="Κωδικοί έργων" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${applicationInstance.projects}" var="p">
                                    <li><g:link controller="project" action="show" id="${p.id}">${p?.code}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.bioFilepath.label" default="Αρχείο Βιογραφικού" /></td>
                            
                            <!--  <td valign="top" style="text-align: left;" class="value"> -->
                            <td valign="top" style="text-align: left;" class="value"><g:link controller="application" action="downloadbio" id="${applicationInstance.id}">${applicationInstance.bioFilepath}</g:link></td>

                                </ul>
                            </td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.applicationFilepath.label" default="Αρχείο Αίτησης" /></td>
                            
                            <!--  <td valign="top" style="text-align: left;" class="value"> -->
                            <td valign="top" style="text-align: left;" class="value"><g:link controller="application" action="downloadapp" id="${applicationInstance.id}">${applicationInstance.applicationFilepath}</g:link></td>

                                </ul>
                            </td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.country.label" default="Ημερομηνία Εγγραφής" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "dateIssued")}</td>
                            
                        </tr>
                        
                        <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN,ROLE_REVIEWER">
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.country.label" default="Τρόπος υποβολής αίτησης" /></td>
                            
                             <td valign="top" class="value">
                            <g:if test="${applicationInstance.throughPost}">Έντυπη υποβολή</g:if>
                            <g:else>Ηλεκτρονική υποβολή</g:else>
                            </td>
                            
                        </tr>
                        
                        	<tr class="prop">
                        		<td valign="top" class="name"><g:message code="application.hasValidBio.label" default="Κατάσταση Βιογραφικού" /></td>
                            	<td valign="top" class="value">
                            		<g:if test="${applicationInstance.bioFileCheckStatus == null || applicationInstance.bioFileCheckStatus.equals('')}">
                            		Δεν έχει ελεγχθεί</g:if>
                            		<g:else>${applicationInstance.bioFileCheckStatus}</g:else>
                            		
                            	</td>
                            </tr>
                            <tr class="prop">
                            	<td valign="top" class="name"><g:message code="application.hasValidAppForm.label" default="Καστάσταση Υπ. Δήλωσης" /></td>
                            
                            	<td valign="top" class="value">
                            		<g:if test="${applicationInstance.bioFileCheckStatus == null || applicationInstance.appFormFileCheckStatus.equals('')}">
                            		Δεν έχει ελεγχθεί</g:if>
                            		<g:else>${applicationInstance.appFormFileCheckStatus}</g:else>
                            	</td>
                            </tr>
                            
                            <tr class="prop">
                            	<td valign="top" class="name"><g:message code="application.fileStatusNotes.label" default="Σημειώσεις κατάστηασης αρχείων" /></td>
                            
                            	<td valign="top" class="value">
                            		${applicationInstance.fileStatusNotes}
                            	</td>
                            </tr>
                            
                            <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.appSkills.label" default="Προσόντα" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                            	<g:if test='${applicationInstance.appSkills.size() == 0}'>Δεν έχουν οριστεί ακόμα
                            		</g:if>
                                <ul>
                                <g:each in="${applicationInstance.appSkills}" var="p">
                                    <li><g:link controller="skill" action="show" id="${p.id}">${p?.title}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                             <tr class="prop">
                            	<td valign="top" class="name"><g:message code="application.skillNotes.label" default="Σημειώσεις προσόντων" /></td>
                            
                            	<td valign="top" class="value">
                            		${applicationInstance.skillNotes}
                            	</td>
                            </tr>
                            
                        </tr>
                        </g:ifAnyGranted>
                        
                    </tbody>
                </table>
            </div>
            <!--  <div class="buttons"> -->
            <br/><br/>
                <g:link title="Επεξεργασία" action="edit" id="${applicationInstance?.id}" method="POST"><img src="${request.getContextPath()}/images/edit_icon.png"></g:link>
                <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                	<g:link title="Διαγραφή" action="delete" id="${applicationInstance?.id}" method="POST"><img src="${request.getContextPath()}/images/delete_icon.png" onclick="return confirm('Είστε σίγουρος/η;')"></g:link>
                </g:ifAnyGranted>
            <!--             		
                <g:form>
                    <g:hiddenField name="id" value="${applicationInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>-->
        </div>
    </body>
</html>
