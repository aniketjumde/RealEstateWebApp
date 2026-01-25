package com.realestate.factory;

import com.realestate.service.InquiryService;
import com.realestate.service.InquiryServiceImpl;

public class InquiryServiceFactory 
{
	private static InquiryService inquiryService=null;
	
	private InquiryServiceFactory() { }
	
	public static InquiryService getServiceInstance()
	{
		if(inquiryService==null)
		{
			inquiryService=new InquiryServiceImpl();
		}
		
		return inquiryService;
	}

}
