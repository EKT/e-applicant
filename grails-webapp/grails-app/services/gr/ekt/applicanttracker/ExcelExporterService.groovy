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

import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

class ExcelExporterService {
	
	static transactional = true
	
	String exportListInExcel(applicationList, pathToSave, skills, wishSkills) {
		
		WorkbookSettings ws = new WorkbookSettings();
		ws.setLocale(new Locale("en", "EN"));
		WritableWorkbook workbook = null;
		String filename = String.valueOf((new Date()).getTime())+".xls"
		String allName = pathToSave + File.separator + filename
		try {
			workbook = Workbook.createWorkbook(new File(allName), ws)
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String sheetName = "applications"
		
		if (applicationList.size() > 0){
			String projects = ""
			applicationList.getAt(0).projects.each {
				if (it?.code)
					projects += it?.code + "\n"
			}
			
			if (skills.size()>0)
				sheetName = projects
		}
		
		WritableSheet s1 =  workbook.createSheet(sheetName, 0);
		
		s1.setColumnView(0, 14)
		s1.setColumnView(1, 25)
		s1.setColumnView(2, 25)
		//s1.setColumnView(3, 25)
		s1.setColumnView(3, 17)
		s1.setColumnView(4, 20)
		//s1.setColumnView(6, 14)
		//s1.setColumnView(7, 21)
		//s1.setColumnView(8, 23)
		//s1.setColumnView(9, 17)
		s1.setColumnView(5, 10)
		s1.setColumnView(6, 10)
		
		skills.eachWithIndex { obj, i -> 
			s1.setColumnView(7+i, 25)
		}
		
		wishSkills.eachWithIndex { obj, i ->
			s1.setColumnView(7 + skills.size() + i, 25)
		}
		
		//Write header
		WritableFont headerFont = new WritableFont(WritableFont.ARIAL, 10, WritableFont.BOLD)
		WritableCellFormat headerCellFormat = new WritableCellFormat(headerFont)
		WritableFont headerFont2 = new WritableFont(WritableFont.ARIAL, 8, WritableFont.NO_BOLD)
		WritableCellFormat headerCellFormat2 = new WritableCellFormat(headerFont2)
		headerCellFormat.setWrap(true)
		Label idHeaderLabel = new Label(0, 0, "Κωδικός Εγγραφής", headerCellFormat)
		s1.addCell(idHeaderLabel)
		Label nameHeaderLabel = new Label(1, 0, "Όνομα", headerCellFormat)
		s1.addCell(nameHeaderLabel)
		Label lastnameHeaderLabel = new Label(2, 0, "Επώνυμο", headerCellFormat)
		s1.addCell(lastnameHeaderLabel)
		//Label emailHeaderLabel = new Label(3, 0, "Email", headerCellFormat)
		//s1.addCell(emailHeaderLabel)
		Label birthHeaderLabel = new Label(3, 0, "Ημ. Γέννησης", headerCellFormat)
		s1.addCell(birthHeaderLabel)
		Label cityHeaderLabel = new Label(4, 0, "Πόλη", headerCellFormat)
		s1.addCell(cityHeaderLabel)
		//Label countryHeaderLabel = new Label(6, 0, "Χώρα", headerCellFormat)
		//s1.addCell(countryHeaderLabel)
		//Label issuedHeaderLabel = new Label(7, 0, "Ημ. Εγγραφής", headerCellFormat)
		//s1.addCell(issuedHeaderLabel)
		//Label invitationHeaderLabel = new Label(8, 0, "Πρόσκληση", headerCellFormat)
		//s1.addCell(invitationHeaderLabel)
		//Label projectHeaderLabel = new Label(9, 0, "Έργα", headerCellFormat)
		//s1.addCell(projectHeaderLabel)
		Label bioStatusHeaderLabel = new Label(5, 0, "Κατάσταση αρχείου Βιογραφικού", headerCellFormat)
		s1.addCell(bioStatusHeaderLabel)
		Label apPFormStatusHeaderLabel = new Label(6, 0, "Κατάσταση αρχείου Υπ. Δήλωσης", headerCellFormat)
		s1.addCell(apPFormStatusHeaderLabel)
		
		skills.eachWithIndex { obj, i ->
			Label skillHeaderLabel = new Label(7+i, 0, obj.title, headerCellFormat)
			s1.addCell(skillHeaderLabel)
		}
		
		wishSkills.eachWithIndex { obj, i ->
			Label skillHeaderLabel = new Label(7 + skills.size() + i, 0, obj.title, headerCellFormat2)
			s1.addCell(skillHeaderLabel)
		}
		
		int row = 2;
		
		for (Application application : applicationList){
			Label idLabel = new Label(0, row, String.valueOf(application.id))
			Label firstnameLabel = new Label(1, row, getUnstressed(application.firstname))
			Label lastnameLabel = new Label(2, row, getUnstressed(application.lastname))
			//Label emailLabel = new Label(3, row, application.email)
			Label birthLabel = new Label(3, row, "")
			if (application.yearOfBirth != null){
				birthLabel = new Label(3, row, application.yearOfBirth)
			}
			
			Label cityLabel = new Label(4, row, getUnstressed(application.city))
			//Label countryLabel = new Label(6, row, application.country)
			
			//Label dateIssuedLabel = new Label(7, row, application.dateIssued.toString())
			//Label invitationLabel = new Label(8, row, application.invitation.code)
			
			//String projects = ""
			//application.projects.each { 
			//	if (it?.code)
			//		projects += it?.code + "\n"	
			//}
			//Label projectsLabel = new Label(9, row, projects)
			
			String bioStatus = application.bioFileCheckStatus?.toString()
			if ("".equals(bioStatus) || bioStatus==null)
				bioStatus = "Δεν έχει ελεγχθεί"
			String appFormStatus = application.appFormFileCheckStatus?.toString()
			if ("".equals(appFormStatus) || appFormStatus==null)
				appFormStatus = "Δεν έχει ελεγχθεί"
			Label bioStatusLabel = new Label(5, row, bioStatus)
			Label appFormStatusLabel = new Label(6, row, appFormStatus)
			
			s1.addCell idLabel
			s1.addCell firstnameLabel
			s1.addCell lastnameLabel
			//s1.addCell emailLabel
			s1.addCell birthLabel
			s1.addCell cityLabel
			//s1.addCell countryLabel
			//s1.addCell dateIssuedLabel
			//s1.addCell invitationLabel
			//s1.addCell projectsLabel
			s1.addCell bioStatusLabel
			s1.addCell appFormStatusLabel
			
			skills.eachWithIndex { obj, i ->
				if (application.appSkills.contains(obj)){
					Label skillValueLabel = new Label(7+i, row, "ΝΑΙ")
					s1.addCell(skillValueLabel)
				}
				else {
					Label skillValueLabel = new Label(7+i, row, "ΌΧΙ")
					s1.addCell(skillValueLabel)
				}
			}
			wishSkills.eachWithIndex { obj, i ->
				if (application.appSkills.contains(obj)){
					Label skillValueLabel = new Label(7+skills.size()+i, row, "ΝΑΙ")
					s1.addCell(skillValueLabel)
				}
				else {
					Label skillValueLabel = new Label(7+skills.size()+i, row, "ΌΧΙ")
					s1.addCell(skillValueLabel)
				}
			}
			
			row++
		}
		
		
		try {
			workbook.write();
			workbook.close();
		} catch (WriteException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return allName
	}
	
	String getUnstressed(String s){
		String result = s.toUpperCase();
		
		result = result.replace("Ά" , "Α")
		result = result.replace("Έ" , "Ε")
		result = result.replace("Ύ" , "Υ")
		result = result.replace("Ί" , "Ι")
		result = result.replace("Ή" , "Η")
		result = result.replace("Ό" , "Ο")
		result = result.replace("Ώ" , "Ω")
		result = result.replace("Ϊ" , "Ι")
		result = result.replace("Ϋ" , "Υ")
		
		return result
		
	}
}
