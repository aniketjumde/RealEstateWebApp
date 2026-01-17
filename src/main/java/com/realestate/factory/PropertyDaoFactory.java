package com.realestate.factory;

import com.realestate.dao.PropertyDAO;
import com.realestate.dao.PropertyDaoImpl;

public class PropertyDaoFactory 
{
	private static PropertyDAO propertyDAO=null;
	
	private PropertyDaoFactory() {}
	
	public static PropertyDAO getDaoInstance()
	{
		if(propertyDAO==null)
		{
			propertyDAO=new PropertyDaoImpl();
		}
		
		return propertyDAO;
		
	}
	
	

}
