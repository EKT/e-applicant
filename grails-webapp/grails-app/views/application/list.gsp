
<%@ page import="gr.ekt.applicanttracker.Application" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'application.id.label', default: 'Id')}" />
                        
                            <th><g:message code="application.candidate.label" default="Candidate" /></th>
                        
                            <th><g:message code="application.applicationCommitteeEvaluation.label" default="Application Committee Evaluation" /></th>
                        
                            <th><g:message code="application.applicationResult.label" default="Application Result" /></th>
                        
                            <th><g:message code="application.applicationForm.label" default="Application Form" /></th>
                        
                            <th><g:message code="application.project.label" default="Project" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${applicationInstanceList}" status="i" var="applicationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${applicationInstance.id}">${fieldValue(bean: applicationInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: applicationInstance, field: "candidate")}</td>
                        
                            <td>${fieldValue(bean: applicationInstance, field: "applicationCommitteeEvaluation")}</td>
                        
                            <td>${fieldValue(bean: applicationInstance, field: "applicationResult")}</td>
                        
                            <td>${fieldValue(bean: applicationInstance, field: "applicationForm")}</td>
                        
                            <td>${fieldValue(bean: applicationInstance, field: "project")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${applicationInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
