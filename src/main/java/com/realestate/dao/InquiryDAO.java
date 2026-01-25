package com.realestate.dao;

import java.util.List;

import com.realestate.model.Inquiry;

public interface InquiryDAO 
{
	 public	void saveInquiry(Inquiry inquiry);

	 public List<Inquiry> getInquiriesByReceiver(Long sellerId);

	 public List<Inquiry> getInquiriesBySender(Long buyerId);

	 public Inquiry getInquiryById(Long inquiryId);

	 public void updateInquiry(Inquiry inquiry);
	 
}
