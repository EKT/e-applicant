

<%@ page import="gr.ekt.applicanttracker.Application" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}" />
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
            <g:hasErrors bean="${applicationInstance}">
            <div class="errors">
                <g:renderErrors bean="${applicationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="candidate"><g:message code="application.candidate.label" default="Candidate" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'candidate', 'errors')}">
                                    <g:select name="candidate.id" from="${gr.ekt.applicanttracker.Candidate.list()}" optionKey="id" value="${applicationInstance?.candidate?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="applicationCommitteeEvaluation"><g:message code="application.applicationCommitteeEvaluation.label" default="Application Committee Evaluation" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'applicationCommitteeEvaluation', 'errors')}">
                                    <g:select name="applicationCommitteeEvaluation.id" from="${gr.ekt.applicanttracker.CommitteeApplicationEvaluation.list()}" optionKey="id" value="${applicationInstance?.applicationCommitteeEvaluation?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="applicationResult"><g:message code="application.applicationResult.label" default="Application Result" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'applicationResult', 'errors')}">
                                    <g:select name="applicationResult.id" from="${gr.ekt.applicanttracker.EATResult.list()}" optionKey="id" value="${applicationInstance?.applicationResult?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="applicationForm"><g:message code="application.applicationForm.label" default="Application Form" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'applicationForm', 'errors')}">
                                    <g:select name="applicationForm.id" from="${gr.ekt.applicanttracker.ApplicationForm.list()}" optionKey="id" value="${applicationInstance?.applicationForm?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="project"><g:message code="application.project.label" default="Project" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'project', 'errors')}">
                                    <g:select name="project.id" from="${gr.ekt.applicanttracker.Project.list()}" optionKey="id" value="${applicationInstance?.project?.id}"  />
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
