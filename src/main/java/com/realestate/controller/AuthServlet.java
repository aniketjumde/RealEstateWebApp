package com.realestate.controller;

import java.io.IOException;

import com.realestate.model.User;
import com.realestate.service.FirebaseAuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/auth/google")
public class AuthServlet extends HttpServlet {
    
    private FirebaseAuthService authService;
    
    @Override
    public void init() throws ServletException {
        super.init();
        authService = new FirebaseAuthService();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException 
    {
        
        String idToken = request.getParameter("idToken");
        
        if (idToken == null || idToken.trim().isEmpty()) 
        {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"ID token is required\"}");
            return;
        }
        
        try 
        {
            User user = authService.authenticateWithGoogle(idToken);
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userRole", user.getRole().name());
            
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true, \"role\": \"" + user.getRole() + "\"}");
            
        } 
        catch (Exception e) 
        {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Authentication failed: " + e.getMessage() + "\"}");
        }
    }
}