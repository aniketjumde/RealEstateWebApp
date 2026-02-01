package com.realestate.controller;

import java.io.IOException;

import com.realestate.factory.PropertyServiceFactory;
import com.realestate.service.PropertyService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

 
@WebServlet("/property-delete")
public class PropertyDeleteServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	private PropertyService propertyService=null;
	
		public void init(ServletConfig config) throws ServletException
		{
			super.init(config);
			propertyService=PropertyServiceFactory.getServiceInstance();
		}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		Long id=Long.parseLong(request.getParameter("id"));
		
		propertyService.deleteProperty(id);
		
		HttpSession session = request.getSession();
		session.setAttribute("successMessage", "Property deleted successfully");

		//   redirect to user-properties
		response.sendRedirect(request.getContextPath() + "/user-properties");	
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

        doGet(request, response);

	
	}
	

}
