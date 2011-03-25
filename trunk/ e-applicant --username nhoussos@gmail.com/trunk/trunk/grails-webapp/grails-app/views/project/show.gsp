
<%@ page import="gr.ekt.applicanttracker.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <!-- <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div> -->
        <g:render template="/common/menu" model="['type':'3']"/>
        
        <div class="body">
            <h1><g:message code="Προβολή έργου" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="project.id.label" default="ID" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="project.code.label" default="Κωδικός έργου" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "code")}</td>
                            
                        </tr>
                    
                    	<tr class="prop">
                            <td valign="top" class="name"><g:message code="project.code.label" default="Τίτλος" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "title")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="project.code.label" default="Διάρκεια (σε μήνες)" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "duration")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="project.code.label" default="Αριθμός θέσεων" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "noOfJobs")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="project.discipline.label" default="Γνωστικός τομέας" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "discipline")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="project.description.label" default="Περιγραφή" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="project.invitation.label" default="Πρόσκληση" /></td>
                            
                            <td valign="top" class="value"><g:link controller="invitation" action="show" id="${projectInstance?.invitation?.id}">${projectInstance?.invitation?.code}</g:link></td>
                            
                        </tr>
                    
                    <tr class="prop">
                            <td valign="top" class="name"><g:message code="project.skills.label" default="Προσόντα" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${projectInstance.skills}" var="p">
                                    <li><g:link controller="skill" action="show" id="${p.id}">${p.title}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="project.wishSkills.label" default="Επιθυμητά προσόντα" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${projectInstance.wishSkills}" var="p">
                                    <li><g:link controller="skill" action="show" id="${p.id}">${p.title}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        
                    </tbody>
                </table>
            </div>
            <g:link title="Επεξεργασία" action="edit" id="${projectInstance?.id}" method="POST"><img src="${request.getContextPath()}/images/edit_icon.png"></g:link>
                <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                	<g:link title="Διαγραφή" action="delete" id="${projectInstance?.id}" method="POST"><img src="${request.getContextPath()}/images/delete_icon.png" onclick="return confirm('Είστε σίγουρος/η;')"></g:link>
                </g:ifAnyGranted>
            <!-- <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${projectInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div> -->
        </div>
    </body>
</html>
