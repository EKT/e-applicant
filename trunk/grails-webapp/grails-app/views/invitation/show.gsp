
<%@ page import="gr.ekt.applicanttracker.Invitation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'invitation.label', default: 'Invitation')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <!-- <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div> -->
        <g:render template="/common/menu" model="['type':'2']"/>
        
        <div class="body">
            <h1><g:message code="Πρόσκληση" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="invitation.id.label" default="ID" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: invitationInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="invitation.code.label" default="Κωδικός Πρόσκλησης" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: invitationInstance, field: "code")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="invitation.code.label" default="Ενεργή?" /></td>
                            <td><g:if test="${invitationInstance.enabled}">ΝΑΙ</g:if>
                            <g:else>ΌΧΙ</g:else></td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="invitation.code.label" default="Ημ. Έναρξης" /></td>
                            <td>
                            	${invitationInstance.startDate.toString()}
                            </td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="invitation.code.label" default="Ημ. Λήξης" /></td>
                            <td>
                            	${invitationInstance.endDate.toString()}
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="invitation.projects.label" default="Έργα" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${invitationInstance.projects}" var="p">
                                    <li><g:link controller="project" action="show" id="${p.id}">${p.code}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            
            <br/><br/>
            <g:link title="Επεξεργασία" action="edit" id="${invitationInstance?.id}" method="POST"><img src="${request.getContextPath()}/images/edit_icon.png"></g:link>
                <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                	<g:link title="Διαγραφή" action="delete" id="${invitationInstance?.id}" method="POST"><img src="${request.getContextPath()}/images/delete_icon.png" onclick="return confirm('Είστε σίγουρος/η;')"></g:link>
                </g:ifAnyGranted>
                
            <!-- <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${invitationInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form> -->
            </div>
        </div>
    </body>
</html>
