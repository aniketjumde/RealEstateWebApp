package com.realestate.controller;

import java.io.IOException;
import java.util.List;

import com.realestate.factory.PropertyServiceFactory;
import com.realestate.factory.UserServiceFactory;
import com.realestate.model.Property;
import com.realestate.model.User;
import com.realestate.service.PropertyService;
import com.realestate.service.UserService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/properties")
public class AdminPropertiesServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	private PropertyService propertyService;
    private UserService userService;
   
	
	public void init(ServletConfig config) throws ServletException
	{
        propertyService = PropertyServiceFactory.getServiceInstance();
        userService=UserServiceFactory.getServiceInstance();

	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		 User admin = (User) request.getSession().getAttribute("user");

	        if (admin == null || !admin.getRole().name().equals("ADMIN")) {
	        	response.sendRedirect(request.getContextPath() + "/dashboard");
	            return;
	        }

	        List<Property> properties = propertyService.getAllProperties();

	        request.setAttribute("properties", properties);
	        request.getRequestDispatcher("/admin-properties.jsp").forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
