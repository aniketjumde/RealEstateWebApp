package com.realestate.factory;

import com.realestate.dao.InquiryDAO;
import com.realestate.dao.InquiryDaoImpl;

public class InquiryDaoFactory 
{
	private static InquiryDAO inquiryDao=null;
	
	private InquiryDaoFactory() {}
	
	public static InquiryDAO getDaoInstance()
	{
		if(inquiryDao==null)
		{
			inquiryDao=new InquiryDaoImpl();
		}
		return inquiryDao;
	}

}
