<%@ page import="com.realestate.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; }
        .user-info { display: flex; align-items: center; }
        .profile-pic { width: 40px; height: 40px; border-radius: 50%; margin-right: 10px; }
        .logout-btn { padding: 8px 16px; background: #dc3545; color: white; border: none; border-radius: 4px; cursor: pointer; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Welcome, <%= user.getName() %>!</h1>
        <div class="user-info">
            <% if (user.getProfilePicture() != null) { %>
                <img src="<%= user.getProfilePicture() %>" alt="Profile" class="profile-pic">
            <% } %>
            <span><%= user.getEmail() %> (User)</span>
            <form action="${pageContext.request.contextPath}/logout" method="post" style="margin-left: 20px;">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
        </div>
    </div>
    
    <div class="content">
        <h2>User Dashboard</h2>
        <p>This is your user dashboard. You can view properties, manage your listings, etc.</p>
        <!-- Add user-specific content here -->
    </div>
</body>
</html>