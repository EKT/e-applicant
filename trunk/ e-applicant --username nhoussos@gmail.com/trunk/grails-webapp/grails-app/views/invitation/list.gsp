
<%@ page import="gr.ekt.applicanttracker.Invitation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'invitation.label', default: 'Invitation')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/common/menu" model="['type':'2']"/>
        
        <div class="body">
            <h1><g:message code="Λίστα προσκλήσεων (Σύνολο: ${invitationInstanceTotal})" args="[entityName]" /></h1>
            <br/><br/>
            
            <g:link title="Δημιουργία πρόσκλησης" action="create"><img src="${request.getContextPath()}/images/create_icon.png"></g:link>
            
            <br/><br/>
            
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        	<th class="sortable" style="color: #333; font-size: 10px"> Λειτουργία </th>
                        	
                            <g:sortableColumn property="id" title="${message(code: 'invitation.id.label', default: 'Κωδικός εγγραφής')}" />
                        
                            <g:sortableColumn property="code" title="${message(code: 'invitation.code.label', default: 'Όνομα')}" />
                        
                            <g:sortableColumn property="enabled" title="${message(code: 'invitation.enabled.label', default: 'Ενεργοποιημένη')}" />
                        
                           	<g:sortableColumn property="startDate" title="${message(code: 'invitation.startDate.label', default: 'Ημ. Έναρξης')}" />
 
                            <g:sortableColumn property="endDate" title="${message(code: 'invitation.endDate.label', default: 'Ημ. Λήξης')}" />
 
                        	<th class="sortable" style="color: #333; font-size: 10px"> Αριθμός Έργων</th>
                        	
                        	<th class="sortable" style="color: #333; font-size: 10px"> Διεύθυνση φόρμας δημιουργίας</th>
                        	
                        	<th class="sortable" style="color: #333; font-size: 10px"> Ενέργεια </th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${invitationInstanceList}" status="i" var="invitationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                        	<td>
                        		<g:if test="${invitationInstance.isInvitationEnabled() }">
                        			<img src="${request.getContextPath()}/images/valid_icon.png">
                        		</g:if>
                        		<g:else>
                        			<img src="${request.getContextPath()}/images/not_valid_icon.png">
                        		</g:else>
                        	</td>
                        
                            <td><g:link action="show" id="${invitationInstance.id}">${fieldValue(bean: invitationInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: invitationInstance, field: "code")}</td>
                        
                            <td><g:formatBoolean boolean="${invitationInstance.enabled}" /></td>
                        
                        	<td><g:formatDate date="${invitationInstance.startDate}" /></td>
                            <td><g:formatDate date="${invitationInstance.endDate}" /></td>
                            
                        	<td><g:link title="Δείτε τα έργα" action="list" controller="project" params="['invitation.id': invitationInstance?.id]">${invitationInstance.projects.size()}</g:link> <g:link style="font-size:10px" title="Δημιουργία νέου έργου" action="create" controller="project" params="['invitation.id': invitationInstance?.id]">(Δημιουργία νέου έργου)</g:link></td>
                        
                        	<td><g:link title="Φόρμα δημιουργίας νέας αίτησης για την πρόσκληση" action="create" controller="application" params="[invid:invitationInstance?.id]">Φόρμα εισαγωγής αίτησης</g:link></td>
                        
                        	<td> 
                        		<g:link title="Προβολή" action="show" id="${invitationInstance.id}" method="POST"><img src="${request.getContextPath()}/images/show_icon.png"></g:link>
                        		<g:link title="Επεξεργασία" action="edit" id="${invitationInstance.id}" method="POST"><img src="${request.getContextPath()}/images/edit_icon.png"></g:link>
                        		<g:link title="Διαγραφή" action="delete" id="${invitationInstance.id}" method="POST"><img src="${request.getContextPath()}/images/delete_icon.png" onclick="return confirm('Είστε σίγουρος/η;')"></g:link>
                        	</td>
                        	
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${invitationInstanceTotal}" max="30" next="Επόμενη" prev="Προηγούμενη"/> 
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
