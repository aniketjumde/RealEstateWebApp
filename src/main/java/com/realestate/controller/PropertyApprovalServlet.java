package com.realestate.controller;

import java.io.IOException;
import java.util.List;

import com.realestate.enums.PropertyVerificationStatus;
import com.realestate.factory.PropertyServiceFactory;
import com.realestate.model.Property;
import com.realestate.service.PropertyService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/property-approval")
public class PropertyApprovalServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    private PropertyService propertyService;
	
	
	public void init(ServletConfig config) throws ServletException 
	{
        propertyService = PropertyServiceFactory.getServiceInstance();

	}	

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		 List<Property> pendingProperties =propertyService.getPendingProperties();

	       
	     request.setAttribute("pendingProperties", pendingProperties);

	     request.getRequestDispatcher("/admin-property-approval.jsp").forward(request, response);

	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		 Long propertyId =Long.parseLong(request.getParameter("propertyId"));
		 String action = request.getParameter("action");

	        Property property =propertyService.getPropertyById(propertyId);

	        if ("APPROVE".equals(action)) 
	        {
	            property.setVerification(PropertyVerificationStatus.APPROVED);
	        } 
	        else if ("REJECT".equals(action)) 
	        {
	            property.setVerification(PropertyVerificationStatus.REJECTED);
	        }

	        propertyService.updateProperty(property);

	        response.sendRedirect("property-approval");
	}

}
