package com.realestate.controller;

import java.io.IOException;

import com.realestate.factory.PropertyServiceFactory;
import com.realestate.model.Property;
import com.realestate.service.PropertyService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/property-details")
public class PropertyDetailsServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
	private PropertyService propertyService;

	    @Override
	public void init() 
	{
	    propertyService = PropertyServiceFactory.getServiceInstance();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
        long propertyId = Integer.parseInt(request.getParameter("id"));

        Property property=propertyService.getPropertyById(propertyId);
        

        request.setAttribute("property", property);
        request.getRequestDispatcher("/property-details.jsp")
               .forward(request, response);
	}

	

}
