

<%@ page import="gr.ekt.applicanttracker.Application" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <!-- <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div> -->
        
        <g:render template="/common/menu" model="['type':'1']"/>
        
        <div class="body">
            <h1><g:message code="Επεξεργασία Αίτησης" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${applicationInstance}">
            <div class="errors">
                <g:renderErrors bean="${applicationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="update" method="post" enctype="multipart/form-data" >
                <g:hiddenField name="id" value="${applicationInstance?.id}" />
                <g:hiddenField name="version" value="${applicationInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstname"><strong><g:message code="application.firstname.label" default="Όνομα *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'firstname', 'errors')}">
                                    <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                    	<g:textField name="firstname" value="${applicationInstance?.firstname}" />
                                    </g:ifAnyGranted>
                                    <g:ifAnyGranted role="ROLE_REVIEWER">
                                    	${applicationInstance?.firstname}
                                    </g:ifAnyGranted>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastname"><strong><g:message code="application.lastname.label" default="Επώνυμο *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'lastname', 'errors')}">
                                	<g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                    	<g:textField name="lastname" value="${applicationInstance?.lastname}" />
                                    </g:ifAnyGranted>
                                    <g:ifAnyGranted role="ROLE_REVIEWER">
                                    	${applicationInstance?.lastname}
                                    </g:ifAnyGranted>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><strong><g:message code="application.email.label" default="Email *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'email', 'errors')}">
                                    <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                    	<g:textField name="email" value="${applicationInstance?.email}" />
                                    </g:ifAnyGranted>
                                    <g:ifAnyGranted role="ROLE_REVIEWER">
                                    	${applicationInstance?.email}
                                    </g:ifAnyGranted>
                                </td>
                            </tr>
                        
                        
                        <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="emailVerification"><strong><g:message code="application.email.label" default="Επιβεβαίωση Email *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'emailVerification', 'errors')}">
                                    <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                    	<g:textField name="emailVerification" value="${applicationInstance?.emailVerification}" />
                                	</g:ifAnyGranted>
                                	<g:ifAnyGranted role="ROLE_REVIEWER">
                                    	${applicationInstance?.emailVerification}
                                    </g:ifAnyGranted>
                                </td>
                            </tr>
                          
                            
                        <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="street"><strong><g:message code="application.street.label" default="Οδός *" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'street', 'errors')}">
                                    <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                    	<g:textField name="street" value="${applicationInstance?.street}" />
                                    </g:ifAnyGranted>
                                    <g:ifAnyGranted role="ROLE_REVIEWER">
                                    	${applicationInstance?.street}
                                    </g:ifAnyGranted>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="streetno"><strong><g:message code="application.streetno.label" default="Αριθμός *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'streetno', 'errors')}">
                                	<g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                	   	<g:textField name="streetno" value="${fieldValue(bean: applicationInstance, field: 'streetno')}" />
                                	</g:ifAnyGranted>
                                	<g:ifAnyGranted role="ROLE_REVIEWER">
                                    	${applicationInstance?.streetno}
                                    </g:ifAnyGranted>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="postalcode"><strong><g:message code="application.postalcode.label" default="Ταχυδρομικός Κώδικας *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'postalcode', 'errors')}">
                                    <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                    	<g:textField name="postalcode" value="${applicationInstance?.postalcode}" />
                                    	<img src="${request.getContextPath()}/images/help_icon.png" title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Ταχυδρομικός Κώδικας] body=[Π.χ. 11635]" style="vertical-align:middle;font-family:arial;font-size:20px;font-weight:bold;color:#ABABAB;cursor:pointer"/>
 									</g:ifAnyGranted>
 									<g:ifAnyGranted role="ROLE_REVIEWER">
                                    	${applicationInstance?.postalcode}
                                    </g:ifAnyGranted>
                                </td>
                           </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city"><strong><g:message code="application.city.label" default="Πόλη *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'city', 'errors')}">
                                    <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                    	<g:textField name="city" value="${applicationInstance?.city}" />
                                    </g:ifAnyGranted>
                                    <g:ifAnyGranted role="ROLE_REVIEWER">
                                    	${applicationInstance?.city}
                                    </g:ifAnyGranted>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="country"><strong><g:message code="application.country.label" default="Χώρα *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'country', 'errors')}">
                                    <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                    	<g:textField name="country" value="${applicationInstance?.country}" />
                                    </g:ifAnyGranted>
                                    <g:ifAnyGranted role="ROLE_REVIEWER">
                                    	${applicationInstance?.country}
                                    </g:ifAnyGranted>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="phone"><strong><g:message code="application.phone.label" default="Τηλέφωνο *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'phone', 'errors')}">
                                    <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                    	<g:textField name="phone" value="${applicationInstance?.phone}" />
										<img src="${request.getContextPath()}/images/help_icon.png" title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Τηλέφωνο] body=[Π.χ. 2107273900 ή +302107273900]" style="vertical-align:middle;font-family:arial;font-size:20px;font-weight:bold;color:#ABABAB;cursor:pointer"/>
                               		</g:ifAnyGranted>
                               		<g:ifAnyGranted role="ROLE_REVIEWER">
                                    	${applicationInstance?.phone}
                                    </g:ifAnyGranted>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="yearOfBirth"><g:message code="application.yearOfBirth.label" default="Έτος Γέννησης" /></label>
                                </td>
                                 <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'yearOfBirth', 'errors')}">
                                	<g:if test="${applicationInstance.yearOfBirth == 0}">
                                		<g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                			<g:textField name="yearOfBirth" value=""/>
                                		</g:ifAnyGranted>
                                	</g:if>
                                	<g:else>
                                	    <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                	    	<g:textField class="yearOfBirth" name="yearOfBirth" value="${fieldValue(bean: applicationInstance, field: 'yearOfBirth')}" />
                                		</g:ifAnyGranted>
                                		<g:ifAnyGranted role="ROLE_REVIEWER">
                                    		${applicationInstance?.yearOfBirth}
                                    	</g:ifAnyGranted>
                                	</g:else>
                                </td>
                            </tr>
                            
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="website"><g:message code="application.website.label" default="Ιστοσελίδες" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'website', 'errors')}">
                                    <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                    	<g:textField name="website" value="${fieldValue(bean: applicationInstance, field: 'website')}" />
 	                                 	<img src="${request.getContextPath()}/images/help_icon.png" title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Ιστοσελίδες] body=[Διεύθυνση προσωπικής ιστοσελίδας, σελίδων blog, twitter ή και professional networking tools (π.χ. LinkedIn, Spoke, Viadeo). Μπορείτε να προσδιορίσετε περισσότερες από μία ιστοσελίδες με κόμματα ανάμεσά τους.]" style="vertical-align:middle;font-family:arial;font-size:20px;font-weight:bold;color:#ABABAB;cursor:pointer"/>
  									</g:ifAnyGranted>
  									<g:ifAnyGranted role="ROLE_REVIEWER">
                                    		${applicationInstance?.website}
                                    	</g:ifAnyGranted>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projects"><strong><g:message code="application.projects.label" default="Κωδικός έργου *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'projects', 'errors')}">
                                    <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                		<g:select multiple="multiple" optionKey="id" optionValue='code' from="${applicationInstance.invitation?.projects}" name="projects" value="${applicationInstance.projects}"></g:select>
                              		</g:ifAnyGranted>
                              		<g:ifAnyGranted role="ROLE_REVIEWER">
                              			<ul>
                              			<g:each in="${applicationInstance.projects}">
     										<li>${it.code}</li>
										</g:each>
										</ul>
									</g:ifAnyGranted>
                                </td>
                                
                                <script type="text/javascript">
  									$(document).ready(function () {
    								$('select[name*="projects"]').selectList({ 
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
                                    <label for="projects"><strong><g:message code="application.bioFilepath.label" default="Βιογραφικό Σημείωμα *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'bioFilepath', 'errors')}">
                                   <!--  <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                   		<input type="file" name="bioFile" value="Δεν έχει επιλεγεί αρχείο" />
                                  		<img src="${request.getContextPath()}/images/help_icon.png" title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Βιογραφικό Σημείωμα] body=[Αναλυτικό Βιογραφικό Σημείωμα, κατά προτίμηση σύμφωνα με το πρότυπο βιογραφικό σημείωμα Europass σε μορφή αρχείου Open Document Text (.odt) ή .doc/.docx (μέγιστο μέγεθος αρχείου: 10ΜΒ). Για την παραγωγή των παραπάνω μορφών αρχείων μπορούν να χρησιμοποιηθούν προγράμματα επεξεργασίας κειμένου όπως Libre Office Writer, Open Office Writer, Microsoft Word. Πληροφορίες για τη δημιουργία βιογραφικού σημειώματος Europass παρέχονται στο διαδικτυακό τόπο http://europass.cedefop.europa.eu]" style="vertical-align:middle;font-family:arial;font-size:20px;font-weight:bold; color:#ABABAB;cursor:pointer"/>
                                   </g:ifAnyGranted>
                                   <g:ifAnyGranted role="ROLE_REVIEWER">
                                    		${applicationInstance?.bioFilepath}
                                    	</g:ifAnyGranted>-->
                                    	
                                    	<g:link controller="application" action="downloadbio" id="${applicationInstance.id}">${applicationInstance.bioFilepath}</g:link>
                                    	
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projects"><strong><g:message code="application.applicationFilepath.label" default="Υπεύθυνη Δήλωση *" /></strong></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'applicationFilepath', 'errors')}">
                                   <!-- <g:ifAnyGranted role="ROLE_SYS_ADMIN,ROLE_ADMIN">
                                   		<input type="file" name="appFile" />
										<img src="${request.getContextPath()}/images/help_icon.png" title="cssbody=[dvbdy1] cssheader=[dvhdr1] header=[Υπεύθυνη Δήλωση] body=[Το σαρωμένο (scanned) αρχείο της υπογεγραμμένης Υπεύθυνης Δήλωσης του Ν.1599/1986, κατά προτίμηση σε μορφή JPEG ή PDF]" style="vertical-align:middle;font-family:arial;font-size:20px;font-weight:bold;color:#ABABAB;cursor:pointer"/>
                                	</g:ifAnyGranted>
                                	<g:ifAnyGranted role="ROLE_REVIEWER">
                                    		${applicationInstance?.applicationFilepath}
                                    	</g:ifAnyGranted>
                                    	 -->
                                    	<g:link controller="application" action="downloadapp" id="${applicationInstance.id}">${applicationInstance.applicationFilepath}</g:link>
                                </td>
                            </tr>
                            
                       		<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="projects"><g:message code="application.applicationFilepath.label" default="Έντυπη υποβολή αίτησης" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'throughPost', 'errors')}">
                                    <g:checkBox name="throughPost" value="${applicationInstance?.throughPost}" style="width:20px"/>
                                </td>
                            </tr>
                        	
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bioFileCheckStatus"><g:message code="application.bioFileCheckStatus.label" default="Κατάσταση Βιογραφικού" /></label>
                                </td>
                                <td>
                                	<g:select name="bioFileCheckStatus" from="${gr.ekt.applicanttracker.FileCheckStatus?.values()}" optionKey="key" optionValue="value" value="${applicationInstance.bioFileCheckStatus?.getKey() }" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="appFormFileCheckStatus"><g:message code="application.appFormFileCheckStatus.label" default="Κατάσταση Υπ. Δήλωσης" /></label>
                                </td>
                                <td>
                                	<g:select name="appFormFileCheckStatus" from="${gr.ekt.applicanttracker.FileCheckStatus?.values()}" optionKey="key" value="${applicationInstance.appFormFileCheckStatus?.getKey() }"/>
                                </td>
                            </tr>
                        
                        
                         	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fileStatusNotes"><g:message code="application.fileStatusNotes.label" default="Σημειώσεις κατάστασης αρχείων" /></label>
                                </td>
                                <td>
                               	 	<g:textArea name="fileStatusNotes" value="${applicationInstance.fileStatusNotes }" rows="5" cols="60"/>
                                </td>
                            </tr>
                            
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="appSkills"><g:message code="application.appSkills.label" default="Προσόντα" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'appSkills', 'errors')}">
                                   		<div id="kostas">
                                   		<g:select multiple="multiple" optionKey="id" optionValue='title' from="${applicationInstance.getValidSkills()}" name="appSkills" value="${applicationInstance.appSkills}"></g:select>
                                   		</div>
                                 <script type="text/javascript">
  									$(document).ready(function () {
    								$('select[name*="appSkills"]').selectList({ 
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
                                    <label for="skillNotes"><g:message code="application.skillNotes.label" default="Σημειώσεις προσόντων" /></label>
                                </td>
                                <td>
                               	 	<g:textArea name="skillNotes" value="${applicationInstance.skillNotes }" rows="5" cols="60"/>
                                </td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                
                <div style="text-align: center; padding-top: 20p; width:705px"><input style="width:220px; height:45px; font-weight: bold; border-right: 2px ridge; border-bottom: 2px ridge; font-size: 18px" type="submit" value="Αποθήκευση Αίτησης" /></div>
   
                <!-- <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div> -->
            </g:form>
        </div>
    </body>
</html>
