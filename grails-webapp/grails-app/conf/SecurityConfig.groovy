security {

	// see DefaultSecurityConfig.groovy for all settable/overridable properties

	active = true

	loginUserDomainClass = "EATUser"
	authorityDomainClass = "EATRole"
	//requestMapClass = false //"EATRequestmap"
	//useControllerAnnotations = true
	
	useRequestMapDomainClass = false
	useControllerAnnotations = true
}
