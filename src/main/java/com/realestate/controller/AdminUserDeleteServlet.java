package com.realestate.controller;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.realestate.factory.UserServiceFactory;
import com.realestate.service.UserService;


@WebServlet("/admin/admin-user-delete")
public class AdminUserDeleteServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    

	private UserService userService;
	
	public void init(ServletConfig config) throws ServletException
	{
		userService=UserServiceFactory.getServiceInstance();
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws IOException 
	{

        Long userId = Long.parseLong(request.getParameter("userId"));

        userService.deleteUser(userId);

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

}
