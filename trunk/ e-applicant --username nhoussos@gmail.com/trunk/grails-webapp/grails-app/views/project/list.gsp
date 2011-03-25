
<%@ page import="gr.ekt.applicanttracker.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/common/menu" model="['type':'3']"/>
        
        <div class="body">
            <h1><g:message code="Λίστα έργων (Σύνολο: ${projectInstanceTotal})" args="[entityName]" /></h1>
            <br/><br/>
            
             <g:link title="Δημιουργία έργου" action="create"><img src="${request.getContextPath()}/images/create_icon.png"></g:link>
             
             <br/><br/>
             
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'project.id.label', default: 'ID')}" />
                        
                            <g:sortableColumn property="code" title="${message(code: 'project.code.label', default: 'Κωδικός έργου')}" />
                            
                            <g:sortableColumn property="code" title="${message(code: 'project.title.label', default: 'Τίτλος')}" />
                            <g:sortableColumn property="code" title="${message(code: 'project.duration.label', default: 'Διάρκεια')}" />
                            <g:sortableColumn property="code" title="${message(code: 'project.noOfJobs.label', default: 'Αρ. Θέσεων')}" />
                        
                            <g:sortableColumn property="discipline" title="${message(code: 'project.discipline.label', default: 'Γνωστικός τομέας')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'project.description.label', default: 'Περιγραφή')}" />
                        
                            <th><g:message code="project.invitation.label" default="Πρόσκληση" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${projectInstanceList}" status="i" var="projectInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${projectInstance.id}">${fieldValue(bean: projectInstance, field: "id")}</g:link></td>
                        
                        	<td><g:link action="show" id="${projectInstance.id}">${fieldValue(bean: projectInstance, field: "code")}</g:link></td>
                        
                        	<td><div style="width:300px">${fieldValue(bean: projectInstance, field: "title")}</div></td>
                        	
                        	<td><center>${fieldValue(bean: projectInstance, field: "duration")}</center></td>
                        	
                        	<td><div style="width:70px"><center>${fieldValue(bean: projectInstance, field: "noOfJobs")}</center></div></td>
                        	
                            <td>${fieldValue(bean: projectInstance, field: "discipline")}</td>
                        
                            <td>${fieldValue(bean: projectInstance, field: "description")}</td>
                        
                            <td>${projectInstance.invitation?.code}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

            <div class="paginateButtons">
                <g:paginate total="${projectInstanceTotal}" max="30" next="Επόμενη" prev="Προηγούμενη"/> 
                <div style="padding-top: 20px"></div>
                <g:form action="list" method="get"> 
                	Εγγραφές ανά σελίδα&nbsp
               		<input type="text" name="max" value="<%= params.get("max") %>" style="width:30px"/>
               		<input type="submit" value="ΟΚ" style="width:30px"></input> 
               	</g:form> 
            </div>
        </div>
    </body>
</html>
