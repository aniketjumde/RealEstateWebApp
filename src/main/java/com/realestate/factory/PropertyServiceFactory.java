package com.realestate.factory;

import com.realestate.service.PropertyService;
import com.realestate.service.PropertyServiceImpl;

public class PropertyServiceFactory 
{
	private static PropertyService propertyService=null;
	
	private PropertyServiceFactory() {}
	
	public static PropertyService getServiceInstance()
	{
		if(propertyService==null)
		{
			propertyService= new PropertyServiceImpl();
		}
		
		return propertyService;
	}

}
