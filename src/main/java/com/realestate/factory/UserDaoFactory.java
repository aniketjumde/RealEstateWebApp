package com.realestate.factory;

import com.realestate.dao.UserDAO;
import com.realestate.dao.UserDaoImpl;

public class UserDaoFactory 
{
	private static UserDAO userDao=null;
	
	private UserDaoFactory() {}
	
	public static UserDAO getDaoInstance()
	{
		if(userDao==null)
		{
			userDao=new UserDaoImpl();
		}
		
		return userDao;
		
	}
	
}
