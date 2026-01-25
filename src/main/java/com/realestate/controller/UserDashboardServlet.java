package com.realestate.controller;

import java.io.IOException;

import com.realestate.factory.PropertyServiceFactory;
import com.realestate.model.User;
import com.realestate.service.PropertyService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet
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
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) 
        {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
		
        Long userId=user.getId();
        
     // Dashboard data
        request.setAttribute("totalProperties",propertyService.getTotalPropertiesByUser(userId));

        request.setAttribute("approvedCount",propertyService.getApprovedPropertiesByUser(userId));

        request.setAttribute("pendingCount",propertyService.getPendingPropertiesByUser(userId));

        request.setAttribute("rejectedCount",propertyService.getRejectedPropertiesByUser(userId));

        
        request.getRequestDispatcher("/user-dashboard.jsp")
               .forward(request, response);	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

		doGet(request, response);
	}

}
