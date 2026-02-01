package com.realestate.controller;

import java.io.IOException;

import com.realestate.enums.PropertyVerificationStatus;
import com.realestate.factory.PropertyServiceFactory;
import com.realestate.model.Property;
import com.realestate.model.PropertyImage;
import com.realestate.model.User;
import com.realestate.service.PropertyService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
@WebServlet("/property")  
public class PropertyServlet extends HttpServlet 
{

    private static final long serialVersionUID = 1L;
    private PropertyService propertyService;

    @Override
    public void init() {
        propertyService = PropertyServiceFactory.getServiceInstance();
    }

    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String city = request.getParameter("city");
        String type = request.getParameter("type");
        String purpose = request.getParameter("purpose");
        Integer bedroomsStr = parseInt(request.getParameter("bedrooms"));

        boolean isSearch =(city != null && !city.isEmpty()) ||
        	    		  (type != null && !type.isEmpty()) ||
        	              (purpose != null && !purpose.isEmpty()) ||
        	              (bedroomsStr != null );

        if (isSearch)
        {
        		
        	    request.setAttribute("properties",propertyService.searchApprovedProperties(city, type, purpose,bedroomsStr));
		}
         else 
        {
            //  only Show Approved Property by Admin
            request.setAttribute("properties",
                propertyService.getApprovedProperties()
            );
        }

        request.getRequestDispatcher("/property-list.jsp")
               .forward(request, response);
	}


	
	
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Property property = new Property();
            property.setUser(user);
            property.setTitle(request.getParameter("title"));
            property.setDescription(request.getParameter("description"));
            property.setPrice(parseDouble(request.getParameter("price")));
            property.setPropertyType(request.getParameter("type"));
            property.setPurpose(request.getParameter("purpose"));
            property.setPropetystatus(request.getParameter("status"));

            property.setBedrooms(parseInt(request.getParameter("bedrooms")));
            property.setBathrooms(parseInt(request.getParameter("bathrooms")));
            property.setAreaSqarefit(parseInt(request.getParameter("area")));

            property.setAddress(request.getParameter("street"));
            property.setCity(request.getParameter("city"));
            property.setState(request.getParameter("state"));
            property.setPincode(request.getParameter("zip"));

            property.setLatitude(request.getParameter("latitude"));
            property.setLongitude(request.getParameter("longitude"));

            property.setVerification(PropertyVerificationStatus.PENDING);
            property.setUser(user);


            // -------- IMAGE --------
            for (Part part : request.getParts()) {

                if ("images".equals(part.getName()) && part.getSize() > 0) {

                    byte[] imageBytes = part.getInputStream().readAllBytes();

                    PropertyImage image = new PropertyImage();
                    image.setImageData(imageBytes);

                    property.addImage(image);
                }
            }

            
            //  SAVE  Property Details
            propertyService.addProperty(property);
            
            //Success Message
            HttpSession successSession = request.getSession();
            successSession.setAttribute("successMessage", "Property added successfully");

            // Redirect
            response.sendRedirect("pages/user/add-property.jsp");

        } 
        catch (Exception e) 
        {
            e.printStackTrace();
            request.setAttribute("error", "Failed to save property");
            request.getRequestDispatcher("jsp/add-property.jsp").forward(request, response);
        }
        
       
    }

    private int parseInt(String value) {
        return (value == null || value.isEmpty()) ? 0 : Integer.parseInt(value);
    }

    private double parseDouble(String value) {
        return (value == null || value.isEmpty()) ? 0.0 : Double.parseDouble(value);
    }
}
