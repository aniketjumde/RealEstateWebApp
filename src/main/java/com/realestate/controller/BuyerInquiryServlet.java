package com.realestate.controller;

import java.io.IOException;
import java.util.List;

import com.realestate.factory.InquiryServiceFactory;
import com.realestate.model.Inquiry;
import com.realestate.model.User;
import com.realestate.service.InquiryService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/buyer/inquiries")
public class BuyerInquiryServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    private InquiryService inquiryService;

	
	public void init(ServletConfig config) throws ServletException
	{
        inquiryService = InquiryServiceFactory.getServiceInstance();

	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		 HttpSession session = request.getSession(false);
	        User buyer = (session != null) ? (User) session.getAttribute("user") : null;

	        if (buyer == null) {
	            response.sendRedirect(request.getContextPath() + "/login.jsp");
	            return;
	        }

	        List<Inquiry> inquiries =
	                inquiryService.getSentInquiries(buyer.getId());

	        request.setAttribute("inquiries", inquiries);
	        request.getRequestDispatcher("/buyer-inquiries.jsp")
	               .forward(request, response);	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		doGet(request, response);
	}

}
