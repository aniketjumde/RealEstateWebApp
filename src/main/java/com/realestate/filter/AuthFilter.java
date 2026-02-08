package com.realestate.filter;

import java.io.IOException;

import com.realestate.model.User;
import com.realestate.enums.Role;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)throws IOException, ServletException 
    {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI()
                             .substring(request.getContextPath().length());

        // PUBLIC RESOURCES
        if (path.equals("/") ||
        	    path.equals("/index") ||
        	    path.startsWith("/login.jsp") ||
        	    path.startsWith("/register.jsp") ||
        	    path.startsWith("/auth/") ||
        	    path.startsWith("/css/") ||
        	    path.startsWith("/js/") ||
        	    path.startsWith("/images/") ||
        	    path.startsWith("/about.jsp") ||   
        	    path.startsWith("/property") ||   
        	    path.startsWith("/property-list") ||
        	    path.startsWith("/property-details") ||
        	    path.startsWith("/property-image")) {

        	    chain.doFilter(request, response);
        	    return;
        	}


        //  LOGIN CHECK
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) 
        {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // ADMIN-ONLY AREA
        if (path.startsWith("/admin")) 
        {
            if(user.getRole() != Role.ADMIN) 
            {
                response.sendRedirect(request.getContextPath() + "/access-denied.jsp");
                return;
            }
        }
        
        if (path.startsWith("/admin/")) 
        {
            User user1 = (User) session.getAttribute("user");

            if (user1 == null || user1.getRole() != Role.ADMIN) 
            {
                response.sendRedirect(request.getContextPath() + "/dashboard");
                return;
            }
        }

        // ALLOW REQUEST
        chain.doFilter(req, res);
    }

    @Override
    public void init(FilterConfig filterConfig) {}
    @Override
    public void destroy() {}
}
