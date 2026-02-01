package com.realestate.service;

import java.util.List;

import com.realestate.dao.InquiryDAO;
import com.realestate.factory.InquiryDaoFactory;
import com.realestate.model.Inquiry;

public class InquiryServiceImpl implements InquiryService
{

	private InquiryDAO inquiryDAO;
	
	public InquiryServiceImpl()
	{
		inquiryDAO=InquiryDaoFactory.getDaoInstance();
	}

	@Override
	public void sendInquiry(Inquiry inquiry) 
	{
        inquiryDAO.saveInquiry(inquiry);
		
	}

	@Override
	public List<Inquiry> getReceivedInquiries(Long sellerId) 
	{
        return inquiryDAO.getInquiriesByReceiver(sellerId);

	}

	@Override
	public List<Inquiry> getSentInquiries(Long buyerId) 
	{
		 return inquiryDAO.getInquiriesBySender(buyerId);
	}

	@Override
	public Inquiry getInquiry(Long inquiryId) 
	{
		 return inquiryDAO.getInquiryById(inquiryId);
	}

	@Override
	public void replyInquiry(Inquiry inquiry)
	{
		 inquiryDAO.updateInquiry(inquiry);	
	}

	@Override
	public long countReceivedInquiries(Long userId) 
	{
		
		return inquiryDAO.countReceivedInquiries(userId);
	}

	@Override
	public long countSentInquiries(Long userId) 
	{
		
		return inquiryDAO.countSentInquiries(userId);
	}

	
	
	

}
