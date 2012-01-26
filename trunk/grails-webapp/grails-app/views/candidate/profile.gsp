
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />

<title>My EKT Profile</title>
</head>
<body>

<g:render template="/common/profilemenu"
	model="['candidateInstance':candidateInstance]" />

<g:if test="${flash.message}">
	<div class="message">${flash.message}</div>
</g:if>

<table>
	<tbody>
		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.website.label" default="Α/Α χρήστη" /></td>

			<td valign="top" class="value">
			<strong>${fieldValue(bean: candidateInstance, field: "id")}</strong>
			</td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.firstname.label" default="Όνομα" /></td>

			<td valign="top" class="value"><strong>
			${fieldValue(bean: candidateInstance, field: "firstname")}
			</strong></td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.lastname.label" default="Επίθετο" /></td>

			<td valign="top" class="value"><strong>
			${fieldValue(bean: candidateInstance, field: "lastname")}
			</strong></td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.email.label" default="Email" /></td>

			<td valign="top" class="value"><strong>
			${fieldValue(bean: candidateInstance, field: "email")}
			</strong></td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.street.label" default="Οδός" /></td>

			<td valign="top" class="value"><strong>
			${fieldValue(bean: candidateInstance, field: "street")}
			</strong></td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.streetno.label" default="Αριθμός" /></td>

			<td valign="top" class="value"><strong>
			${fieldValue(bean: candidateInstance, field: "streetno")}
			</strong></td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.postalcode.label" default="Ταχυδρομικός Κώδικας" /></td>

			<td valign="top" class="value"><strong>
			${fieldValue(bean: candidateInstance, field: "postalcode")}
			</strong></td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.city.label" default="Πόλη" /></td>

			<td valign="top" class="value"><strong>
			${fieldValue(bean: candidateInstance, field: "city")}
			</strong></td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.country.label" default="Χώρα" /></td>

			<td valign="top" class="value"><strong>
			${fieldValue(bean: candidateInstance, field: "country")}
			</strong></td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.phone.label" default="Τηλέφωνο" /></td>

			<td valign="top" class="value"><strong>
			${fieldValue(bean: candidateInstance, field: "phone")}
			</strong></td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.yearOfBirth.label" default="Έτος Γέννησης" /></td>

			<td valign="top" class="value"><strong>
			${fieldValue(bean: candidateInstance, field: "yearOfBirth")}
			</strong></td>

		</tr>

		<tr class="prop">
			<td valign="top" class="name"><g:message
				code="application.website.label" default="Website" /></td>

			<td valign="top" class="value"><strong>
			${fieldValue(bean: candidateInstance, field: "website")}
			</strong></td>

		</tr>
	</tbody>
</table>

<br />
<br />
</body>
</html>
