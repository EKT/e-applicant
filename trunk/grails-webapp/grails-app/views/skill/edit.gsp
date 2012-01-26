

<%@ page import="gr.ekt.applicanttracker.Skill" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'skill.label', default: 'Skill')}" />
        <title><g:message code="Επεξεργασία προσόντος" args="[entityName]" /></title>
    </head>
    <body>
        <!-- <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div> -->
        <g:render template="/common/menu" model="['type':'4']"/>
        
        <div class="body">
            <h1><g:message code="Επεξεργασία προσόντος" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${skillInstance}">
            <div class="errors">
                <g:renderErrors bean="${skillInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="update" method="post" >
                <g:hiddenField name="id" value="${skillInstance?.id}" />
                <g:hiddenField name="version" value="${skillInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="title"><g:message code="skill.title.label" default="Τίτλος" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: skillInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${skillInstance?.title}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="skill.description.label" default="Περιγραφή" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: skillInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" value="${skillInstance?.description}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                
                 <div style="text-align: center; padding-top: 20p; width:705px"><input style="width:250px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Αποθήκευση Προσόντος" /></div>
 
 
                <!-- <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div> -->
            </g:form>
        </div>
    </body>
</html>
