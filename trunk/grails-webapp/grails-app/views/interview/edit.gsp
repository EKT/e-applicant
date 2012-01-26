

<%@ page import="gr.ekt.applicanttracker.Interview" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'interview.label', default: 'Interview')}" />
        <title><g:message code="Επεξεργασία συνέντευξης" args="[entityName]" /></title>
    </head>
    <body>
       <g:render template="/common/menu" model="['type':'6']"/>
       
        <div class="body">
            <h1><g:message code="Επεξεργασία συνέντευξης για τον υποψήφιο: ${candidateInstance.lastname } ${candidateInstance.firstname }" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${interviewInstance}">
            <div class="errors">
                <g:renderErrors bean="${interviewInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" action="update">
                <g:hiddenField name="id" value="${interviewInstance?.id}" />
                <g:hiddenField name="version" value="${interviewInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="interviewDate"><g:message code="interview.interviewDate.label" default="Ημ. Συνέντευξης" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: interviewInstance, field: 'interviewDate', 'errors')}">
                                    <g:datePicker name="interviewDate" precision="day" value="${interviewInstance?.interviewDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="notes"><g:message code="interview.notes.label" default="Σημειώσεις" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: interviewInstance, field: 'notes', 'errors')}">
                                    <g:textArea name="notes" value="${interviewInstance?.notes}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
               <div style="text-align: center; padding-top: 20px; width:705px"><input style="width:250px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Αποθήκευση" /></div>
            </g:form>
        </div>
    </body>
</html>
