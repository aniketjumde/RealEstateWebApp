<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().name().equals("ADMIN")) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
    
    List<Property> pendingPropertiesList = (List<Property>) request.getAttribute("pendingPropertiesList");
%>

    <!-- Sidebar Navigation -->
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo-icon">
                <i class="fas fa-building"></i>
            </div>
            <div>
                <h2>RealEstate </h2>
                <div class="admin-badge">Administrator</div>
            </div>
        </div>
        
        <div class="nav-menu">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item <%= request.getRequestURI().contains("dashboard") ? "active" : "" %>">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-item <%= request.getRequestURI().contains("users") ? "active" : "" %>">
                <i class="fas fa-users"></i>
                <span>Manage Users</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/properties" class="nav-item <%= request.getRequestURI().contains("properties") ? "active" : "" %>">
                <i class="fas fa-home"></i>
                <span>All Properties</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/property-approval" class="nav-item <%= request.getRequestURI().contains("approval") ? "active" : "" %>">
                <i class="fas fa-clock"></i>
                <span>Pending Approvals</span>
                <% if (pendingPropertiesList != null && pendingPropertiesList.size() > 0) { %>
                <span class="badge"><%= pendingPropertiesList.size() %></span>
                <% } %>
            </a>
            
            <div class="nav-divider"></div>
            
            <a href="${pageContext.request.contextPath}/admin-profile.jsp" class="nav-item <%= request.getRequestURI().contains("profile") ? "active" : "" %>">
                <i class="fas fa-user-cog"></i>
                <span>Profile Settings</span>
            </a>
            
            <form action="${pageContext.request.contextPath}/logout" method="post" class="nav-item" style="margin-top: 20px;">
                <button type="submit" style="background: none; border: none; color: inherit; font: inherit; cursor: pointer; display: flex; align-items: center; width: 100%;">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </button>
            </form>
        </div>
    </div>
