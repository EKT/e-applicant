

<%@ page import="gr.ekt.applicanttracker.Skill" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'skill.label', default: 'Skill')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <!-- <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div> -->
        <g:render template="/common/menu" model="['type':'4']"/>
        <div class="body">
            <h1><g:message code="Δημιουργία προσόντος" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${skillInstance}">
            <div class="errors">
                <g:renderErrors bean="${skillInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title"><strong><g:message code="skill.title.label" default="Τίτλος *" /></strong></label>
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
                                    <!-- <g:textField name="description" value="${skillInstance?.description}" /> -->
                                    <g:textArea name="description" value="${skillInstance?.description}" cols="50" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                	</div>
                               <div style="text-align: center; padding-top: 20px;width:700px"><input style="width:250px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Δημιουργία Προσόντος" /></div>
 
                <!-- <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div> -->
            </g:form>
        </div>
    </body>
</html>
