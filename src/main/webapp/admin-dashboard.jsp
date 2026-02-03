<%@ page import="com.realestate.model.User" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - RealEstate Pro</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .welcome-section {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 30px;
            border-radius: var(--border-radius);
            margin-bottom: 30px;
            box-shadow: var(--shadow-lg);
        }
        
        .welcome-content h1 {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        .welcome-content p {
            opacity: 0.9;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>
    <%@ include file="/slider-navbar.jsp" %>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="header">
            <div class="header-left">
                <h1><i class="fas fa-building"></i> Dashboard</h1>
                <p>RealEstate Administration Panel</p>
            </div>
            <div class="header-right">
                <div class="date-display">
                    <i class="fas fa-calendar-alt"></i>
                    <%= new java.text.SimpleDateFormat("EEEE, MMMM dd, yyyy").format(new java.util.Date()) %>
                </div>
                <div class="user-profile">
                    <div class="user-avatar">
                        <%= user.getName().substring(0, 1).toUpperCase() %>
                    </div>
                    <div class="user-info">
                        <strong><%= user.getName() %></strong>
                        <small>Administrator</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Content Wrapper -->
        <div class="content-wrapper fade-in">
            <!-- Welcome Section -->
            <div class="welcome-section">
                <div class="welcome-content">
                    <h1>Welcome back, <%= user.getName() %>!	</h1>
                    <p>Here's what's happening with your real estate platform today.</p>
                </div>
            </div>

            <!-- Statistics Grid -->
            <div class="stats-grid">
                <div class="stat-card users">
                    <div class="stat-header">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-change positive">
                            <i class="fas fa-arrow-up"></i> 12%
                        </div>
                    </div>
                    <div class="stat-value"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "0" %></div>
                    <div class="stat-label">Total Users</div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <div class="stat-change positive">
                            <i class="fas fa-arrow-up"></i> 8%
                        </div>
                    </div>
                    <div class="stat-value"><%= request.getAttribute("totalProperties") != null ? request.getAttribute("totalProperties") : "0" %></div>
                    <div class="stat-label">Total Properties</div>
                </div>
                
                <div class="stat-card pending">
                    <div class="stat-header">
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-change neutral">
                            <i class="fas fa-exclamation-circle"></i> Review
                        </div>
                    </div>
                    <div class="stat-value"><%= request.getAttribute("pendingProperties") != null ? request.getAttribute("pendingProperties") : "0" %></div>
                    <div class="stat-label">Pending Approval</div>
                </div>
                
                <div class="stat-card approved">
                    <div class="stat-header">
                        <div class="stat-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-change positive">
                            <i class="fas fa-arrow-up"></i> 15%
                        </div>
                    </div>
                    <div class="stat-value"><%= request.getAttribute("approvedProperties") != null ? request.getAttribute("approvedProperties") : "0" %></div>
                    <div class="stat-label">Approved Properties</div>
                </div>
            </div>

            <!-- Dashboard Grid -->
            <div class="dashboard-grid">
                <!-- Pending Properties Card -->
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">
                            <i class="fas fa-clock"></i>
                            Pending Properties
                        </div>
                        <div class="card-actions">
                            <a href="${pageContext.request.contextPath}/admin/pending-properties" class="view-all">
                                View All <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <% if (pendingPropertiesList != null && !pendingPropertiesList.isEmpty()) { %>
                            <% for (Property property : pendingPropertiesList) { %>
                            <div class="list-item">
                                <div class="item-info">
                                    <div class="item-avatar">
                                        <i class="fas fa-home"></i>
                                    </div>
                                    <div class="item-details">
                                        <div class="item-title"><%= property.getTitle() %></div>
                                        <div class="item-subtitle">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <%= property.getCity() != null ? property.getCity() : "N/A" %>
                                        </div>
                                    </div>
                                </div>
                                <div class="item-meta">
                                    <span class="item-status status-pending">Pending</span>
                                    <div class="item-actions">
                                        <!-- APPROVE FORM -->
                                        <form action="<%= request.getContextPath() %>/admin/property-approval" method="post" style="display:inline;">
                                            <input type="hidden" name="propertyId" value="<%= property.getId() %>">
                                            <input type="hidden" name="action" value="APPROVE">
                                            <button type="submit" class="action-btn btn-approve" title="Approve">
                                                <i class="fas fa-check"></i>
                                            </button>
                                        </form>
                                        
                                        <!-- REJECT FORM -->
                                        <form action="<%= request.getContextPath() %>/admin/property-approval" method="post" style="display:inline;">
                                            <input type="hidden" name="propertyId" value="<%= property.getId() %>">
                                            <input type="hidden" name="action" value="REJECT">
                                            <button type="submit" class="action-btn btn-reject" title="Reject">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </form>
                                        
                                        <!-- VIEW -->
                                        <a href="${pageContext.request.contextPath}/property-details?id=<%= property.getId() %>" class="action-btn btn-view" title="View Details">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <% } %>
                        <% } else { %>
                            <div class="empty-state">
                                <i class="fas fa-check-circle"></i>
                                <h4>No Pending Properties</h4>
                                <p>All properties have been reviewed and approved.</p>
                            </div>
                        <% } %>
                    </div>
                </div>

                <!-- Recent Users Card -->
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">
                            <i class="fas fa-users"></i>
                            Recent Users
                        </div>
                        <div class="card-actions">
                            <a href="${pageContext.request.contextPath}/admin/users" class="view-all">
                                View All <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <% if (recentUsers != null && !recentUsers.isEmpty()) { %>
                            <% for (User recentUser : recentUsers) { %>
                            <div class="list-item">
                                <div class="item-info">
                                    <div class="user-avatar-small">
                                        <%= recentUser.getName().substring(0, 1).toUpperCase() %>
                                    </div>
                                    <div class="item-details">
                                        <div class="item-title"><%= recentUser.getName() %></div>
                                        <div class="item-subtitle">
                                            <i class="fas fa-envelope"></i>
                                            <%= recentUser.getEmail() %>
                                        </div>
                                    </div>
                                </div>
                                <div class="item-meta">
                                    <span class="item-role <%= recentUser.getRole().name().equals("ADMIN") ? "admin" : "" %>">
                                        <%= recentUser.getRole().name() %>
                                    </span>
                                </div>
                            </div>
                            <% } %>
                        <% } else { %>
                            <div class="empty-state">
                                <i class="fas fa-users"></i>
                                <h4>No Recent Users</h4>
                                <p>No users have registered recently.</p>
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>

          
    <script>
        // Auto-refresh every 30 seconds if there are pending properties
        setInterval(function() {
            const pendingCount = <%= request.getAttribute("pendingProperties") != null ? request.getAttribute("pendingProperties") : 0 %>;
            if (pendingCount > 0) {
                Swal.fire({
                    title: 'Updates Available',
                    text: 'There are pending properties that need review.',
                    icon: 'info',
                    timer: 2000,
                    showConfirmButton: false
                }).then(() => {
                    location.reload();
                });
            }
        }, 30000);
        
        // Welcome notification
        document.addEventListener('DOMContentLoaded', function() {
            const welcomeMessage = "Welcome back, <%= user.getName() %>! You have <%= request.getAttribute("pendingProperties") != null ? request.getAttribute("pendingProperties") : "0" %> properties pending review.";
            console.log(welcomeMessage);
        });
    </script>
    
</body>
</html>