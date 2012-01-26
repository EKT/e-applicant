
<%@ page import="gr.ekt.applicanttracker.Interview" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'interview.label', default: 'Interview')}" />
        <title><g:message code="Λίστα Συνεντέυξεων" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/common/menu" model="['type':'6']"/>
        <div class="body">
            <h1><g:message code="Λίστα συνεντέυξεων" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'Κωδικός Συνέντευξης', default: 'Κωδικός Συνέντευξης')}" />
                        
                            <g:sortableColumn property="interviewDate" title="${message(code: 'interview.interviewDate.label', default: 'Ημ. Συνέντευξης')}" />
                        
                            <th><g:message code="interview.interViewCandidate.label" default="Υποψήφιος" /></th>
                        	
                        	<th><g:message code="interview.interViewCandidate.label" default="Κωδικός Έργου" /></th>
                        	
                            <g:sortableColumn property="notes" title="${message(code: 'interview.notes.label', default: 'Σημειώσεις')}" />
                        
                        	<th class="sortable" style="color: #333; font-size: 10px"> Ενέργεια </th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${interviewInstanceList}" status="i" var="interviewInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${fieldValue(bean: interviewInstance, field: "id")}</td>
                        
                            <td><g:formatDate date="${interviewInstance.interviewDate}" /></td>
                        
                            <td><g:link controller="candidate" action="show" id="${interviewInstance.interviewCandidate?.id }">${interviewInstance.interviewCandidate?.lastname} ${interviewInstance.interviewCandidate?.firstname}</g:link> </td>
                        	<td>${interviewInstance.interviewApplication?.project?.code }</td>
                            <td>${fieldValue(bean: interviewInstance, field: "notes")}</td>
                        
                        	<td> 
                        		<g:link title="Επεξεργασία" controller="interview" action="edit" id="${interviewInstance.id}" method="POST"><img src="${request.getContextPath()}/images/edit_icon.png"></g:link>
                        		<g:link title="Διαγραφή" controller="interview" action="delete" id="${interviewInstance.id}" method="POST"><img src="${request.getContextPath()}/images/delete_icon.png" onclick="return confirm('Είστε σίγουρος/η;')"></g:link>
                        	</td>
                        	
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${interviewInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
