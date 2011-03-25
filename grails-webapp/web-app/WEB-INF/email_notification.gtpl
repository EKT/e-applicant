<head> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/> 
</head>
<body>
Με το παρόν μήνυμα επιβεβαιώνεται ότι έχει παραληφθεί από το Εθνικό Κέντρο Τεκμηρίωσης η αίτηση με τα παρακάτω στοιχεία:
<div>
	<p>
		Κωδικός Αίτησης: <strong>${application.id}</strong> (Κρατήστε το κωδικό αυτό για μελλοντική επικοινωνία με το ΕΚΤ)<br />
		Πρόσκληση: <strong>${application.invitation?.code}</strong><br />
		Κωδικοί έργων: 
		<ul>
			<% application.projects.each { %>
				<li><strong>${it.code}</strong></li>
			<% } %>
		</ul>
		Όνομα: <strong>${application.firstname}</strong><br />
		Επίθετο: <strong>${application.lastname}</strong><br />
		Email: <strong>${application.email}</strong><br />
		Οδός: <strong>${application.street}</strong><br />
		Αριθμός: <strong>${application.streetno}</strong><br />
		Ταχυδρομικός κώδικας: <strong>${application.postalcode}</strong><br />
		Πόλη: <strong>${application.city}</strong><br />
		Χώρα: <strong>${application.country}</strong><br />
		Τηλέφωνο: <strong>${application.phone}</strong><br />
		Έτος Γέννησης: <strong>${application.yearOfBirth}</strong><br />
		Ιστοσελίδα: <strong>${application.website}</strong><br />
		<br />
		Αρχείο βιογραφικού: <strong>${application.bioFilepath}</strong><br />
		Αρχείο υπέυθυνης δήλωσης: <strong>${application.applicationFilepath}</strong><br />
		<br /><br />
Ευχαριστούμε θερμά για την αίτησή σας!

	</p>
</div>
</body>