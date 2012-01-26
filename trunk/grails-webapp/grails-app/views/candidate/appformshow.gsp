
<%@ page import="gr.ekt.applicanttracker.ApplicationForm"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<g:set var="entityName"
	value="${message(code: 'applicationForm.label', default: 'ApplicationForm')}" />
<title><g:message code="default.show.label" args="[entityName]" /></title>
</head>
<body>

<g:render template="/common/profilemenu"
	model="['candidateInstance':candidateInstance]" />

<div class="body">
<h1>Στοιχεία Αίτησης για την πρόσκληση: ${appFormInstance.appFormApplications[0].project.invitation.code }
</h1>
<g:if test="${flash.message}">
	<div class="message">
	${flash.message}
	</div>
</g:if>
<div class="dialog">
<table>
	<tbody>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="applicationForm.id.label" default="Κωδικός αίτησης" /></td>

			<td valign="top" class="value">
			${fieldValue(bean: appFormInstance, field: "id")}
			</td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="applicationForm.dateInitial.label" default="Ημερομηνία Εισαγωγής" /></td>

			<td valign="top" class="value"><g:formatDate
				date="${appFormInstance?.dateInitial}" /></td>

		</tr>
		
		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="applicationForm.dateIssued.label" default="Ημερομηνία Τελευταίας Αλλαγής" /></td>

			<td valign="top" class="value"><g:formatDate
				date="${appFormInstance?.dateIssued}" /></td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="applicationForm.bioFilepath.label"
				default="Αρχείο Βιογραφικού" /></td>

			<td valign="top" class="value">
			<g:def var="appformid" value="${appFormInstance.id }" />
			<!--${fieldValue(bean: appFormInstance, field: "bioFilepath")}-->
			 <g:link controller="candidate" action="downloadbio" id="${appFormInstance.appFormCandidate.id }" params="[appformid: appformid]">${fieldValue(bean: appFormInstance, field: "bioFilepath")}</g:link>
			 
			</td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="applicationForm.applicationFilepath.label"
				default="Αρχείο υπεύθυνης δήλωσης" /></td>

			<td valign="top" class="value">
			<!--${fieldValue(bean: appFormInstance, field: "applicationFilepath")}-->
			 <g:link controller="candidate" action="downloadapp" id="${appFormInstance.appFormCandidate.id }" params="[appformid: appformid]">${fieldValue(bean: appFormInstance, field: "applicationFilepath")}</g:link>
			 
			
			</td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="applicationForm.appFormApplications.label"
				default="Κωδικοί έργων" /></td>

			<td valign="top" style="text-align: left;" class="value">
			<ul>
				<g:each in="${appFormInstance.appFormApplications}" var="a">
					<li>
					${a?.project.code}<!-- <g:link controller="application" action="show" id="${a.id}">${a?.project.code}</g:link> --></li>
				</g:each>
			</ul>
			</td>
		</tr>
	</tbody>
</table>

<br />
<br />
<br />

</div>
</body>
</html>
