
<%@ page import="gr.ekt.applicanttracker.Candidate" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'candidate.label', default: 'Candidate')}" />
        <title>Λίστα αιτήσεων</title>
    </head>
    <body>
    
        <g:render template="/common/profilemenu"
	model="['candidateInstance':candidateInstance]" />
	
        <div class="body">
            <h1>Λίστα αιτήσεων</h1>
            <br/><br/>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
           <g:if test="${applicationFormList.size() == 0 }">
            Δεν υπάρχει αίτηση που να μπορείτε να επεξεργαστείτε!
            </g:if> <g:else>
            
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <th class="sortable" style="color: #333; font-size: 10px"> Κωδικός Αίτησης</th>
                            <th class="sortable" style="color: #333; font-size: 10px"> Πρόσκληση</th>
                            <th class="sortable" style="color: #333; font-size: 10px"> Ημερομηνία Εισαγωγής</th>
                            <th class="sortable" style="color: #333; font-size: 10px"> Ημερομηνία Αλλαγής</th>
                            <th class="sortable" style="color: #333; font-size: 10px"> Ενέργεια </th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${applicationFormList}" status="i" var="appForm">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="appformshow" id="${candidateInstance.id}" params='["appformid":"${ appForm.id}"]' >${appForm.id} </g:link></td>
                        
                        	<td>${appForm.appFormApplications[0]?.project?.invitation?.code}</td>
                        	<td><g:formatDate date="${appForm.dateInitial}" /></td>
                            <td><g:formatDate date="${appForm.dateIssued}" /></td>
                        
                        	<td> 
                        		<g:link title="Προβολή" action="appformshow" id="${candidateInstance.id}" params='["appformid":"${ appForm.id}"]' method="POST"><img src="${request.getContextPath()}/images/show_icon.png"></g:link>
                        		<!-- <g:if test="${appForm.appFormApplications[0]?.project?.invitation?.isInvitationEnabled()}"> -->
   		                      		<g:link title="Επεξεργασία" action="appformedit" id="${candidateInstance.id}" params='["appformid":"${ appForm.id}"]' method="POST"><img src="${request.getContextPath()}/images/edit_icon.png"></g:link> 
  								<!-- </g:if> -->
  								<!-- <g:link title="Διαγραφή" action="appformdelete" id="${candidateInstance.id}" params='["appformid":"${ appForm.id}"]' method="POST"><img src="${request.getContextPath()}/images/delete_icon.png" onclick="return confirm('Είστε σίγουρος/η;')"></g:link> -->
                        	</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            </g:else>
            <br/><br/>
        </div>
        <br/><br/>
    </body>
</html>
