
<%@ page import="gr.ekt.applicanttracker.Application" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    	<!-- 
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        -->
        <div class="body">
        <h1>Η αίτησή σας αποθηκεύτηκε. Σας έχει αποσταλεί email επιβεβαίωσης</h1>
            <!-- <h1><g:message code="default.show.label" args="[entityName]" /></h1> -->
           <!--  <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if> -->
            <div class="dialog">
                <table>
                    <tbody>
                    
                    	<tr class="prop">
                            <td valign="top" class="name"><g:message code="application.invitation.label" default="Πρόσκληση" /></td>
                            
                            <td valign="top" class="value">${applicationInstance.invitation?.code}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.id.label" default="Kωδικός αίτησης" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.firstname.label" default="Όνομα" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "firstname")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.lastname.label" default="Επίθετο" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "lastname")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "email")}</td>
                            
                        </tr>
                    
                   	 	<tr class="prop">
                            <td valign="top" class="name"><g:message code="application.street.label" default="Οδός" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "street")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.streetno.label" default="Αριθμός" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "streetno")}</td>
                            
                        </tr>
                        
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.postalcode.label" default="Ταχυδρομικός Κώδικας" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "postalcode")}</td>
                            
                        </tr>
                        
                         <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.city.label" default="Πόλη" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "city")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.country.label" default="Χώρα" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "country")}</td>
                            
                        </tr>
  
                          <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.phone.label" default="Τηλέφωνο" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "phone")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.yearOfBirth.label" default="Έτος Γέννησης" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "yearOfBirth")}</td>
                            
                        </tr>
                             
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.website.label" default="Website" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "website")}</td>
                            
                        </tr>
                                         
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="application.projects.label" default="Κωδικοί έργων" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${applicationInstance.projects}" var="p">
                                    <li>${p.code}<!--  <g:link controller="project" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link>--></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    </tbody>
                </table>
            </div>
            <!--<div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${applicationInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>-->
        </div>
    </body>
</html>
