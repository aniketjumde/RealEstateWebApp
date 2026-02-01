<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.model.User" %>



<%	
    User admin = (User) session.getAttribute("user");
    if (admin == null || admin.getRole() == null || 
        !admin.getRole().name().equals("ADMIN")) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }

    List<Property> properties =
        (List<Property>) request.getAttribute("properties");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin | All Properties</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
      :root {
            --primary-color: #0f766e;
            --primary-dark: #115e59;
            --secondary-color: #2563eb;
            --danger-color: #dc2626;
            --warning-color: #f59e0b;
            --success-color: #16a34a;
            --light-bg: #f8fafc;
            --card-shadow: 0 4px 20px rgba(0,0,0,0.08);
            --sidebar-width: 250px;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-bg);
            display: flex;
            min-height: 100vh;
        }
        
        /* Sidebar Styles */
        .sidebar {
            width: var(--sidebar-width);
            background: white;
            box-shadow: 2px 0 15px rgba(0,0,0,0.05);
            position: fixed;
            height: 100vh;
            left: 0;
            top: 0;
            z-index: 1000;
        }
        
        .sidebar-header {
            padding: 25px 20px;
            background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
            color: white;
            text-align: center;
        }
        
        .sidebar-header h2 {
            font-size: 1.5rem;
            margin-bottom: 5px;
        }
        
        .sidebar-header .admin-badge {
            display: inline-block;
            background: rgba(255,255,255,0.2);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            margin-top: 5px;
        }
        
        .nav-menu {
            padding: 20px 0;
        }
        
        .nav-item {
            padding: 15px 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            color: #475569;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }
        
        .nav-item:hover {
            background-color: #f1f5f9;
            color: var(--primary-color);
            border-left-color: var(--primary-color);
        }
        
        .nav-item.active {
            background-color: #f0f9ff;
            color: var(--primary-color);
            border-left-color: var(--primary-color);
            font-weight: 600;
        }
        
        .nav-item i {
            width: 20px;
            text-align: center;
            font-size: 1.1rem;
        }
        
        .nav-divider {
            margin: 20px;
            border-top: 1px solid #e2e8f0;
        }
        
        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: var(--sidebar-width);
            padding: 30px;
        }
        
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .welcome-section h1 {
            color: #1e293b;
            font-size: 2rem;
            margin-bottom: 5px;
        }
        
        .welcome-section p {
            color: #64748b;
            font-size: 0.95rem;
        }
        
        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-top: 4px solid var(--primary-color);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }
        
        .stat-card.pending {
            border-top-color: var(--warning-color);
        }
        
        .stat-card.approved {
            border-top-color: var(--success-color);
        }
        
        .stat-card.rejected {
            border-top-color: var(--danger-color);
        }
        
        .stat-card.users {
            border-top-color: var(--secondary-color);
        }
        
        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            opacity: 0.8;
        }
        
        .stat-card .stat-icon {
            color: var(--primary-color);
        }
        
        .stat-card.pending .stat-icon {
            color: var(--warning-color);
        }
        
        .stat-card.approved .stat-icon {
            color: var(--success-color);
        }
        
        .stat-card.rejected .stat-icon {
            color: var(--danger-color);
        }
        
        .stat-card.users .stat-icon {
            color: var(--secondary-color);
        }
        
        .stat-card h3 {
            font-size: 0.9rem;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 10px;
        }
        
        .stat-value {
            font-size: 2.2rem;
            font-weight: 800;
            color: #1e293b;
            line-height: 1;
        }
        
        .stat-change {
            font-size: 0.85rem;
            color: #16a34a;
            margin-top: 10px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
body {
    background: #f8fafc;
}

.page-title {
    font-weight: 700;
}

.property-img {
    width: 80px;
    height: 60px;
    object-fit: cover;
    border-radius: 6px;
    background: #e5e7eb;
}

.badge-status {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
}

.badge-PENDING { background:#fde68a; color:#92400e; }
.badge-APPROVED { background:#bbf7d0; color:#166534; }
.badge-REJECTED { background:#fecaca; color:#991b1b; }

.action-btn {
    padding: 5px 10px;
    font-size: 13px;
}
</style>
</head>

<body>


    <%@ include file="/slider-navbar.jsp" %>
    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Bar -->
        <div class="top-bar">
            <div class="welcome-section">
                <h1>Welcome, <%= user.getName() %> 👋</h1>
                <p>Here's what's happening with your platform today.</p>
            </div>
            <div class="date-info">
                <span style="color: #64748b; font-size: 0.9rem;">
                    <i class="fas fa-calendar-alt"></i> <%= new java.text.SimpleDateFormat("EEEE, MMMM dd, yyyy").format(new java.util.Date()) %>
                </span>
            </div>
        </div>
    

    <!-- TABLE -->
    <div class="card shadow-sm">
        <div class="card-body p-0">

            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Image</th>
                        <th>Title</th>
                        <th>Owner</th>
                        <th>City</th>
                        <th>Price</th>
                        <th>Purpose</th>
                        <th>Status</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>

                <tbody>
                <% if (properties != null && !properties.isEmpty()) { %>

                    <% for (Property p : properties) { %>
                    <tr>

                        <!-- IMAGE -->
                        <td>
                            <% if (p.getImages() != null && !p.getImages().isEmpty()) { %>
                                <img src="<%= "${pageContext.request.contextPath}" %>/property-image?id=<%= p.getImages().get(0).getImageId() %>"
                                     class="property-img">
                            <% } else { %>
                                <div class="property-img d-flex align-items-center justify-content-center">
                                    <i class="fas fa-house text-muted"></i>
                                </div>
                            <% } %>
                        </td>

                        <!-- TITLE -->
                        <td>
                            <b><%= p.getTitle() %></b><br>
                            <small class="text-muted">ID: <%= p.getId() %></small>
                        </td>

                        <!-- OWNER -->
                        <td>
                            <%= p.getUser() != null ? p.getUser().getName() : "N/A" %><br>
                            <small class="text-muted">
                                <%= p.getUser() != null ? p.getUser().getEmail() : "" %>
                            </small>
                        </td>

                        <!-- CITY -->
                        <td><%= p.getCity() != null ? p.getCity() : "N/A" %></td>

                        <!-- PRICE -->
                        <td>₹ <%= p.getPrice() %></td>

                        <!-- PURPOSE -->
                        <td>
                            <span class="badge bg-info">
                                <%= p.getPurpose() %>
                            </span>
                        </td>

                        <!-- STATUS -->
                        <td>
                            <span class="badge-status badge-<%= p.getVerification().name() %>">
                                <%= p.getVerification().name() %>
                            </span>
                        </td>

                        <!-- ACTIONS -->
                        <td class="text-center">

                            <a href="<%= "${pageContext.request.contextPath}" %>/property-details?id=<%= p.getId() %>"
                               class="btn btn-outline-primary action-btn">
                                <i class="fas fa-eye"></i>
                            </a>

                            <% if ("PENDING".equals(p.getVerification().name())) { %>

                                <a href="<%= "${pageContext.request.contextPath}" %>/admin/approve-property?id=<%= p.getId() %>"
                                   class="btn btn-outline-success action-btn"
                                   onclick="return confirm('Approve this property?')">
                                   <i class="fas fa-check"></i>
                                </a>

                                <a href="<%= "${pageContext.request.contextPath}" %>/admin/reject-property?id=<%= p.getId() %>"
                                   class="btn btn-outline-danger action-btn"
                                   onclick="return confirm('Reject this property?')">
                                   <i class="fas fa-times"></i>
                                </a>

                            <% } %>

                        </td>
                    </tr>
                    <% } %>

                <% } else { %>
                    <tr>
                        <td colspan="8" class="text-center py-4 text-muted">
                            No properties found
                        </td>
                    </tr>
                <% } %>
                </tbody>

            </table>

        </div>
    </div>

</div>

</body>
</html>
