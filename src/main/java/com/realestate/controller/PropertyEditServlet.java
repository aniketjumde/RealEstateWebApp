package com.realestate.controller;

import java.io.IOException;

import com.realestate.enums.PropertyVerificationStatus;
import com.realestate.factory.PropertyServiceFactory;
import com.realestate.model.Property;
import com.realestate.model.User;
import com.realestate.service.PropertyService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/property-edit")
@MultipartConfig
public class PropertyEditServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
    private PropertyService propertyService;

	
	public void init(ServletConfig config) throws ServletException 
	{
        propertyService = PropertyServiceFactory.getServiceInstance();

	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) 
		{
		    response.sendRedirect("login.jsp");
		    return;
		}
		User loggedUser = (User) session.getAttribute("user");

		
		Long propertyId = Long.parseLong(request.getParameter("id"));
		Property property=propertyService.getPropertyById(propertyId);
		
		//Property Check
		if (property == null) 
		{
            response.sendRedirect("property");
            return;
        }
		
		//if admin can Reject the Property or SOLD the user can not edit
		if (property.getVerification() == PropertyVerificationStatus.REJECTED ||property.getVerification() == PropertyVerificationStatus.SOLD)
		{
			    response.sendRedirect("access-denied.jsp");
			    return;
		}


        request.setAttribute("property", property);
        request.getRequestDispatcher("edit-property.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		   HttpSession session = request.getSession(false);
	       if (session == null || session.getAttribute("user") == null)
	       {
	            response.sendRedirect("login.jsp");
	            return;
	       }

	        User loggedUser = (User) session.getAttribute("user");

	        Long id = Long.parseLong(request.getParameter("id"));
	        Property property = propertyService.getPropertyById(id);

	        if (property == null || !property.getUser().getId().equals(loggedUser.getId())) 
	        {

	            response.sendRedirect("access-denied.jsp");
	            return;
	        }
	        
	        if (property.getVerification() == PropertyVerificationStatus.REJECTED || property.getVerification() == PropertyVerificationStatus.SOLD)
	        {
	             response.sendRedirect("access-denied.jsp");
	             return;
	        }

	        // Update All Feilds
	        property.setTitle(request.getParameter("title"));
	        property.setDescription(request.getParameter("description"));
	        property.setPrice(Double.parseDouble(request.getParameter("price")));
	        property.setCity(request.getParameter("city"));
	        property.setState(request.getParameter("state"));
            property.setPropetystatus(request.getParameter("status"));
	        property.setAreaSqarefit(Integer.parseInt(request.getParameter("area")));
	        property.setBedrooms(Integer.parseInt(request.getParameter("bedrooms")));
	        property.setBathrooms(Integer.parseInt(request.getParameter("bathrooms")));
	        property.setPurpose(request.getParameter("purpose"));
	        property.setPropertyType(request.getParameter("type"));

	        //  Send Back to Admin For Re-Approval
	        property.setVerification(PropertyVerificationStatus.PENDING);

	        propertyService.updateProperty(property);

	        session.setAttribute("successMessage",
	        	    "Property updated successfully and sent for admin approval");

	        	//  always redirect to user-properties
	        	response.sendRedirect(request.getContextPath() + "/user-properties");
	    }
	}


