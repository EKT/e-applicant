
<%@ page import="gr.ekt.applicanttracker.Application" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        
       <g:render template="/common/menu" model="['type':'1']"/>
        
        <div class="body">
            <h1><g:message code="Λίστα αιτήσεων (Σύνολο: ${applicationInstanceTotal})" args="[entityName]" /></h1>
            <br/><br/>
            <g:if test="${flash.message}">  
            <div class="message">${flash.message}</div>
            </g:if>
            
            <div>
            	<g:form action="list" method="post"> 
            		<g:select noSelection="['all':'-Όλες οι εγγραφές-']" optionKey="code" optionValue='code' from="${gr.ekt.applicanttracker.Project.list()}" name="selectedProject" value="${ request.getParameter('selectedProject') }"></g:select>
            		<g:submitButton name="Ανανέωση αποτελεσμάτων" style="width:200px"/>
            	</g:form>
            	<br/><br/>
            </div>
            <br/><br/>
            <div class="paginateButtons">
                <g:paginate total="${applicationInstanceTotal}" max="50" next="Επόμενη" prev="Προηγούμενη" params="['selectedProject': params?.selectedProject]"/> 
                <div style="padding-top: 20px"></div>
                <g:form action="list" method="get"> 
                	Εγγραφές ανά σελίδα&nbsp
               		<input type="text" name="max" value="<%= params.get("max") %>" style="width:40px"/>
               		<g:hiddenField name="selectedProject" value="${params?.selectedProject }" ></g:hiddenField>
               		<input type="submit" value="ΟΚ" style="width:30px"></input> 
               	</g:form> 
            </div>
            <br/><br/>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'application.id.label', default: 'Κωδικός')}" />
                        
                            <g:sortableColumn property="firstname" title="${message(code: 'application.firstname.label', default: 'Όνομα')}" />
                        
                            <g:sortableColumn property="lastname" title="${message(code: 'application.lastname.label', default: 'Επώνυμο')}" />
                        
                            <!-- <g:sortableColumn property="email" title="${message(code: 'application.email.label', default: 'Email')}" />-->
                        
                        	<g:sortableColumn property="yearOfBirth" title="${message(code: 'application.city.label', default: 'Ημ. Γέννησης')}" />
                        
                            <g:sortableColumn property="city" title="${message(code: 'application.city.label', default: 'Πόλη')}" />
                        
                            <!-- <g:sortableColumn property="country" title="${message(code: 'application.country.label', default: 'Χώρα')}" /> -->
                        
                        	<g:sortableColumn property="dateIssued" title="${message(code: 'application.country.label', default: 'Ημ. Εγγραφής')}" />
                        
                        	<!-- <g:sortableColumn property="invitation" title="${message(code: 'application.country.label', default: 'Πρόσκληση')}" /> -->
                        	
                        	<th class="sortable" style="color: #333; font-size: 10px"> Τομέας </th>
                        	
                        	<th class="sortable" style="color: #333; font-size: 10px"> Ενέργεια </th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${applicationInstanceList}" status="i" var="applicationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link title="Προβολή" action="show" id="${applicationInstance.id}" method="POST">${fieldValue(bean: applicationInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: applicationInstance, field: "firstname")}</td>
                        
                            <td><g:link title="Προβολή" action="show" id="${applicationInstance.id}" method="POST">${fieldValue(bean: applicationInstance, field: "lastname")}</g:link></td>
                        
                            <!-- <td>${fieldValue(bean: applicationInstance, field: "email")}</td> -->
                            
                            <td><div style="text-align: center;">${fieldValue(bean: applicationInstance, field: "yearOfBirth")}</div></td>
                        
                            <td>${fieldValue(bean: applicationInstance, field: "city")}</td>
                        
                            <!-- <td>${fieldValue(bean: applicationInstance, field: "country")}</td> -->
                        
                        	<td>${fieldValue(bean: applicationInstance, field: "dateIssued")}</td>
                        
                        	<!-- <td>
                        		<g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                        			<g:link title="Δείτε την πρόσκληση" action="show" controller="invitation" id="${applicationInstance.invitation?.id}">${fieldValue(bean: applicationInstance, field: "invitation.code")}</g:link>
                        		</g:ifAnyGranted>
                        		<g:ifAnyGranted role="ROLE_REVIEWER">
                        			${fieldValue(bean: applicationInstance, field: "invitation.code")}
                        		</g:ifAnyGranted>
                        	</td> -->
                        
                        	<td>${applicationInstance.projects?.get(0)?.discipline} (${applicationInstance.projects.size()})</td>
                        
                        	<td> 
                        		<g:link title="Προβολή" action="show" id="${applicationInstance.id}" method="POST"><img src="images/show_icon.png"></g:link>
                        		<g:link title="Επεξεργασία" action="edit" id="${applicationInstance.id}" method="POST"><img src="images/edit_icon.png"></g:link>
                        		
                        		<g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                        			<g:link title="Διαγραφή" action="delete" id="${applicationInstance.id}" method="POST"><img src="images/delete_icon.png" onclick="return confirm('Είστε σίγουρος/η;')"></g:link>
                        		</g:ifAnyGranted>
                        		
                        		&nbsp&nbsp&nbsp&nbsp&nbsp
                        		<g:link title="Βιογραφικό Σημείωμα" action="downloadbio" id="${applicationInstance.id}" method="POST"><img src="images/bio_icon.png"></g:link>
                        		<g:link title="Υπέυθυνη Δήλωση" action="downloadapp" id="${applicationInstance.id}" method="POST"><img src="images/application_icon.png"></g:link>
                        	</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${applicationInstanceTotal}" max="50" next="Επόμενη" prev="Προηγούμενη" params="['selectedProject': params?.selectedProject]"/> 
                <div style="padding-top: 20px"></div>
                <g:form action="list" method="get"> 
                	Εγγραφές ανά σελίδα&nbsp
               		<input type="text" name="max" value="<%= params.get("max") %>" style="width:40px"/>
               		<g:hiddenField name="selectedProject" value="${params?.selectedProject }" ></g:hiddenField>
               		<input type="submit" value="ΟΚ" style="width:30px"></input> 
               	</g:form> 
            </div>
            <br/><br/>
            <g:link title="Εξαγωγή σε excel" action="excel" method="POST" params="['selectedProject': params?.selectedProject]"><div style="vertical-align: center"><span style="height:100%; position:relative; top:-10px">Εξαγωγή της λίστας σε excel</span>&nbsp&nbsp<img src="images/xls_icon.png"/></div></g:link>
            <br/><br/>
        </div>
    </body>
</html>
