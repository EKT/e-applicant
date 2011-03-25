

<%@ page import="gr.ekt.applicanttracker.Invitation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'invitation.label', default: 'Invitation')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <!-- <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div> -->
        
        <g:render template="/common/menu" model="['type':'2']"/>
        
        <div class="body">
            <h1><g:message code="Επεξεργασία πρόσκλησης" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${invitationInstance}">
            <div class="errors">
                <g:renderErrors bean="${invitationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="update" method="post" >
                <g:hiddenField name="id" value="${invitationInstance?.id}" />
                <g:hiddenField name="version" value="${invitationInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="code"><g:message code="invitation.code.label" default="Κωδικός Πρόσκλησης" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: invitationInstance, field: 'code', 'errors')}">
                                    <g:textField name="code" value="${invitationInstance?.code}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="enabled"><g:message code="invitation.enabled.label" default="Ενεργή?" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: invitationInstance, field: 'enabled', 'errors')}">
                                    <g:checkBox name="enabled" value="${invitationInstance?.enabled}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="startDate"><g:message code="invitation.startDate.label" default="Ημ. 'Εναρξης" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: invitationInstance, field: 'startDate', 'errors')}">
                                    <g:datePicker style="width:50px" name="startDate" precision="minute" value="${invitationInstance?.startDate}"  />
                                </td>
                            </tr>
                        
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="endDate"><g:message code="invitation.endDate.label" default="Ημ. Λήξης" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: invitationInstance, field: 'endDate', 'errors')}">
                                    <g:datePicker name="endDate" precision="minute" value="${invitationInstance?.endDate}"  />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="projects"><g:message code="invitation.projects.label" default="Έργα" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: invitationInstance, field: 'projects', 'errors')}">
                                    
<ul>
<g:each in="${invitationInstance?.projects?}" var="p">
    <li><g:link controller="project" action="show" id="${p.id}">${p?.code}</g:link></li>
</g:each>
</ul>
<br/>
<g:link controller="project" action="create" params="['invitation.id': invitationInstance?.id]">${message(code: 'Προσθήκη νέου έργου', args: [message(code: 'project.label', default: 'Project')])}</g:link>

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                
                              <div style="text-align: center; padding-top: 20p; width:705px"><input style="width:250px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Αποθήκευση Πρόσκλησης" /></div>
  
                <!-- <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div> -->
            </g:form>
        </div>
    </body>
</html>
