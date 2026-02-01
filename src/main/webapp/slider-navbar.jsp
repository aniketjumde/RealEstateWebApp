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
    List<User> recentUsers = (List<User>) request.getAttribute("recentUsers");
%>

 <!-- Sidebar Navigation -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>RealEstate</h2>
            <div class="admin-badge">Administrator</div>
        </div>
        
        <div class="nav-menu">
            <a href="#" class="nav-item active">
                <i class="fas fa-tachometer-alt"></i>
                <span>Dashboard</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-item">
                <i class="fas fa-users"></i>
                <span>Manage Users</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/properties" class="nav-item">
                <i class="fas fa-home"></i>
                <span>All Properties</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/property-approval" class="nav-item">
                <i class="fas fa-clock"></i>
                <span>Pending Approvals</span>
                <% if (pendingPropertiesList != null && pendingPropertiesList.size() > 0) { %>
                <span style="background: #f59e0b; color: white; padding: 2px 8px; border-radius: 10px; font-size: 0.8rem; margin-left: auto;">
                    <%= pendingPropertiesList.size() %>
                </span>
                <% } %>
            </a>
            
            <div class="nav-divider"></div>
            
            <a href="profile.jsp" class="nav-item">
                <i class="fas fa-cog"></i>
                <span>Profile Settings</span>
            </a>
            
            <form action="${pageContext.request.contextPath}/logout" method="post" style="margin-top: 20px;">
                <button type="submit" class="nav-item" style="width: 100%; background: none; border: none; cursor: pointer; text-align: left; font-size: 1rem;">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Logout</span>
                </button>
            </form>
        </div>
    </div>
