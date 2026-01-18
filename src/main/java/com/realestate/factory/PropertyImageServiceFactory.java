package com.realestate.factory;

import com.realestate.service.PropertyImageService;
import com.realestate.service.PropertyImageServiceImpl;

public class PropertyImageServiceFactory 
{
	private static PropertyImageService propertyImageService=null;
	
	private PropertyImageServiceFactory() {};
	
	public static PropertyImageService getServiceInstance()
	{
		
		if(propertyImageService==null)
		{
			propertyImageService=new PropertyImageServiceImpl();
		}
		
		return propertyImageService;
	}
	
}
