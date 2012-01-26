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
	
	String exportListInExcel(applicationFormList, pathToSave, skills, wishSkills, selectedProject) {
		
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
		
		String sheetName = "application forms"
		
		if (applicationFormList.size() > 0){
			
			if (skills.size()>0)
				sheetName = selectedProject
		}
		
		WritableSheet s1 =  workbook.createSheet(sheetName, 0);
		
		s1.setColumnView(0, 14)
		s1.setColumnView(1, 25)
		s1.setColumnView(2, 25)
		//s1.setColumnView(3, 25)
		s1.setColumnView(3, 17)
		s1.setColumnView(4, 20)
		s1.setColumnView(5, 20)
		s1.setColumnView(6, 20)
		s1.setColumnView(7, 20)
		s1.setColumnView(8, 20)
		s1.setColumnView(9, 20)
		s1.setColumnView(10, 10)
		s1.setColumnView(11, 10)
		
		skills.eachWithIndex { obj, i -> 
			s1.setColumnView(12+i, 25)
		}
		
		wishSkills.eachWithIndex { obj, i ->
			s1.setColumnView(12 + skills.size() + i, 25)
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
		Label epipedoHeaderLabel = new Label(5, 0, "Επίπεδο Εκπαίδευσης", headerCellFormat)
		s1.addCell(epipedoHeaderLabel)
		Label axsiologisiHeaderLabel = new Label(6, 0, "Αξιολόγηση Υποψηφίου", headerCellFormat)
		s1.addCell(axsiologisiHeaderLabel)
		Label axsiologisiNotesHeaderLabel = new Label(7, 0, "Σημειώσεις Αξιολόγησης Υπ.", headerCellFormat)
		s1.addCell(axsiologisiNotesHeaderLabel)
		Label axsiologisi2HeaderLabel = new Label(8, 0, "Αξιολόγηση Αίτησης", headerCellFormat)
		s1.addCell(axsiologisi2HeaderLabel)
		Label axsiologisi2NotesHeaderLabel = new Label(9, 0, "Σημειώσεις Αξιολόγησης Αιτ.", headerCellFormat)
		s1.addCell(axsiologisi2NotesHeaderLabel)
		//Label countryHeaderLabel = new Label(6, 0, "Χώρα", headerCellFormat)
		//s1.addCell(countryHeaderLabel)
		//Label issuedHeaderLabel = new Label(7, 0, "Ημ. Εγγραφής", headerCellFormat)
		//s1.addCell(issuedHeaderLabel)
		//Label invitationHeaderLabel = new Label(8, 0, "Πρόσκληση", headerCellFormat)
		//s1.addCell(invitationHeaderLabel)
		//Label projectHeaderLabel = new Label(9, 0, "Έργα", headerCellFormat)
		//s1.addCell(projectHeaderLabel)
		Label bioStatusHeaderLabel = new Label(10, 0, "Κατάσταση αρχείου Βιογραφικού", headerCellFormat)
		s1.addCell(bioStatusHeaderLabel)
		Label apPFormStatusHeaderLabel = new Label(11, 0, "Κατάσταση αρχείου Υπ. Δήλωσης", headerCellFormat)
		s1.addCell(apPFormStatusHeaderLabel)
		
		skills.eachWithIndex { obj, i ->
			Label skillHeaderLabel = new Label(12+i, 0, obj.title, headerCellFormat)
			s1.addCell(skillHeaderLabel)
		}
		
		wishSkills.eachWithIndex { obj, i ->
			Label skillHeaderLabel = new Label(12 + skills.size() + i, 0, obj.title, headerCellFormat2)
			s1.addCell(skillHeaderLabel)
		}
		
		int row = 2;
		
		for (ApplicationForm applicationForm : applicationFormList){
			Label idLabel = new Label(0, row, String.valueOf(applicationForm.id))
			Label firstnameLabel = new Label(1, row, getUnstressed(applicationForm.appFormCandidate.firstname))
			Label lastnameLabel = new Label(2, row, getUnstressed(applicationForm.appFormCandidate.lastname))
			
			Label birthLabel = new Label(3, row, "")
			if (applicationForm.appFormCandidate.yearOfBirth != null){
				birthLabel = new Label(3, row, applicationForm.appFormCandidate.yearOfBirth)
			}
			
			Label cityLabel = new Label(4, row, getUnstressed(applicationForm.appFormCandidate.city))
			
			String bioStatus = applicationForm.bioFileCheckStatus?.toString()
			if ("".equals(bioStatus) || bioStatus==null)
				bioStatus = "Δεν έχει ελεγχθεί"
			String appFormStatus = applicationForm.appFormFileCheckStatus?.toString()
			if ("".equals(appFormStatus) || appFormStatus==null)
				appFormStatus = "Δεν έχει ελεγχθεί"
			
			String epipedoFormStatus = applicationForm.appFormCandidate?.educationalLevel?.toString()
			if ("".equals(epipedoFormStatus) || epipedoFormStatus==null)
				epipedoFormStatus = "Δεν έχει συμπληρωθεί"
			
			String axsiologisiFormStatus = applicationForm.appFormCandidate?.candidateEvaluation?.candidateEvalLevel?.toString()
			if ("".equals(axsiologisiFormStatus) || axsiologisiFormStatus==null)
				axsiologisiFormStatus = "Δεν έχει γίνει αξιολόγηση"
			
			String axsiologisiNotes = applicationForm.appFormCandidate?.candidateEvaluation?.notes
			
			def application
			applicationForm.appFormApplications.each{
				if (it?.project?.code?.equals(selectedProject)){
					application = it
				}
			}
			String axsiologisi2FormStatus = application.applicationEvaluation?.applicationEvalLevel?.toString()
			if ("".equals(axsiologisi2FormStatus) || axsiologisi2FormStatus==null)
				axsiologisi2FormStatus = "Δεν έχει γίνει αξιολόγηση"
			
			String axsiologisi2Notes = application.applicationEvaluation?.notes
			
			Label epipedoStatusLabel = new Label(5, row, epipedoFormStatus)
			Label axsiologisiStatusLabel = new Label(6, row, axsiologisiFormStatus)
			Label axsiologisiNotesLabel = new Label(7, row, axsiologisiNotes)
			Label axsiologisi2StatusLabel = new Label(8, row, axsiologisi2FormStatus)
			Label axsiologisi2NotesLabel = new Label(9, row, axsiologisi2Notes)
			
			Label bioStatusLabel = new Label(10, row, bioStatus)
			Label appFormStatusLabel = new Label(11, row, appFormStatus)
			
			s1.addCell idLabel
			s1.addCell firstnameLabel
			s1.addCell lastnameLabel
			s1.addCell birthLabel
			s1.addCell cityLabel
			s1.addCell epipedoStatusLabel
			s1.addCell axsiologisiStatusLabel
			s1.addCell axsiologisiNotesLabel
			s1.addCell axsiologisi2StatusLabel
			s1.addCell axsiologisi2NotesLabel
			s1.addCell bioStatusLabel
			s1.addCell appFormStatusLabel
			
			applicationForm.appFormApplications.each { 
				if (it?.project?.code.equals(selectedProject)){
					skills.eachWithIndex { obj, i ->
						if (it.applicationSkills.contains(obj)){
							Label skillValueLabel = new Label(12+i, row, "ΝΑΙ")
							s1.addCell(skillValueLabel)
						}
						else {
							Label skillValueLabel = new Label(12+i, row, "ΌΧΙ")
							s1.addCell(skillValueLabel)
						}
					}
					wishSkills.eachWithIndex { obj, i ->
						if (it.applicationSkills.contains(obj)){
							Label skillValueLabel = new Label(12+skills.size()+i, row, "ΝΑΙ")
							s1.addCell(skillValueLabel)
						}
						else {
							Label skillValueLabel = new Label(12+skills.size()+i, row, "ΌΧΙ")
							s1.addCell(skillValueLabel)
						}
					}
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
