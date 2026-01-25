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
        
		 body{
		    font-family: Arial;
		    background:#f4f6f8;
		}
		.dashboard{
		    display:grid;
		    grid-template-columns:repeat(3,1fr);
		    gap:20px;
		    padding:30px;
		}
		.card{
		    background:#fff;
		    padding:25px;
		    border-radius:12px;
		    box-shadow:0 4px 15px rgba(0,0,0,0.1);
		}
		.card h3{
		    margin:0;
		    font-size:18px;
		    color:#555;
		}
		.card p{
		    font-size:32px;
		    font-weight:bold;
		    margin-top:10px;
		}
		.pending{color:#f59e0b;}
		.approved{color:#16a34a;}
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
    
    <div class="dashboard">

	    <div class="card">
	        <h3>Total Users</h3>
	        <p><%= request.getAttribute("totalUsers") %></p>
	    </div>
	
	    <div class="card">
	        <h3>Total Properties</h3>
	        <p><%= request.getAttribute("totalProperties") %></p>
	    </div>
	
	    <div class="card pending">
	        <h3>Pending Properties</h3>
	        <p><%= request.getAttribute("pendingProperties") %></p>
	    </div>
	
	    <div class="card approved">
	        <h3>Approved Properties</h3>
	        <p><%= request.getAttribute("approvedProperties") %></p>
	    </div>
	
	    <div class="card rejected">
	        <h3>Rejected Properties</h3>
	        <p><%= request.getAttribute("rejectedProperties") %></p>
	    </div>

	</div>
    
    <a href="add-property.jsp">➕ Add Property</a>
        <a href="profile.jsp">Profile info</a>
</html>