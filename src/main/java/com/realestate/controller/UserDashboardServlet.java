package com.realestate.controller;

import java.io.IOException;
import java.util.List;

import com.realestate.factory.InquiryServiceFactory;
import com.realestate.factory.PropertyServiceFactory;
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

@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
    private PropertyService propertyService;
    private InquiryService inquiryService;


	
	public void init(ServletConfig config) throws ServletException
	{
        propertyService = PropertyServiceFactory.getServiceInstance();
        inquiryService = InquiryServiceFactory.getServiceInstance();

	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		 HttpSession session = request.getSession(false);
		    User user = (session != null) ? (User) session.getAttribute("user") : null;

		    if (user == null) {
		        response.sendRedirect(request.getContextPath() + "/login.jsp");
		        return;
		    }

		    Long userId = user.getId();

		    //  SELLER 
		    long totalProperties = propertyService.getTotalPropertiesByUser(userId);
		    long approvedCount = propertyService.getApprovedPropertiesByUser(userId);
		    long pendingCount = propertyService.getPendingPropertiesByUser(userId);
		    long rejectedCount = propertyService.getRejectedPropertiesByUser(userId);

		    long receivedInquiries = inquiryService.countReceivedInquiries(userId);

		    //  BUYER
		    long sentInquiries = inquiryService.countSentInquiries(userId);

		    //ROLE FLAGS
		    boolean isSeller = totalProperties > 0;
		    boolean isBuyer = sentInquiries > 0;

		    //SET ATTRIBUTES
		    request.setAttribute("totalProperties", totalProperties);
		    request.setAttribute("approvedCount", approvedCount);
		    request.setAttribute("pendingCount", pendingCount);
		    request.setAttribute("rejectedCount", rejectedCount);
		    request.setAttribute("receivedInquiries", receivedInquiries);

		    request.setAttribute("sentInquiries", sentInquiries);
		    request.setAttribute("isSeller", isSeller);
		    request.setAttribute("isBuyer", isBuyer);

		    //User Properties
		    List<Property> properties =propertyService.getPropertiesByUser(user);

	        request.setAttribute("myProperties", properties);
	        
	     // Buyer inquiries (sent)
	        request.setAttribute("buyerInquiries",inquiryService.getSentInquiries(user.getId()));

	        // Seller inquiries (received)
	        request.setAttribute("sellerInquiries",inquiryService.getReceivedInquiries(user.getId()));

		    
		    request.getRequestDispatcher("/user-dashboard.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		doGet(request, response);
	}

}
