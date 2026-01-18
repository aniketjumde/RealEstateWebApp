package com.realestate.controller;

import java.io.IOException;

import org.hibernate.Session;

import com.realestate.factory.PropertyImageServiceFactory;
import com.realestate.model.PropertyImage;
import com.realestate.service.PropertyImageService;
import com.realestate.util.HibernateUtil;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/property-image")
public class PropertyImageServlet extends HttpServlet 
{
	private PropertyImageService propertyImageService;
	
	 public void init() 
	 {
		 propertyImageService =PropertyImageServiceFactory.getServiceInstance();
	    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException 
    {

        Long imageId = Long.parseLong(request.getParameter("id"));
        PropertyImage image=propertyImageService.getImageById(imageId);

        if (image != null && image.getImageData() != null) 
        {
            response.setContentType("image/jpeg");
            response.getOutputStream().write(image.getImageData());
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
