package com.realestate.controller;

import java.io.IOException;

import com.realestate.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String role = user.getRole().name();
        
        if (role.equals("ADMIN")) {
            request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/user-dashboard.jsp").forward(request, response);
        }
    }
}