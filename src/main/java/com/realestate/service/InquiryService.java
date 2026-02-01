package com.realestate.service;

import java.util.List;

import com.realestate.model.Inquiry;

public interface InquiryService
{
	 public	void sendInquiry(Inquiry inquiry);

	 public List<Inquiry> getReceivedInquiries(Long sellerId);;

	 public  List<Inquiry> getSentInquiries(Long buyerId);

	 public  Inquiry getInquiry(Long inquiryId);

	 public void replyInquiry(Inquiry inquiry);

	 public long countReceivedInquiries(Long userId);
	 
	 public long countSentInquiries(Long userId);

}
