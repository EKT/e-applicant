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

dataSource {
	pooled = true
	driverClassName = "org.hsqldb.jdbcDriver"
	username = "sa"
	password = ""
}
hibernate {
	cache.use_second_level_cache = true
	cache.use_query_cache = true
	cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
	development {
		/*dataSource {
			dbCreate = "create-drop" // one of 'create', 'create-drop','update'
			url = "jdbc:hsqldb:mem:devDB"
		}*/
		dataSource {
			dbCreate = "update"
			url = "jdbc:mysql://127.0.0.1/tenders_forms?createDatabaseIfNotExist=true&amp;useUnicode=true&amp;characterEncoding=utf-8"
			driverClassName = "com.mysql.jdbc.Driver"
			username = "root"
			password = "mirage2000"
			/*dbCreate = "update"
			url = "jdbc:mysql://127.0.0.1/tenders_forms?createDatabaseIfNotExist=true&amp;useUnicode=true&amp;characterEncoding=utf-8"
			driverClassName = "com.mysql.jdbc.Driver"
			username = ""
			password = ""*/
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			url = "jdbc:mysql://127.0.0.1/tenders_forms?createDatabaseIfNotExist=true&amp;useUnicode=true&amp;characterEncoding=utf-8"
			driverClassName = "com.mysql.jdbc.Driver"
			username = ""
			password = ""
		}
	}
	production {
		dataSource {
			//dbCreate = "update"
			//url = "jdbc:hsqldb:file:prodDb;shutdown=true"
			dbCreate = "update"
			url = "jdbc:mysql://127.0.0.1/tenders_forms?createDatabaseIfNotExist=true&amp;useUnicode=true&amp;characterEncoding=utf-8"
			driverClassName = "com.mysql.jdbc.Driver"
			username = ""
			password = ""
		}
	}
}
