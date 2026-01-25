package com.realestate.controller;

import java.io.IOException;

import com.realestate.enums.InquiryStatus;
import com.realestate.factory.InquiryServiceFactory;
import com.realestate.factory.PropertyServiceFactory;
import com.realestate.model.Inquiry;
import com.realestate.model.Property;
import com.realestate.model.User;
import com.realestate.service.InquiryService;
import com.realestate.service.PropertyService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/send-inquiry")
public class SendInquiryServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	private InquiryService inquiryService;
	private PropertyService propertyService;
	
	public void init(ServletConfig config) throws ServletException 
	{
		inquiryService=InquiryServiceFactory.getServiceInstance();
		propertyService=PropertyServiceFactory.getServiceInstance();
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
        User buyer = (User) session.getAttribute("user");
        
        Long propertyId = Long.parseLong(request.getParameter("propertyId"));
        String message = request.getParameter("message");
        
        Property property = propertyService.getPropertyById(propertyId);

        Inquiry inquiry = new Inquiry();
        inquiry.setProperty(property);
        inquiry.setSender(buyer);
        inquiry.setReceiver(property.getUser()); // seller
        inquiry.setMessage(message);
        inquiry.setStatus(InquiryStatus.PENDING);

        inquiryService.sendInquiry(inquiry);

        response.sendRedirect("property-details?id=" + propertyId);

	}

}
