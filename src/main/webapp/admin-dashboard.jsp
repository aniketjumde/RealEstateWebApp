<%@ page import="com.realestate.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().name().equals("ADMIN")) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; }
        .logout-btn { padding: 8px 16px; background: #dc3545; color: white; border: none; border-radius: 4px; cursor: pointer; }
        .nav { margin: 20px 0; }
        .nav a { margin-right: 15px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Admin Dashboard</h1>
        <div>
            <span>Welcome, <%= user.getName() %> (Admin)</span>
            <form action="${pageContext.request.contextPath}/logout" method="post" style="display: inline; margin-left: 20px;">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </div>
    
    <div class="nav">
        <a href="${pageContext.request.contextPath}/admin/users">Manage Users</a>
        <!-- Add more admin links here -->
    </div>
    
    <div class="content">
        <h2>Administration Panel</h2>
        <p>Manage users, properties, and system settings from here.</p>
    </div>
    
    <a href="add-property.jsp">➕ Add Property</a>
        <a href="profile.jsp">Profile info</a>
</html>