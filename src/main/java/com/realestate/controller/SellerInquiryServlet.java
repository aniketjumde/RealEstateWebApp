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


@WebServlet("/seller/inquiries")
public class SellerInquiryServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	private InquiryService inquiryService;
	
	public void init(ServletConfig config) throws ServletException 
	{
		inquiryService=InquiryServiceFactory.getServiceInstance();

	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		 User seller = (User) session.getAttribute("user");

		 if (seller == null) {
	            response.sendRedirect(request.getContextPath() + "/login.jsp");
	            return;
	        }
		 
	        List<Inquiry> inquiries =
	            inquiryService.getReceivedInquiries(seller.getId());

	        request.setAttribute("inquiries", inquiries);
	        request.getRequestDispatcher("/seller-inquiries.jsp")
	               .forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
		 HttpSession session = request.getSession(false);
	        User seller = (session != null) ? (User) session.getAttribute("user") : null;

	        if (seller == null) {
	            response.sendRedirect(request.getContextPath() + "/login.jsp");
	            return;
	        }

	    Long inquiryId = Long.parseLong(request.getParameter("inquiryId"));
        String status = request.getParameter("status");
        
        

        //inquiryService.updateInquiryStatus(inquiryId, status);

        response.sendRedirect(request.getContextPath() + "/seller/inquiries");
        
	}

}
