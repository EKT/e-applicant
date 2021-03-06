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