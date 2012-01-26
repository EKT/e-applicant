

<%@ page import="gr.ekt.applicanttracker.ApplicationForm" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'applicationForm.label', default: 'ApplicationForm')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${applicationFormInstance}">
            <div class="errors">
                <g:renderErrors bean="${applicationFormInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateIssued"><g:message code="applicationForm.dateIssued.label" default="Date Issued" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationFormInstance, field: 'dateIssued', 'errors')}">
                                    <g:datePicker name="dateIssued" precision="day" value="${applicationFormInstance?.dateIssued}" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bioFilepath"><g:message code="applicationForm.bioFilepath.label" default="Bio Filepath" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationFormInstance, field: 'bioFilepath', 'errors')}">
                                    <g:textField name="bioFilepath" value="${applicationFormInstance?.bioFilepath}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="applicationFilepath"><g:message code="applicationForm.applicationFilepath.label" default="Application Filepath" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationFormInstance, field: 'applicationFilepath', 'errors')}">
                                    <g:textField name="applicationFilepath" value="${applicationFormInstance?.applicationFilepath}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="appFormCandidate"><g:message code="applicationForm.appFormCandidate.label" default="App Form Candidate" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationFormInstance, field: 'appFormCandidate', 'errors')}">
                                    <g:select name="appFormCandidate.id" from="${gr.ekt.applicanttracker.Candidate.list()}" optionKey="id" value="${applicationFormInstance?.appFormCandidate?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
