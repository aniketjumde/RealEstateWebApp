package com.realestate.controller;

import java.io.IOException;

import com.realestate.enums.Role;
import com.realestate.factory.UserServiceFactory;
import com.realestate.model.User;
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

    private UserService userService;

    @Override
    public void init() throws ServletException 
    {
        userService = UserServiceFactory.getServiceInstance();
    }

    @Override
    protected void doPost(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
    {

        User loggedUser = (User) request.getSession().getAttribute("user");

        //  Security Check
        if (loggedUser == null || loggedUser.getRole() != Role.ADMIN) 
        {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {

            Long userId = Long.parseLong(request.getParameter("userId"));
            Role newRole = Role.valueOf(request.getParameter("role").toUpperCase());

            User targetUser = userService.findById(userId);

            if (targetUser == null) 
            {
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            //  Prevent admin from changing his own role
            if (loggedUser.getId().equals(targetUser.getId())) 
            {
                request.getSession().setAttribute("errorMessage","You cannot change your own role.");
                response.sendRedirect(request.getContextPath() + "/admin/users");
                return;
            }

            userService.updateRole(targetUser, newRole);

            request.getSession().setAttribute("successMessage","User role updated successfully.");

        } 
        catch (Exception e) 
        {
            request.getSession().setAttribute("errorMessage",
                    "Invalid request.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
