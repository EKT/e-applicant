


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'EATUser.label', default: 'EATUser')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${EATUserInstance}">
            <div class="errors">
                <g:renderErrors bean="${EATUserInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="username"><g:message code="EATUser.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: EATUserInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" value="${EATUserInstance?.username}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="userRealName"><g:message code="EATUser.userRealName.label" default="User Real Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: EATUserInstance, field: 'userRealName', 'errors')}">
                                    <g:textField name="userRealName" value="${EATUserInstance?.userRealName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="passwd"><g:message code="EATUser.passwd.label" default="Passwd" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: EATUserInstance, field: 'passwd', 'errors')}">
                                    <g:textField name="passwd" value="${EATUserInstance?.passwd}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="enabled"><g:message code="EATUser.enabled.label" default="Enabled" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: EATUserInstance, field: 'enabled', 'errors')}">
                                    <g:checkBox name="enabled" value="${EATUserInstance?.enabled}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="EATUser.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: EATUserInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${EATUserInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="EATUser.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: EATUserInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${EATUserInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="emailShow"><g:message code="EATUser.emailShow.label" default="Email Show" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: EATUserInstance, field: 'emailShow', 'errors')}">
                                    <g:checkBox name="emailShow" value="${EATUserInstance?.emailShow}" />
                                </td>
                            </tr>
                            
                            
                        
                        </tbody>
                    </table>
                    
                    <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="authorities">Roles:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:EATUserInstance,field:'roles','errors')}">
                                    <g:select name="authorities"
										from="${EATRole.list()}"
											multiple="yes" optionKey="id"
									 />

                                </td>
                            </tr> 
                    
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
