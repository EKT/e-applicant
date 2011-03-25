<div class="nav">
            <span title="Αποσύνδεση" class="menuButton"><g:link controller="logout"><img src="${request.getContextPath()}/images/logout_icon.png"></g:link></span>
            
            <g:if test="${type == '1'}"> 
                <span title="Αιτήσεις" ><g:link controller="application"><img src="${request.getContextPath()}/images/applications_selected_icon.png"></g:link></span>
            	<g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
            		<span title="Προσκλήσεις" ><g:link controller="invitation"><img src="${request.getContextPath()}/images/invitation_icon.png"></g:link></span>
            		<span title="Έργα" ><g:link controller="project"><img src="${request.getContextPath()}/images/project_icon.png"></g:link></span>
            		<span title="Προσόντα" ><g:link controller="skill"><img src="${request.getContextPath()}/images/skill_icon.png"></g:link></span>
            	</g:ifAnyGranted>
            </g:if>
            <g:elseif test="${type == '2'}">
                <span title="Αιτήσεις" ><g:link controller="application"><img src="${request.getContextPath()}/images/applications_icon.png"></g:link></span>
            	<g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
            		<span title="Προσκλήσεις" ><g:link controller="invitation"><img src="${request.getContextPath()}/images/invitation_selected_icon.png"></g:link></span>
            		<span title="Έργα" ><g:link controller="project"><img src="${request.getContextPath()}/images/project_icon.png"></g:link></span>
            		<span title="Προσόντα" ><g:link controller="skill"><img src="${request.getContextPath()}/images/skill_icon.png"></g:link></span>
            	</g:ifAnyGranted>
            </g:elseif>
            <g:elseif test="${type == '3'}">
                <span title="Αιτήσεις" ><g:link controller="application"><img src="${request.getContextPath()}/images/applications_icon.png"></g:link></span>
            	<g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
            		<span title="Προσκλήσεις" ><g:link controller="invitation"><img src="${request.getContextPath()}/images/invitation_icon.png"></g:link></span>
            		<span title="Έργα" ><g:link controller="project"><img src="${request.getContextPath()}/images/project_selected_icon.png"></g:link></span>
            		<span title="Προσόντα" ><g:link controller="skill"><img src="${request.getContextPath()}/images/skill_icon.png"></g:link></span>
            	</g:ifAnyGranted>
            </g:elseif>
            <g:elseif test="${type == '4'}">
                <span title="Αιτήσεις" ><g:link controller="application"><img src="${request.getContextPath()}/images/applications_icon.png"></g:link></span>
            	<g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
            		<span title="Προσκλήσεις" ><g:link controller="invitation"><img src="${request.getContextPath()}/images/invitation_icon.png"></g:link></span>
            		<span title="Έργα" ><g:link controller="project"><img src="${request.getContextPath()}/images/project_icon.png"></g:link></span>
            		<span title="Προσόντα" ><g:link controller="skill"><img src="${request.getContextPath()}/images/skill_selected_icon.png"></g:link></span>
            	</g:ifAnyGranted>
            </g:elseif>
            
            <g:ifAllGranted role="ROLE_SYS_ADMIN">
            	&nbsp&nbsp
 	        	<span title="Ρόλοι"><g:link controller="EATRole"><img src="${request.getContextPath()}/images/roles_icon.png"></g:link></span>
  	        	<span title="Χρήστες"><g:link controller="EATUser"><img src="${request.getContextPath()}/images/users_icon.png"></g:link></span>
 			</g:ifAllGranted>
 			
 			&nbsp&nbsp
 			
 			<span style="position: relative; top: -9px">Συνδεδεμένος χρήστης: <b><g:loggedInUserInfo field="username"/></b> (<g:loggedInUserInfo field="userRealName"/>)</span>
</div>

<p><%= test %></p>