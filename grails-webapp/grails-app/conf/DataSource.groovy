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
		dataSource {
			dbCreate = "update"
			url = "jdbc:mysql://hostname/tenders_forms_new?createDatabaseIfNotExist=true&amp;useUnicode=true&amp;characterEncoding=utf-8"
			driverClassName = "com.mysql.jdbc.Driver"
			username = "username"
			password = "password"
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			url = "jdbc:mysql://hostname/tenders_forms_new?createDatabaseIfNotExist=true&amp;useUnicode=true&amp;characterEncoding=utf-8"
			driverClassName = "com.mysql.jdbc.Driver"
			username = "username"
			password = "password"
		}
	}
	production {
		dataSource {
			dbCreate = "update"
			url = "jdbc:mysql://hostname/tenders_forms_new?createDatabaseIfNotExist=true&amp;useUnicode=true&amp;characterEncoding=utf-8"
			driverClassName = "com.mysql.jdbc.Driver"
			username = "username"
			password = "password"
		}
	}
}
