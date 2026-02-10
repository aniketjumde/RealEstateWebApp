package com.realestate.util;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.realestate.config.HibernateConfig;

public class HibernateUtil 
{
	private static SessionFactory sessionFactory=null;
	
	private HibernateUtil() { }
	
	
	public static SessionFactory getSessionFactory()
	{
		if(sessionFactory==null)
		{
			Configuration configuration=new Configuration();
			configuration.configure(HibernateConfig.HIBCONFIG_FILE);

		    configuration.setProperty("hibernate.connection.url",System.getenv("DB_URL"));
		    configuration.setProperty("hibernate.connection.username",System.getenv("DB_USER"));
		    configuration.setProperty("hibernate.connection.password",System.getenv("DB_PASSWORD"));
		    
			sessionFactory=configuration.buildSessionFactory();
		}
		
		return sessionFactory;
	}
	
	public static void getCloseSessionFactory()
	{
		 if (sessionFactory != null) {
	            sessionFactory.close();
	        }
	}
}
