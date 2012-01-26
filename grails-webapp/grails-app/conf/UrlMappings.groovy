class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
      "/"(controller:'home')
	  "/$id?"(controller:'candidate', action:'createWithNoInvitationId')
	  "/administrator"(controller:'home')
	  "500"(view:'/error')
	}
}
