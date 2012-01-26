<div class="nav">
            <div>
            	<span title="Αποσύνδεση" class="menuButton"><g:link controller="logout"><img src="${request.getContextPath()}/images/logout_icon.png"></g:link></span>
            </div>
            <div style="margin-left: 250px">
            	<g:link action="profile">Αρχική</g:link>&nbsp;&nbsp;&nbsp;
            	<g:link action="edit" params='["id": "${candidateInstance.id }"]'>Αλλαγή Στοιχείων</g:link>&nbsp;&nbsp;&nbsp;
            	<g:link action="changepasswd" params='["id": "${candidateInstance.id }"]'>Αλλαγή Κωδικού</g:link>&nbsp;&nbsp;&nbsp;
            	<g:link action="listforms" params='["id": "${candidateInstance.id }"]'>Αιτήσεις</g:link>&nbsp;&nbsp;&nbsp;
            	<g:link action="listinvitations" params='["id": "${candidateInstance.id }"]'>Νέα Αίτηση</g:link>
            </div>
 </div>
