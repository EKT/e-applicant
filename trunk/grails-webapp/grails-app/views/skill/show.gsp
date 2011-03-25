
<%@ page import="gr.ekt.applicanttracker.Skill" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'skill.label', default: 'Skill')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <!-- <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div> -->
        <g:render template="/common/menu" model="['type':'4']"/>
        
        <div class="body">
            <h1><g:message code="Προβολή προσόντος" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="skill.id.label" default="ID" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: skillInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="skill.title.label" default="Τίτλος" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: skillInstance, field: "title")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="skill.description.label" default="Περιγραφή" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: skillInstance, field: "description")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            
               <g:link title="Επεξεργασία" action="edit" id="${skillInstance?.id}" method="POST"><img src="${request.getContextPath()}/images/edit_icon.png"></g:link>
                <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                	<g:link title="Διαγραφή" action="delete" id="${skillInstance?.id}" method="POST"><img src="${request.getContextPath()}/images/delete_icon.png" onclick="return confirm('Είστε σίγουρος/η;')"></g:link>
                </g:ifAnyGranted>
  
            <!-- <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${skillInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div> -->
        </div>
    </body>
</html>
