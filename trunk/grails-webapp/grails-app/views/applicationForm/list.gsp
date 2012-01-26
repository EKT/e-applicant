
<%@ page import="gr.ekt.applicanttracker.ApplicationForm" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'applicationForm.label', default: 'ApplicationForm')}" />
        <title><g:message code="Λίστα Αιτήσεων" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/common/menu" model="['type':'1']"/>
        <br/><br/>
        <div class="body">
            <h1><g:message code="Λίστα Αιτήσεων - (Σύνολο: ${applicationFormInstanceTotal})" args="[entityName]" /></h1>
            
            <br/><br/>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
             <div id="selProjHidden" style="display:none">${selectedProject }</div>
             <div>
             	<g:set var="selProj" value="${selectedProject }" />
            	<g:form action="list" method="post">
            		<g:select
        				optionKey="id" 
        				optionValue="code" 
						id="invitation-select"
        				from="${gr.ekt.applicanttracker.Invitation.list()}" 
        				name="selectedInvitation" 
        				value="${selectedInvitation }"
        				noSelection="['all':'-- Όλες οι προσκλήσεις --']"
        				onchange="${remoteFunction(
							controller:'invitation', 
            				action:'ajaxGetProjects', 
							params:'\'id=\'+document.getElementById(\'invitation-select\').value',
            				onComplete:'updateProjectSelection(e)')}"
    				></g:select>
    				<g:select name="selectedProject" id="project-select"></g:select>
            		 <g:submitButton name="Ανανέωση αποτελεσμάτων" style="width:200px"/>
            	</g:form>
            	<br/><br/>
            </div>
            
            <g:javascript>
	function updateProjectSelection(e) {
		// The response comes back as a bunch-o-JSON
		var cities = eval("(" + e.responseText + ")")	// evaluate JSON

		var message = document.getElementById('selProjHidden').innerHTML;
		//alert(message)
		
		if (cities) {
			var rselect = document.getElementById('project-select')

			// Clear all previous options
			var l = rselect.length

			while (l > 0) {
				l--
				rselect.remove(l)
			}

			// Rebuild the select
				var opt = document.createElement('option');
				opt.text = '-- Όλα τα έργα --'
				opt.value = 'all'
			  	try {
			    	rselect.add(opt, null) // standards compliant; doesn't work in IE
			  	}
		  		catch(ex) {
		    		rselect.add(opt) // IE only
		  		}
		  		
			for (var i=0; i < cities.length; i++) {
				var city = cities[i]
				var opt = document.createElement('option');
				opt.text = city.code
				opt.value = city.code
			  	try {
			    	rselect.add(opt, null) // standards compliant; doesn't work in IE
			  	}
		  		catch(ex) {
		    		rselect.add(opt) // IE only
		  		}
		  		
		  		if (opt.text == message){
		  			//alert('found');
		  			opt.selected = "1";
		  		}
		  		
			}
		}
	}

	
	// This is called when the page loads to initialize city
	var zselect = document.getElementById('invitation-select')
	var zopt = zselect.options[zselect.selectedIndex]
	

	${remoteFunction(controller:"invitation", action:"ajaxGetProjects", params:"'id=' + zopt.value", onComplete:"updateProjectSelection(e)")}

</g:javascript>

            <br/><br/>
            <g:if test="${applicationFormInstanceTotal>100}">
            <div class="paginateButtons">
                <g:paginate total="${applicationFormInstanceTotal}" params="['selectedProject': params?.selectedProject, 'selectedInvitation': params?.selectedInvitation]" next="Επόμενη" prev="Προηγούμενη"/>
            </div>
            <br/><br/>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'applicationForm.id.label', default: 'Κωδικός Αίτησης')}" params="['selectedProject': params?.selectedProject, 'selectedInvitation': params?.selectedInvitation]"/>
                        
                        	<th class="sortable" style="color: #333; font-size: 10px">Επώνυμο</th>
                        	<g:sortableColumn property="firstname" title="${message(code: 'applicationForm.dateIssued.label', default: 'Όνομα')}" />
                        	<th class="sortable" style="color: #333; font-size: 10px">Πρόσκληση</th>
                        	<g:sortableColumn property="dateInitial" title="${message(code: 'applicationForm.dateInitial.label', default: 'Ημ. Εισαγωγής')}" />
                        	<g:sortableColumn property="dateIssued" title="${message(code: 'applicationForm.dateIssued.label', default: 'Ημ. Τελευταίας Αλλαγής')}" />
                        	<g:sortableColumn property="yearOfBirth" title="${message(code: 'applicationForm.dateIssued.label', default: 'Ημ. Γέννησης')}" />
                        	
                            <g:sortableColumn property="phone" title="${message(code: 'applicationForm.dateIssued.label', default: 'Τηλέφωνο')}" />
                        
                        	<th class="sortable" style="color: #333; font-size: 10px"> Ενέργεια </th>
                        	
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${applicationFormInstanceList}" status="i" var="applicationFormInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${applicationFormInstance.id}">${fieldValue(bean: applicationFormInstance, field: "id")}</g:link></td>
                        
                        	<td><g:link action="show" id="${applicationFormInstance.id}">${applicationFormInstance.appFormCandidate.lastname}</g:link></td>
                        	<td>${applicationFormInstance.appFormCandidate.firstname}</td>
                        	<td>${applicationFormInstance?.appFormApplications[0]?.project?.invitation?.code}</td>
                        	<td><g:formatDate date="${applicationFormInstance.dateInitial}" /></td>
                            <td><g:formatDate date="${applicationFormInstance.dateIssued}" /></td>
                        
                        	<td>${applicationFormInstance.appFormCandidate.yearOfBirth}</td>
                        
                            <td>${applicationFormInstance.appFormCandidate.phone}</td>
                        
                        	<td> 
                        		<g:set var="appformid" value="${applicationFormInstance.id}" />
                        		<g:link title="Βιογραφικό Σημείωμα" controller="candidate" action="downloadbio" id="${applicationFormInstance.appFormCandidate.id}" params="[appformid:appformid]" method="POST"><img src="${request.getContextPath()}/images/bio_icon.png"></g:link>
                        		<g:link title="Υπέυθυνη Δήλωση" controller="candidate" action="downloadapp" id="${applicationFormInstance.appFormCandidate.id}" params="[appformid:appformid]" method="POST"><img src="${request.getContextPath()}/images/application_icon.png"></g:link>
                        	</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <g:if test="${applicationFormInstanceTotal>100}">
            <div class="paginateButtons">
                <g:paginate total="${applicationFormInstanceTotal}" params="['selectedProject': params?.selectedProject, 'selectedInvitation': params?.selectedInvitation]" next="Επόμενη" prev="Προηγούμενη"/>
            </div>
            <br/><br/>
            </g:if>
            <br/>
            <g:link title="Εξαγωγή σε excel" action="excel" method="POST" params="['selectedProject': params?.selectedProject, 'selectedInvitation': params?.selectedInvitation]"><div style="vertical-align: center"><span style="height:100%; position:relative; top:-10px">Εξαγωγή της λίστας σε excel</span>&nbsp&nbsp<img src="${request.getContextPath()}/images/xls_icon.png"/></div></g:link>
            <br/><br/>
        </div>
    </body>
</html>
