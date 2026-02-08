package com.realestate.controller;

import java.io.IOException;
import java.util.List;

import com.realestate.factory.PropertyServiceFactory;
import com.realestate.model.Property;
import com.realestate.service.PropertyService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/index")
public class HomeServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	private PropertyService propertyService;

	public void init(ServletConfig config) throws ServletException 
	{
            propertyService=PropertyServiceFactory.getServiceInstance();
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		 List<Property> featuredProperties =propertyService.getLatestApprovedProperties(6);
		 System.out.println(featuredProperties);
		 request.setAttribute("featuredProperties",featuredProperties);

	        request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
