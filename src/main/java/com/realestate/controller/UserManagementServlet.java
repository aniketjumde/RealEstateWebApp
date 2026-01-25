package com.realestate.controller;

import java.io.IOException;
import java.util.List;

import com.realestate.factory.UserServiceFactory;
import com.realestate.model.User;
import com.realestate.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/admin/users")
public class UserManagementServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	private UserService userService;

    @Override
    public void init() 
    {
        userService = UserServiceFactory.getServiceInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
    {
    	List<User> users=userService.getAllUsers();
    	request.setAttribute("users", users);
    	request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
    }
	
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
