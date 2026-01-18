package com.realestate.controller;

import java.io.IOException;
import java.util.List;

import com.realestate.factory.PropertyServiceFactory;
import com.realestate.model.Property;
import com.realestate.service.PropertyService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/property-search")
public class PropertySearchServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	private PropertyService propertyService;
	
	 public void init() 
	 {
		 propertyService =PropertyServiceFactory.getServiceInstance();
	    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String city=request.getParameter("city");
		String type=request.getParameter("tyoe");
        String purpose = request.getParameter("purpose");


        Integer minBedrooms = parseInt(request.getParameter("bedrooms"));
        Double maxPrice = parseDouble(request.getParameter("maxPrice"));
        
        List<Property> properties=propertyService.searchProperties(city, type, minBedrooms);
        request.setAttribute("list", properties);
        request.getRequestDispatcher("property-list.jsp")
        .forward(request, response);
	}

	
	private Double parseDouble(String value) 
	{
		return (value==null || value.isEmpty() ? null:Double.parseDouble(value));
	}


	private Integer parseInt(String value) {
		return (value==null || value.isEmpty() ? null:Integer.parseInt(value));
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}

}
