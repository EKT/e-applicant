*/
* Copyright 2011 Hellenic National Documentation Centre (EKT) www.ekt.gr
*
* Contributors:
* Kostas Stamatis, Nikos Houssos
*
* Licensed under the EUPL, Version 1.1 or – as soon they will be approved by the European Commission 
* - subsequent  versions of the EUPL (the "Licence"); 
* You may not use this work except in compliance with the Licence. 
* You may obtain a copy of the Licence at: 
*
* http://ec.europa.eu/idabc/eupl
*
* Unless required by applicable law or agreed to in writing, software distributed 
* under the Licence is distributed on an "AS IS" basis, 
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
* See the Licence for the specific language governing permissions and limitations under the Licence. 
*/

package gr.ekt.applicanttracker

import org.apache.log4j.Logger;
import org.springframework.mail.MailException
import org.springframework.mail.MailSender
import org.springframework.mail.javamail.MimeMessageHelper

import javax.mail.internet.MimeMessage;
import javax.mail.internet.InternetAddress;

import gr.ekt.applicanttracker.MailPropertiesBean;

/**
* Service for sending emails.
*/
class EmailerService {
   boolean transactional = false
   MailSender mailSender
   MailPropertiesBean mailPropertiesBean

   // If next line is commented in, this service fails to be loaded by grails, as every grails-artefact already has a 'log' property
   // Logger log = Logger.getLogger(this.class.name)

   def sendEmail(mail) throws MailException {

       MimeMessage mimeMessage = mailSender.createMimeMessage()
	   //mimeMessage.setText(mail.text, "UTF-8", "html")
	   //mimeMessage.addHeader(name, MimeUtility.encodeText(value, "utf-8", "B"));

       MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
       helper.setFrom(mailPropertiesBean.getFrom());
       helper.setTo(getInternetAddresses(mail.to));
       helper.setSubject(mail.subject);
       helper.setText(mail.text, true);
       if(mail.bcc) helper.setBcc(getInternetAddresses(mail.bcc));
       if(mail.cc) helper.setCc(getInternetAddresses(mail.cc));

       mailSender.send(mimeMessage)
   }

   private InternetAddress[] getInternetAddresses(List emails){
       InternetAddress[] mailAddresses = new InternetAddress[emails.size()];
	   emails.eachWithIndex {mail, i ->
	   		mailAddresses[i] = new InternetAddress(mail)
	   }
       return mailAddresses;
   }
}