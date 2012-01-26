                                                                                                                                                    
                                                                                                                                                    
<%@ page import="gr.ekt.applicanttracker.Candidate" %>                                                                                              
<html>                                                                                                                                              
    <head>                                                                                                                                          
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />                                                                       
        <meta name="layout" content="main" />                                                                                                       
        <g:set var="entityName" value="${message(code: 'candidate.label', default: 'Candidate')}" />                                                
        <title><g:message code="default.edit.label" args="[entityName]" /></title>                                                                  
    </head>                                                                                                                                         
    <body>                                                                                                                                          
        <g:render template="/common/profilemenu"                                                                                                    
			model="['candidateInstance':candidateInstance]" />                                                                                      
	                                                                                                                                                
        <div class="body">                                                                                                                          
            <h1><g:message code="Αλλαγή κωδικού" args="[entityName]" /></h1>                                                                 
            <g:if test="${flash.message}">                                                                                                          
            <div class="message">${flash.message}</div>                                                                                             
            </g:if>                                                                                                                                 
            <g:hasErrors bean="${changePasswordInfo}">                                                                                               
            <div class="errors">                                                                                                                    
                <g:renderErrors bean="${changePasswordInfo}" as="list" />                                                                            
            </div>                                                                                                                                  
            </g:hasErrors>                                                                                                                          
            <g:form action="updatepasswd" method="post"  >                                                                                                
                <g:hiddenField name="id" value="${candidateInstance?.id}" />                                                                        
                <div class="dialog">                                                                                                                
                    <table>                                                                                                                         
                        <tbody>                                                                                                                     
                                                                                                                                                    
                           <tr class="prop">                                                                                                        
                                <td valign="top" class="name">                                                                                      
                                    <label for="firstname"><strong><g:message code="candidate.firstname.label" default="Παλιός Κωδικός" /></strong></label>
                                </td>                                                                                                               
                                <td valign="top" class="value ${hasErrors(bean: changePasswordInfo, field: 'oldpasswd', 'errors')}">
                                    <input type="password" name="oldPasswd" value="" />                                        
                                </td>                                                                                                               
                            </tr>                                                                                                                   
                                    
                            <tr class="prop">                                                                                                        
                                <td valign="top" class="name">                                                                                      
                                    <label for="firstname"><strong><g:message code="candidate.firstname.label" default="Νέος Κωδικός" /></strong></label>
                                </td>                                                                                                               
                                <td valign="top" class="value">                 
                                    <input type="password" name="newPasswd" value="" />                                        
                                </td>                                                                                                               
                            </tr> 
                                
                            <tr class="prop">                                                                                                        
                                <td valign="top" class="name">                                                                                      
                                    <label for="firstname"><strong><g:message code="candidate.firstname.label" default="Επιβεβαίωση νέου κωδικού" /></strong></label>
                                </td>                                                                                                               
                                <td valign="top" class="value">                 
                                    <input type="password" name="newPasswdVerification" value="" />                                        
                                </td>                                                                                                               
                            </tr> 
                                                                                                                                        
                         </tbody>                                                                                                                    
                    </table>                                                                                                                        
                </div>                                                                                                                              
                                                                                                                                                    
                               <div style="text-align: center; padding-top: 20p; width:705px"><input style="width:250px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Αλλαγή Κωδικού" /></div>                                                                                                                                     
			</g:form>
        </div>
    </body>
</html>                                                                                                                                           
                                                                                                                                                    e.label', default: 'Candidate'), params.id])}"essage(code: 'candidate.label', default: 'Candidate')] as Object[], "Another user has updated this Candidate while you were editing")bel', default: 'Candidate'), params.id])}"label', default: 'Candidate'), params.id])}"ate.label', default: 'Candidate'), params.id])}"bel', default: 'Candidate'), params.id])}"le.separator + "email_notification.gtpl").getFile();",