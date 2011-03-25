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
			url = "jdbc:mysql://devdb.ekt.gr/tenders_forms?createDatabaseIfNotExist=true&amp;useUnicode=true&amp;characterEncoding=utf-8"
			driverClassName = "com.mysql.jdbc.Driver"
			username = "root"
			password = "root"*/
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			url = "jdbc:mysql://devdb.ekt.gr/tenders_forms?createDatabaseIfNotExist=true&amp;useUnicode=true&amp;characterEncoding=utf-8"
			driverClassName = "com.mysql.jdbc.Driver"
			username = "root"
			password = "root"
		}
	}
	production {
		dataSource {
			//dbCreate = "update"
			//url = "jdbc:hsqldb:file:prodDb;shutdown=true"
			dbCreate = "update"
			url = "jdbc:mysql://myprod.ekt.gr/tenders_forms?createDatabaseIfNotExist=true&amp;useUnicode=true&amp;characterEncoding=utf-8"
			driverClassName = "com.mysql.jdbc.Driver"
			username = "tenders"
			password = "567TGB987rfv"
		}
	}
}
