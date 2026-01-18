package com.realestate.factory;

import com.realestate.dao.PropertyImageDAO;
import com.realestate.dao.PropertyImageDaoImpl;

public class PropertyImageDaoFactory 
{
	private static PropertyImageDAO propertyImageDAO=null;
	
	private PropertyImageDaoFactory() {}
	
	public static PropertyImageDAO getDaoInstance()
	{
		if(propertyImageDAO==null)
		{
			propertyImageDAO=new PropertyImageDaoImpl();
		}
		
		return propertyImageDAO;
	}
}
