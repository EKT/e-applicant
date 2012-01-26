
<%@ page import="gr.ekt.applicanttracker.Invitation"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'invitation.label', default: 'Invitation')}" />
<title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>

<g:render template="/common/profilemenu"
	model="['candidateInstance':candidateInstance]" />

<div class="body">
<h1><g:message code="Λίστα ανοιχτών προσκλήσεων"
	args="[entityName]" /></h1>

<br />
<br />

<g:if test="${flash.message}">
	<div class="message">
	${flash.message}
	</div>
</g:if> <g:if test="${invitationInstanceList.size() == 0 }">
            Δεν υπάρχει αυτή τη στιγμή ανοικτή πρόσκληση στην οποία να μην έχετε ήδη κάνει αίτηση!
            </g:if> <g:else>

	<div class="list">
	<table>
		<thead>
			<tr>
				<th class="sortable" style="color: #333; font-size: 10px">
				Λειτουργία</th>

				<g:sortableColumn property="code"
					title="${message(code: 'invitation.code.label', default: 'Όνομα')}" />

				<g:sortableColumn property="startDate"
					title="${message(code: 'invitation.startDate.label', default: 'Ημ. Έναρξης')}" />

				<g:sortableColumn property="endDate"
					title="${message(code: 'invitation.endDate.label', default: 'Ημ. Λήξης')}" />

				<th class="sortable" style="color: #333; font-size: 10px">
				Ενέργεια</th>

			</tr>
		</thead>
		<tbody>
			<g:each in="${invitationInstanceList}" status="i"
				var="invitationInstance">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

					<td><g:if test="${invitationInstance.isInvitationEnabled() }">
						<img src="${request.getContextPath()}/images/valid_icon.png">
					</g:if> <g:else>
						<img src="${request.getContextPath()}/images/not_valid_icon.png">
					</g:else></td>

					<td>
					${fieldValue(bean: invitationInstance, field: "code")}
					</td>

					<td><g:formatDate date="${invitationInstance.startDate}" /></td>
					<td><g:formatDate date="${invitationInstance.endDate}" /></td>

					<td><g:def var="invid" value="${invitationInstance.id }" /> <g:link
						title="Αίτηση" action="appformcreate" id="${candidateInstance.id}"
						params="[invitationid: invid]" method="POST">
						<img src="${request.getContextPath()}/images/edit_icon.png">
					</g:link></td>

				</tr>
			</g:each>
		</tbody>
	</table>
	</div>
</g:else>
<br/><br/>
</div>
</body>
</html>
