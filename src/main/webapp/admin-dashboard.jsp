<%@ page import="com.realestate.model.User" %>
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

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        
        .content-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        
        .card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: var(--card-shadow);
        }
        
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e2e8f0;
        }
        
        .card-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #1e293b;
        }
        
        .card-link {
            color: var(--primary-color);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .card-link:hover {
            text-decoration: underline;
        }
        
        .list-item {
            padding: 15px 0;
            border-bottom: 1px solid #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .list-item:last-child {
            border-bottom: none;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 1rem;
        }
        
        .user-details h4 {
            font-size: 0.95rem;
            color: #1e293b;
            margin-bottom: 2px;
        }
        
        .user-details p {
            font-size: 0.85rem;
            color: #64748b;
        }
        
        .user-role {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .user-role.admin {
            background-color: #dbeafe;
            color: var(--secondary-color);
        }
        
        .user-role.user {
            background-color: #dcfce7;
            color: var(--success-color);
        }
        
        .property-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .property-title {
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 5px;
        }
        
        .property-location {
            font-size: 0.85rem;
            color: #64748b;
        }
        
        .property-actions {
            display: flex;
            gap: 10px;
        }
        
        .btn {
            padding: 8px 16px;
            border-radius: 6px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            font-size: 0.85rem;
            transition: all 0.3s ease;
        }
        
        .btn-approve {
            background-color: var(--success-color);
            color: white;
        }
        
        .btn-approve:hover {
            background-color: #15803d;
        }
        
        .btn-reject {
            background-color: var(--danger-color);
            color: white;
        }
        
        .btn-reject:hover {
            background-color: #b91c1c;
        }
        
        .btn-view {
            background-color: #e2e8f0;
            color: #475569;
        }
        
        .btn-view:hover {
            background-color: #cbd5e1;
        }
        
        .no-data {
            text-align: center;
            padding: 40px 20px;
            color: #94a3b8;
        }
        
        .no-data i {
            font-size: 3rem;
            margin-bottom: 15px;
            opacity: 0.5;
        }
        
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 30px;
        }
        
        .action-btn {
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            color: #1e293b;
            display: block;
        }
        
        .action-btn:hover {
            border-color: var(--primary-color);
            background-color: #f0f9ff;
            transform: translateY(-3px);
        }
        
        .action-btn i {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 10px;
        }
        
        .action-btn span {
            display: block;
            font-weight: 600;
            font-size: 0.9rem;
        }
        
        /* Responsive Design */
        @media (max-width: 1024px) {
            .sidebar {
                width: 70px;
            }
            
            .sidebar-header h2,
            .nav-item span,
            .admin-badge {
                display: none;
            }
            
            .main-content {
                margin-left: 70px;
            }
            
            .nav-item {
                justify-content: center;
                padding: 15px;
            }
            
            .nav-item i {
                font-size: 1.3rem;
            }
        }
        
        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }
            
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            
            .stats-section,
            .content-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

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

        <!-- Statistics Cards -->
        <div class="stats-section">
            <div class="stat-card users">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <h3>Total Users</h3>
                <div class="stat-value"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "0" %></div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i> 12% from last month
                </div>
            </div>
            
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-home"></i>
                </div>
                <h3>Total Properties</h3>
                <div class="stat-value"><%= request.getAttribute("totalProperties") != null ? request.getAttribute("totalProperties") : "0" %></div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i> 8% from last month
                </div>
            </div>
            
            <div class="stat-card pending">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <h3>Pending Approval</h3>
                <div class="stat-value"><%= request.getAttribute("pendingProperties") != null ? request.getAttribute("pendingProperties") : "0" %></div>
                <div class="stat-change">
                    <i class="fas fa-exclamation-circle"></i> Requires attention
                </div>
            </div>
            
            <div class="stat-card approved">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h3>Approved Properties</h3>
                <div class="stat-value"><%= request.getAttribute("approvedProperties") != null ? request.getAttribute("approvedProperties") : "0" %></div>
                <div class="stat-change">
                    <i class="fas fa-arrow-up"></i> 15% from last month
                </div>
            </div>
            
            <div class="stat-card rejected">
                <div class="stat-icon">
                    <i class="fas fa-times-circle"></i>
                </div>
                <h3>Rejected Properties</h3>
                <div class="stat-value"><%= request.getAttribute("rejectedProperties") != null ? request.getAttribute("rejectedProperties") : "0" %></div>
                <div class="stat-change">
                    <i class="fas fa-arrow-down"></i> 5% from last month
                </div>
            </div>
        </div>

        <!-- Content Grid -->
        <div class="content-grid">
            <!-- Pending Properties -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Pending Properties</h3>
                    <a href="${pageContext.request.contextPath}/admin/pending-properties" class="card-link">
                        View All <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
                
                <% if (pendingPropertiesList != null && !pendingPropertiesList.isEmpty()) { %>
                    <% for (Property property : pendingPropertiesList) { %>
                    <div class="list-item">
                        <div class="property-info">
                            <div>
                                <div class="property-title"><%= property.getTitle() %></div>
                                <div class="property-location">
                                    <i class="fas fa-map-marker-alt"></i> 
                                    <%= property.getCity() != null ? property.getCity() : "N/A" %>
                                </div>
                            </div>
                        </div>
                        <div class="property-actions">

							    <!-- APPROVE FORM -->
							    <form action="<%= request.getContextPath() %>/admin/property-approval"
							          method="post" style="display:inline;">
							          
							        <input type="hidden" name="propertyId" value="<%= property.getId() %>">
							        <input type="hidden" name="action" value="APPROVE">
							
							        <button type="submit" class="btn btn-approve">
							            <i class="fas fa-check"></i>
							        </button>
							    </form>
							
							    <!-- REJECT FORM -->
							    <form action="<%= request.getContextPath() %>/admin/property-approval"
							          method="post" style="display:inline;">
							          
							        <input type="hidden" name="propertyId" value="<%= property.getId() %>">
							        <input type="hidden" name="action" value="REJECT">
							
							        <button type="submit" class="btn btn-reject">
							            <i class="fas fa-times"></i>
							        </button>
							    </form>
							
							    <!-- VIEW -->
							    <a href="property-details?id=<%= property.getId() %>" class="btn btn-view">
							        <i class="fas fa-eye"></i>
							    </a>

							</div>

                    </div>
                    <% } %>
                <% } else { %>
                    <div class="no-data">
                        <i class="fas fa-check-circle"></i>
                        <p>No pending properties</p>
                    </div>
                <% } %>
            </div>

            <!-- Recent Users -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Recent Users</h3>
                    <a href="${pageContext.request.contextPath}/admin/users" class="card-link">
                        View All <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
                
                <% if (recentUsers != null && !recentUsers.isEmpty()) { %>
                    <% for (User recentUser : recentUsers) { %>
                    <div class="list-item">
                        <div class="user-info">
                            <div class="user-avatar">
                                <%= recentUser.getName().substring(0, 1).toUpperCase() %>
                            </div>
                            <div class="user-details">
                                <h4><%= recentUser.getName() %></h4>
                                <p><%= recentUser.getEmail() %></p>
                            </div>
                        </div>
                        <div class="user-role <%= recentUser.getRole().name().equals("ADMIN") ? "admin" : "user" %>">
                            <%= recentUser.getRole().name() %>
                        </div>
                    </div>
                    <% } %>
                <% } else { %>
                    <div class="no-data">
                        <i class="fas fa-users"></i>
                        <p>No recent users</p>
                    </div>
                <% } %>
            </div>
        </div>

      
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        // Property Approval Functions
        function approveProperty(propertyId) {
            Swal.fire({
                title: 'Approve Property?',
                text: 'This property will be visible to all users.',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#16a34a',
                cancelButtonColor: '#6b7280',
                confirmButtonText: 'Yes, approve it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'admin/approve-property?id=' + propertyId;
                }
            });
        }
        
        function rejectProperty(propertyId) {
            Swal.fire({
                title: 'Reject Property?',
                text: 'This property will be marked as rejected.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc2626',
                cancelButtonColor: '#6b7280',
                confirmButtonText: 'Yes, reject it!',
                input: 'text',
                inputLabel: 'Reason for rejection (optional)',
                inputPlaceholder: 'Enter reason...'
            }).then((result) => {
                if (result.isConfirmed) {
                    const reason = result.value || '';
                    window.location.href = 'admin/reject-property?id=' + propertyId + '&reason=' + encodeURIComponent(reason);
                }
            });
        }
        
        // Quick stats update
        function updateStats() {
            fetch('admin/stats')
                .then(response => response.json())
                .then(data => {
                    // Update stats cards with new data
                    // This would require server-side implementation
                    console.log('Stats updated:', data);
                });
        }
        
        // Auto-refresh pending properties every 30 seconds
        setInterval(function() {
            const pendingCount = <%= request.getAttribute("pendingProperties") != null ? request.getAttribute("pendingProperties") : 0 %>;
            if (pendingCount > 0) {
                location.reload();
            }
        }, 30000);
    </script>
</body>
</html>