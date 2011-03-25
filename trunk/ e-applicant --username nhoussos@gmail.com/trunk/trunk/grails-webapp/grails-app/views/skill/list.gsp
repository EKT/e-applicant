
<%@ page import="gr.ekt.applicanttracker.Skill" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'skill.label', default: 'Skill')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:render template="/common/menu" model="['type':'4']"/>
        
        <div class="body">
            <h1><g:message code="Λίστα προσόντων (Σύνολο: ${skillInstanceTotal})" args="[entityName]" /></h1>
            <br/><br/>
            
            <g:link title="Δημιουργία πρόσόντος" action="create"><img src="${request.getContextPath()}/images/create_icon.png"></g:link>
            
             <br/><br/>
             
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'skill.id.label', default: 'ID')}" />
                        
                            <g:sortableColumn property="title" title="${message(code: 'skill.title.label', default: 'Τίτλος')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'skill.description.label', default: 'Περιγραφή')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${skillInstanceList}" status="i" var="skillInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${skillInstance.id}">${fieldValue(bean: skillInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: skillInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: skillInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${skillInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
