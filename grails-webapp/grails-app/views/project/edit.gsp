

<%@ page import="gr.ekt.applicanttracker.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <!-- <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div> -->
        <g:render template="/common/menu" model="['type':'3']"/>
        <div class="body">
            <h1><g:message code="Επεξεργασία έργου" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${projectInstance}">
            <div class="errors">
                <g:renderErrors bean="${projectInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="update" method="post" >
                <g:hiddenField name="id" value="${projectInstance?.id}" />
                <g:hiddenField name="version" value="${projectInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="code"><g:message code="project.code.label" default="Κωδικός Έργου" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'code', 'errors')}">
                                    <g:textField name="code" value="${projectInstance?.code}" />
                                </td>
                            </tr>
                        
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title"><strong><g:message code="project.title.label" default="Τίτλος έργου *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${projectInstance?.title}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="duration"><g:message code="project.duration.label" default="Διάρκεια (σε μήνες)" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'duration', 'errors')}">
                                    <g:textField name="duration" value="${projectInstance?.duration}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="noOfJobs"><g:message code="project.noOfJobs.label" default="Αριθμός θέσεων" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'noOfJobs', 'errors')}">
                                    <g:textField name="noOfJobs" value="${projectInstance?.noOfJobs}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="discipline"><strong><g:message code="project.discipline.label" default="Γνωστικός τομέας *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'discipline', 'errors')}">
                                    <g:textField name="discipline" value="${projectInstance?.discipline}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="project.description.label" default="Περιγραφή" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" value="${projectInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="invitation"><g:message code="project.invitation.label" default="Πρόσκληση" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'invitation', 'errors')}">
                                    <g:select style="width:750px" name="invitation.id" from="${gr.ekt.applicanttracker.Invitation.list()}" optionKey="id" optionValue="code" value="${projectInstance?.invitation?.id}"  />
                                </td>
                            </tr>
                        
                                                	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projects"><strong><g:message code="project.skills.label" default="Προσόντα *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'skills', 'errors')}">
                                   		<div id="kostas">
                                   		<g:select style="width:750px" multiple="multiple" optionKey="id" optionValue='title' from="${gr.ekt.applicanttracker.Skill.list()}" name="skills" value="${projectInstance.skills}"></g:select>
                                   		</div>
                                  <script type="text/javascript">
  									$(document).ready(function () {
    								$('select[name*="skills"]').selectList({ 
    									addAnimate: function (item, callback) {
    							        $(item).slideDown(500, callback);
    							      },
    							      removeAnimate: function (item, callback) {
    							        $(item).slideUp(500, callback);
    							      }  
  									});
  									});
								</script>
								</div>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projects"><g:message code="project.wishSkills.label" default="Επιθυμητά Προσόντα" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'wishSkills', 'errors')}">
                                   		<div id="kostas">
                                   		<g:select style="width:750px" multiple="multiple" optionKey="id" optionValue='title' from="${gr.ekt.applicanttracker.Skill.list()}" name="wishSkills" value="${projectInstance.wishSkills}"></g:select>
                                  	</div>
                                  <script type="text/javascript">
  									$(document).ready(function () {
    								$('select[name*="wishSkills"]').selectList({ 
    									addAnimate: function (item, callback) {
    							        $(item).slideDown(500, callback);
    							      },
    							      removeAnimate: function (item, callback) {
    							        $(item).slideUp(500, callback);
    							      }  
  									});
  									});
								</script>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <div style="text-align: center; padding-top: 20p; width:705px"><input style="width:250px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Αποθήκευση Έργου" /></div>
                
                <!-- <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>-->
            </g:form>
        </div>
    </body>
</html>
