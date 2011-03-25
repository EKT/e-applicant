

<%@ page import="gr.ekt.applicanttracker.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <!-- <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div> -->
        <g:render template="/common/menu" model="['type':'3']"/>
        
        <div class="body">
            <h1><g:message code="Δημιουργία έργου" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${projectInstance}">
            <div class="errors">
                <g:renderErrors bean="${projectInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="code"><strong><g:message code="project.code.label" default="Κωδικός Έργου *" /></strong></label>
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
                                    <label for="discipline"><strong><g:message code="project.discipline.label" default="Περιοχή Γνώσης *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'discipline', 'errors')}">
                                    <g:textField name="discipline" value="${projectInstance?.discipline}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="project.description.label" default="Περιγραφή" /></label>
                                </td>
                                <td>
                                    <g:textArea name="description" value="${projectInstance?.description}" />
                                </td>
                            </tr>
                        
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="invitation"><strong><g:message code="project.invitation.label" default="Πρόσκληση *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'invitation', 'errors')}">
                                    <g:select name="invitation.id" from="${gr.ekt.applicanttracker.Invitation.list()}" optionKey="id" optionValue="code" value="${projectInstance?.invitation?.id}"  />
                                </td>
                            </tr>
                        
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projects"><strong><g:message code="project.skills.label" default="Προσόντα *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'skills', 'errors')}">
                                   		<div id="kostas">
                                   		<g:select style="width:750px" multiple="multiple" optionKey="id" optionValue='title' from="${gr.ekt.applicanttracker.Skill.list()}" name="skills"></g:select>
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
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projects"><g:message code="project.wishSkills.label" default="Επιθυμητά Προσόντα" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'wishSkills', 'errors')}">
                                  <div id="kostas">
                                   		<g:select style="width:750px" multiple="multiple" optionKey="id" optionValue='title' from="${gr.ekt.applicanttracker.Skill.list()}" name="wishSkills"></g:select>
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
                
                <div style="text-align: left; padding-top: 20px"><input style="width:250px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Δημιουργία Έργου" /></div>
 
                <!-- <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>-->
            </g:form>
        </div>
    </body>
</html>
