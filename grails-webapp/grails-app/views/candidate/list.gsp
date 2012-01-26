
<%@ page import="gr.ekt.applicanttracker.Candidate" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'candidate.label', default: 'Candidate')}" />
        <title><g:message code="Λίστα Υποψηφίων" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/common/menu" model="['type':'5']"/>
        <br/><br/>
        <div class="body">
            <h1><g:message code="Λίστα Υποψηφίων (Σύνολο: ${candidateInstanceTotal})" args="[entityName]" /></h1>
            <br/>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
            <g:form action="list">
            Αναζήτηση με βάση το επίθετο του υποψηφίου<br/>
            	<g:textField name="candidateLastname" value="${candidateLastname }"></g:textField>
            	<g:submitButton name="Αναζήτηση" style="width:150px"/>
            </g:form>
            <br/><br/>
            <g:if test="${candidateInstanceTotal > 100 }">
            <div class="paginateButtons">
            	<g:set var="cln" value="${candidateLastname }"></g:set>
                <g:paginate total="${candidateInstanceTotal}" params="['candidateLastname': cln]" next="Επόμενη" prev="Προηγούμενη" />
            </div>
            <br/>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'candidate.id.label', default: 'Κωδικός Υποψηφίου')}" />
                        
                            <g:sortableColumn property="lastname" title="${message(code: 'candidate.firstname.label', default: 'Επίθετο')}" />
                        	<g:sortableColumn property="firstname" title="${message(code: 'candidate.firstname.label', default: 'Όνομα')}" />
                        	
                        	<g:sortableColumn property="yearOfBirth" title="${message(code: 'candidate.firstname.label', default: 'Ημ. Γέννησης')}" />
                        	
                        	<th class="sortable" style="color: #333; font-size: 10px"> Δηλώσεις </th>
                        	
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${candidateInstanceList}" status="i" var="candidateInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${candidateInstance.id}">${fieldValue(bean: candidateInstance, field: "id")}</g:link></td>
                        
                            <td><g:link action="show" id="${candidateInstance.id}">${fieldValue(bean: candidateInstance, field: "lastname")}</g:link></td>
                            
                            <td>${fieldValue(bean: candidateInstance, field: "firstname")}</td>
                        	
                        	<td>${fieldValue(bean: candidateInstance, field: "yearOfBirth")}</td>
                        	
                        	<td>${candidateInstance?.candidateApplicationForms?.size()}</td>
                        	
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <g:if test="${candidateInstanceTotal > 100 }">
            <div class="paginateButtons">
            	<g:set var="cln" value="${candidateLastname }"></g:set>
                <g:paginate total="${candidateInstanceTotal}" params="['candidateLastname': cln]" next="Επόμενη" prev="Προηγούμενη" />
            </div>
            </g:if>
        </div>
    </body>
</html>
