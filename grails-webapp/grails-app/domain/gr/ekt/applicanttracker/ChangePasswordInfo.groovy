package gr.ekt.applicanttracker

class ChangePasswordInfo {

	String oldPasswd
	String newPasswd
	String newPasswdVerification
	
    static constraints = {
		oldPasswd(nullable:false, blank:false)
		newPasswd(nullable:false, blank:false)
		newPasswdVerification(blank:false, validator:{val, obj ->
			if (!val?.equals(obj.newPasswd)){
				return false;
			}
		})
    }
	
	static transients = ['oldPasswd', 'newPasswd', 'newPasswdVerification']
}
