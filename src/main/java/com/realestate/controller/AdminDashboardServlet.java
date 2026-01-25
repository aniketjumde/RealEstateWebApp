package com.realestate.controller;

import java.io.IOException;

import com.realestate.factory.PropertyServiceFactory;
import com.realestate.factory.UserServiceFactory;
import com.realestate.service.PropertyService;
import com.realestate.service.UserService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
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
		 	request.setAttribute("totalUsers",userService.getTotalUsers());
		 	request.setAttribute("totalProperties",propertyService.getTotalProperties());
		 	request.setAttribute("approvedProperties",propertyService.getApprovedPropertiesCount());
		 	request.setAttribute("pendingProperties",propertyService.getPendingPropertiesCount());
		 	request.setAttribute("rejectedProperties",propertyService.getRejectedPropertiesCount());

        

		 	request.getRequestDispatcher("/admin-dashboard.jsp")
               .forward(request, response);	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		doGet(request, response);
	}

}
