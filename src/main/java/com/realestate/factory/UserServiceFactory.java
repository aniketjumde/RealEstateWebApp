package com.realestate.factory;

import com.realestate.service.UserService;
import com.realestate.service.UserServiceImpl;

public class UserServiceFactory 
{
	private static UserService userService=null;
	
	private UserServiceFactory() {}
	
	public static UserService getServiceInstance()
	{
		if(userService==null)
		{
			userService=new UserServiceImpl();
		}
		
		return userService;
	}
	
	
}
