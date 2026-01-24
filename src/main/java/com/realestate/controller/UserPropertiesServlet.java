package com.realestate.controller;

import java.io.IOException;
import java.util.List;

import com.realestate.factory.PropertyServiceFactory;
import com.realestate.model.Property;
import com.realestate.model.User;
import com.realestate.service.PropertyService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class UserPropertiesServlet
 */
@WebServlet("/user-properties")
public class UserPropertiesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private PropertyService propertyService;

    @Override
    public void init() {
        propertyService = PropertyServiceFactory.getServiceInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Property> properties =propertyService.getPropertiesByUser(user);

        request.setAttribute("properties", properties);

        request.getRequestDispatcher("/user-properties.jsp")
               .forward(request, response);
    }
}
