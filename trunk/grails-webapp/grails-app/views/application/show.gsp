
<%@ page import="gr.ekt.applicanttracker.Application" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.candidate.label" default="Candidate" /></td>
                            
                            <td valign="top" class="value"><g:link controller="candidate" action="show" id="${applicationInstance?.candidate?.id}">${applicationInstance?.candidate?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.applicationCommitteeEvaluation.label" default="Application Committee Evaluation" /></td>
                            
                            <td valign="top" class="value"><g:link controller="committeeApplicationEvaluation" action="show" id="${applicationInstance?.applicationCommitteeEvaluation?.id}">${applicationInstance?.applicationCommitteeEvaluation?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.applicationResult.label" default="Application Result" /></td>
                            
                            <td valign="top" class="value"><g:link controller="EATResult" action="show" id="${applicationInstance?.applicationResult?.id}">${applicationInstance?.applicationResult?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.applicationForm.label" default="Application Form" /></td>
                            
                            <td valign="top" class="value"><g:link controller="applicationForm" action="show" id="${applicationInstance?.applicationForm?.id}">${applicationInstance?.applicationForm?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.applicationInterviews.label" default="Application Interviews" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${applicationInstance?.applicationInterviews}" var="a">
                                    <li><g:link controller="interview" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.applicationReviewerEvaluations.label" default="Application Reviewer Evaluations" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${applicationInstance?.applicationReviewerEvaluations}" var="a">
                                    <li><g:link controller="reviewerApplicationEvaluation" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.applicationSkills.label" default="Application Skills" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${applicationInstance?.applicationSkills}" var="a">
                                    <li><g:link controller="skill" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.project.label" default="Project" /></td>
                            
                            <td valign="top" class="value"><g:link controller="project" action="show" id="${applicationInstance?.project?.id}">${applicationInstance?.project?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${applicationInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
