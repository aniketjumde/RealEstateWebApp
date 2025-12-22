package com.realestate.controller;

import java.io.IOException;

import com.realestate.enums.Role;
import com.realestate.factory.UserServiceFactory;
import com.realestate.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {
    
    private UserService userService=UserServiceFactory.getServiceInstance();
    
   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException 
    {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is authenticated and is ADMIN
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        String role = (String) session.getAttribute("userRole");
        if (!"ADMIN".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }
        
        String action = request.getPathInfo();
        
        if (action == null || action.equals("/users")) {
            request.setAttribute("users", userService.getAllUsers());
            request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
        } else if (action.equals("/edit-role")) {
            String email = request.getParameter("email");
            request.setAttribute("user", userService.getUserByEmail(email));
            request.getRequestDispatcher("/admin/edit-role.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        // Check if user is ADMIN
        if (session == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        
        String action = request.getPathInfo();
        
        if (action != null && action.equals("/update-role")) {
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            
            if (email != null && role != null) {
                userService.updateUserRole(email, Role.valueOf(role));
                response.sendRedirect(request.getContextPath() + "/admin/users");
            }
        }
    }
}