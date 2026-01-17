package com.realestate.factory;

import com.realestate.service.PropertyService;
import com.realestate.service.PropertyServiceImpl;

public class PropertyServiesFactory 
{
	private static PropertyService propertyService=null;
	
	private PropertyServiesFactory() {}
	
	public static PropertyService getServiceInstance()
	{
		if(propertyService==null)
		{
			propertyService= new PropertyServiceImpl();
		}
		
		return propertyService;
	}

}
