package com.realestate.controller;

import java.io.IOException;

import com.realestate.enums.Role;
import com.realestate.factory.UserServiceFactory;
import com.realestate.service.UserService;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;



@WebServlet("/admin/admin-user-role")
public class AdminUserRoleServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	private UserService userService;
	
	public void init(ServletConfig config) throws ServletException
	{
		userService=UserServiceFactory.getServiceInstance();
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		  Long userId = Long.parseLong(request.getParameter("userId"));
		  Role newRole = Role.valueOf(request.getParameter("role"));
	      userService.updateRole(userId, newRole);

	      response.sendRedirect(request.getContextPath() + "/admin/users");
   }

}
