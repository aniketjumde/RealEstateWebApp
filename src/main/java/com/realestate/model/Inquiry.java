package com.realestate.model;


import com.realestate.enums.InquiryStatus;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name="inquiries")
public class Inquiry 
{

	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "inquiry_id")
    private Long inquiryId;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "property_id")
    private Property property;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sender_id")
    private User sender;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "receiver_id")
    private User receiver;
    
    @Column(name = "message")
    private String message;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private InquiryStatus status;

    //Constructor
	
    public Inquiry() {}

	public Inquiry(Long inquiryId, Property property, User sender, User receiver, String message,
			InquiryStatus status) {
		super();
		this.inquiryId = inquiryId;
		this.property = property;
		this.sender = sender;
		this.receiver = receiver;
		this.message = message;
		this.status = status;
	}

	 //Setter and Getter
	
	public Long getInquiryId() {
		return inquiryId;
	}

	public void setInquiryId(Long inquiryId) {
		this.inquiryId = inquiryId;
	}

	public Property getProperty() {
		return property;
	}

	public void setProperty(Property property) {
		this.property = property;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public User getReceiver() {
		return receiver;
	}

	public void setReceiver(User receiver) {
		this.receiver = receiver;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public InquiryStatus getStatus() {
		return status;
	}

	public void setStatus(InquiryStatus status) {
		this.status = status;
	}

   
    
    
}
