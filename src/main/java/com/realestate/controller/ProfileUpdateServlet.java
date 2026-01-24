package com.realestate.controller;

import java.io.IOException;

import com.realestate.factory.UserServiceFactory;
import com.realestate.model.User;
import com.realestate.service.UserService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/profile-update")
public class ProfileUpdateServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

    private UserService userService;

	
	public void init(ServletConfig config) throws ServletException 
	{
        userService = UserServiceFactory.getServiceInstance();
	}
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		 HttpSession session = request.getSession(false);
	        User user = (User) session.getAttribute("user");

	        if (user == null) {
	            response.sendRedirect("login.jsp");
	            return;
	        }

	        user.setName(request.getParameter("name"));

	        userService.updateUser(user);

	        session.setAttribute("user", user);

	        session.setAttribute("profileSuccess",
	                "Profile updated successfully");

	        
	        response.sendRedirect("profile.jsp");
	}

}
