

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'EATUser.label', default: 'EATUser')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'EATUser.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="username" title="${message(code: 'EATUser.username.label', default: 'Username')}" />
                        
                            <g:sortableColumn property="userRealName" title="${message(code: 'EATUser.userRealName.label', default: 'User Real Name')}" />
                        
                            <g:sortableColumn property="passwd" title="${message(code: 'EATUser.passwd.label', default: 'Passwd')}" />
                        
                            <g:sortableColumn property="enabled" title="${message(code: 'EATUser.enabled.label', default: 'Enabled')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'EATUser.description.label', default: 'Description')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${EATUserInstanceList}" status="i" var="EATUserInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${EATUserInstance.id}">${fieldValue(bean: EATUserInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: EATUserInstance, field: "username")}</td>
                        
                            <td>${fieldValue(bean: EATUserInstance, field: "userRealName")}</td>
                        
                            <td>${fieldValue(bean: EATUserInstance, field: "passwd")}</td>
                        
                            <td><g:formatBoolean boolean="${EATUserInstance.enabled}" /></td>
                        
                            <td>${fieldValue(bean: EATUserInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${EATUserInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
