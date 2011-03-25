class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
      "/"(controller:'application', action:'create')
	  "/$id?"(controller:'invitation', action:'showForm')
	  "/administrator"(controller:'application', action:'list')
	  "500"(view:'/error')
	}
}
