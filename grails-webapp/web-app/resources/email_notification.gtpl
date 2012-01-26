<head> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
</head>
<body>
Με το παρόν μήνυμα επιβεβαιώνεται ότι έχει παραληφθεί από το Εθνικό Κέντρο Τεκμηρίωσης η αίτηση με τα παρακάτω στοιχεία:
<div>
	<p>
		Κωδικός Αίτησης: <strong>${candidateInstance.currentApplicationForm.id}</strong> (Κρατήστε το κωδικό αυτό για μελλοντική επικοινωνία με το ΕΚΤ)<br />
		Πρόσκληση: <strong>${candidateInstance.currentApplicationForm.appFormApplications[0].project.invitation.code}</strong><br />
		Κωδικοί έργων: 
		<ul>
			<% candidateInstance.currentApplicationForm.appFormApplications.each { %>
				<li><strong>${it.project.code}</strong></li>
			<% } %>
		</ul>
		Όνομα: <strong>${candidateInstance.firstname}</strong><br />
		Επίθετο: <strong>${candidateInstance.lastname}</strong><br />
		Email: <strong>${candidateInstance.email}</strong><br />
		Οδός: <strong>${candidateInstance.street}</strong><br />
		Αριθμός: <strong>${candidateInstance.streetno}</strong><br />
		Ταχυδρομικός κώδικας: <strong>${candidateInstance.postalcode}</strong><br />
		Πόλη: <strong>${candidateInstance.city}</strong><br />
		Χώρα: <strong>${candidateInstance.country}</strong><br />
		Τηλέφωνο: <strong>${candidateInstance.phone}</strong><br />
		Έτος Γέννησης: <strong>${candidateInstance.yearOfBirth}</strong><br />
		Ιστοσελίδα: <strong>${candidateInstance.website}</strong><br />
		<br />
		Αρχείο βιογραφικού: <strong>${candidateInstance.currentApplicationForm.bioFilepath}</strong><br />
		Αρχείο υπέυθυνης δήλωσης: <strong>${candidateInstance.currentApplicationForm.applicationFilepath}</strong><br />
		<br /><br />
		A/A χρήστη: <strong>${candidateInstance.id}</strong><br />
		Συνθηματικό χρήστη: <strong>${candidateInstance.user.username}</strong><br />
		Κωδικός χρήστη: <strong>${password}</strong><br />

		<br /><br />
Ευχαριστούμε θερμά για την αίτησή σας!

	</p>
</div>
</body>