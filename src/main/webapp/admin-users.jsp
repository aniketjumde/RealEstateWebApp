<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.enums.Role" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().name().equals("ADMIN")) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
    
    List<Property> pendingPropertiesList = (List<Property>) request.getAttribute("pendingPropertiesList");
    List<User> users = (List<User>) request.getAttribute("users");
%>

<!DOCTYPE html>
<html>
<head>
<title>User Management | RealEstate Admin</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
    
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }
    
    .page-title {
        font-size: 1.8rem;
        color: #1e293b;
        font-weight: 700;
    }
    
    .page-subtitle {
        color: #64748b;
        margin-bottom: 30px;
    }
    
    .user-count {
        background: var(--primary-color);
        color: white;
        padding: 5px 15px;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.9rem;
    }
    
    .search-box {
        display: flex;
        gap: 10px;
        margin-bottom: 30px;
    }
    
    .search-input {
        flex: 1;
        padding: 12px 20px;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        font-size: 1rem;
        transition: all 0.3s ease;
    }
    
    .search-input:focus {
        outline: none;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.1);
    }
    
    .search-btn {
        background: var(--primary-color);
        color: white;
        border: none;
        padding: 0 25px;
        border-radius: 8px;
        cursor: pointer;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .search-btn:hover {
        background: var(--primary-dark);
    }
    
    /* User Table Styles */
    .users-table-container {
        background: white;
        border-radius: 12px;
        box-shadow: var(--card-shadow);
        overflow: hidden;
        margin-bottom: 30px;
    }
    
    .table-header {
        padding: 25px;
        border-bottom: 1px solid #e2e8f0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .table-header h3 {
        font-size: 1.3rem;
        color: #1e293b;
    }
    
    .table-actions {
        display: flex;
        gap: 10px;
    }
    
    .btn-export {
        background: #f1f5f9;
        color: #475569;
        border: none;
        padding: 10px 20px;
        border-radius: 6px;
        font-weight: 600;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
    }
    
    .btn-export:hover {
        background: #e2e8f0;
    }
    
    .table-responsive {
        overflow-x: auto;
    }
    
    .users-table {
        width: 100%;
        border-collapse: collapse;
    }
    
    .users-table thead {
        background: #f8fafc;
    }
    
    .users-table th {
        padding: 18px 20px;
        text-align: left;
        color: #475569;
        font-weight: 600;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border-bottom: 1px solid #e2e8f0;
    }
    
    .users-table tbody tr {
        border-bottom: 1px solid #f1f5f9;
        transition: background-color 0.2s ease;
    }
    
    .users-table tbody tr:hover {
        background-color: #f8fafc;
    }
    
    .users-table td {
        padding: 20px;
        color: #475569;
    }
    
    .user-cell {
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .user-avatar {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        font-size: 1.1rem;
        flex-shrink: 0;
    }
    
    .user-info h4 {
        font-size: 1rem;
        color: #1e293b;
        margin-bottom: 3px;
    }
    
    .user-info p {
        font-size: 0.85rem;
        color: #64748b;
    }
    
    .role-badge {
        display: inline-block;
        padding: 6px 15px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        text-align: center;
        min-width: 80px;
    }
    
    .role-admin {
        background-color: #dbeafe;
        color: var(--secondary-color);
    }
    
    .role-user {
        background-color: #dcfce7;
        color: var(--success-color);
    }
    
    .role-select {
        padding: 8px 15px;
        border: 1px solid #e2e8f0;
        border-radius: 6px;
        font-size: 0.9rem;
        background: white;
        min-width: 120px;
        cursor: pointer;
    }
    
    .role-select:focus {
        outline: none;
        border-color: var(--primary-color);
    }
    
    .action-buttons {
        display: flex;
        gap: 8px;
    }
    
    .btn {
        padding: 8px 16px;
        border-radius: 6px;
        border: none;
        font-weight: 600;
        cursor: pointer;
        font-size: 0.85rem;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    
    .btn-update {
        background-color: var(--primary-color);
        color: white;
    }
    
    .btn-update:hover {
        background-color: var(--primary-dark);
    }
    
    .btn-delete {
        background-color: #fee2e2;
        color: var(--danger-color);
    }
    
    .btn-delete:hover {
        background-color: var(--danger-color);
        color: white;
    }
    
    .btn-delete:disabled {
        background-color: #f1f5f9;
        color: #94a3b8;
        cursor: not-allowed;
    }
    
    .btn-impersonate {
        background-color: #f0f9ff;
        color: var(--secondary-color);
        border: 1px solid #bae6fd;
    }
    
    .btn-impersonate:hover {
        background-color: var(--secondary-color);
        color: white;
    }
    
    .user-status {
        display: inline-block;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 600;
    }
    
    .status-active {
        background-color: #dcfce7;
        color: var(--success-color);
    }
    
    .status-inactive {
        background-color: #f1f5f9;
        color: #64748b;
    }
    
    .registration-date {
        font-size: 0.85rem;
        color: #64748b;
    }
    
    .no-users {
        text-align: center;
        padding: 60px 20px;
        color: #94a3b8;
    }
    
    .no-users i {
        font-size: 3rem;
        margin-bottom: 15px;
        opacity: 0.5;
    }
    
    .pagination {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-top: 30px;
    }
    
    .page-btn {
        padding: 8px 15px;
        border: 1px solid #e2e8f0;
        background: white;
        border-radius: 6px;
        cursor: pointer;
        color: #475569;
        font-weight: 600;
    }
    
    .page-btn.active {
        background: var(--primary-color);
        color: white;
        border-color: var(--primary-color);
    }
    
    .page-btn:hover:not(.active) {
        background: #f1f5f9;
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
        
        .top-bar,
        .page-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 15px;
        }
        
        .search-box {
            flex-direction: column;
        }
        
        .users-table {
            font-size: 0.9rem;
        }
        
        .action-buttons {
            flex-direction: column;
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

        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h2 class="page-title">All Users</h2>
                <p class="page-subtitle">Manage user roles, permissions, and access</p>
            </div>
            <div class="table-actions">
                <button class="btn-export" onclick="exportUsers()">
                    <i class="fas fa-download"></i> Export CSV
                </button>
            </div>
        </div>

        <!-- Search Box -->
        <div class="search-box">
            <input type="text" id="userSearch" class="search-input" placeholder="Search users by name, email, or role..." onkeyup="filterUsers()">
            <button class="search-btn" onclick="filterUsers()">
                <i class="fas fa-search"></i> Search
            </button>
        </div>

        <!-- Success Message Display -->
        <%
            String successMessage = (String) session.getAttribute("successMessage");
            if (successMessage != null) {
        %>
        <div style="background: #dcfce7; color: #166534; padding: 15px; border-radius: 8px; margin-bottom: 20px; border: 1px solid #bbf7d0;">
            <i class="fas fa-check-circle"></i> <%= successMessage %>
        </div>
        <%
            session.removeAttribute("successMessage");
        }
        %>

        <!-- Users Table -->
        <div class="users-table-container">
            <div class="table-header">
                <h3>Registered Users (<%= users != null ? users.size() : 0 %> total)</h3>
                <div>
                    <select id="roleFilter" class="role-select" onchange="filterUsers()">
                        <option value="">All Roles</option>
                        <option value="ADMIN">Admin</option>
                        <option value="USER">User</option>
                    </select>
                </div>
            </div>
            
            <% if (users != null && !users.isEmpty()) { %>
            <div class="table-responsive">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Role</th>
                            <th>Status</th>
                            <th>Registration Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            User loggedAdmin = (User) session.getAttribute("user");
                            for(User u : users){ 
                        %>
                        <tr class="user-row">
                            <td>
                                <div class="user-cell">
                                    <div class="user-avatar">
                                        <%= u.getName().substring(0, 1).toUpperCase() %>
                                    </div>
                                    <div class="user-info">
                                        <h4><%= u.getName() %></h4>
                                        <p><%= u.getEmail() %></p>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <form action="<%= request.getContextPath() %>/admin/admin-user-role"
                                      method="post"
                                      class="role-form"
                                      onsubmit="return confirmRoleChange('<%= u.getName() %>', this);">
                                    <input type="hidden" name="userId" value="<%= u.getId() %>">
                                    <select name="role" class="role-select" data-user-id="<%= u.getId() %>">
                                        <option value="USER" <%= u.getRole()==Role.USER ? "selected" : "" %>>USER</option>
                                        <option value="ADMIN" <%= u.getRole()==Role.ADMIN ? "selected" : "" %>>ADMIN</option>
                                    </select>
                                    <button type="submit" class="btn btn-update" style="margin-top: 5px;">
                                        <i class="fas fa-sync-alt"></i> Update
                                    </button>
                                </form>
                            </td>
                            <td>
                                <span class="user-status status-active">
                                    <i class="fas fa-circle"></i> Active
                                </span>
                            </td>
                           
                            <td>
                                <div class="action-buttons">
                                    <% if(!u.getId().equals(loggedAdmin.getId())) { %>
                                        <button class="btn btn-impersonate" onclick="impersonateUser('<%= u.getId() %>', '<%= u.getName() %>')">
                                            <i class="fas fa-user-secret"></i> Impersonate
                                        </button>
                                        
                                        <button class="btn btn-delete" 
                                                onclick="deleteUser('<%= u.getId() %>', '<%= u.getName() %>')"
                                                <%= u.getRole() == Role.ADMIN ? "disabled" : "" %>>
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </button>
                                    <% } else { %>
                                        <span style="color: #64748b; font-size: 0.85rem; font-style: italic;">Current User</span>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="no-users">
                <i class="fas fa-users"></i>
                <h3>No Users Found</h3>
                <p>There are no registered users in the system yet.</p>
            </div>
            <% } %>
        </div>

        <!-- Pagination -->
        <% if (users != null && !users.isEmpty()) { %>
        <div class="pagination">
            <button class="page-btn active">1</button>
            <button class="page-btn">2</button>
            <button class="page-btn">3</button>
            <button class="page-btn">Next <i class="fas fa-chevron-right"></i></button>
        </div>
        <% } %>
    </div>

    <script>
        // SweetAlert notifications
        <%
            String errorMessage = (String) session.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: '<%= errorMessage %>',
            confirmButtonColor: '#dc2626'
        });
        <%
            session.removeAttribute("errorMessage");
        }
        %>

        // Filter users by search
        function filterUsers() {
            const searchTerm = document.getElementById('userSearch').value.toLowerCase();
            const roleFilter = document.getElementById('roleFilter').value;
            const rows = document.querySelectorAll('.user-row');
            
            rows.forEach(row => {
                const userName = row.querySelector('.user-info h4').textContent.toLowerCase();
                const userEmail = row.querySelector('.user-info p').textContent.toLowerCase();
                const userRole = row.querySelector('select[name="role"]').value;
                
                const matchesSearch = userName.includes(searchTerm) || userEmail.includes(searchTerm);
                const matchesRole = !roleFilter || userRole === roleFilter;
                
                if (matchesSearch && matchesRole) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        // Confirm role change
        function confirmRoleChange(userName, form) {
            const newRole = form.querySelector('select[name="role"]').value;
            
            Swal.fire({
                title: 'Change User Role?',
                html: `Change role for <b>${userName}</b> to <b>${newRole}</b>?`,
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#0f766e',
                cancelButtonColor: '#6b7280',
                confirmButtonText: 'Yes, change it!',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    form.submit();
                }
            });
            
            return false;
        }

        // Delete user confirmation
        function deleteUser(userId, userName) {
            Swal.fire({
                title: 'Delete User?',
                html: `Are you sure you want to delete <b>${userName}</b>?<br><small class="text-danger">This action cannot be undone.</small>`,
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc2626',
                cancelButtonColor: '#6b7280',
                confirmButtonText: 'Yes, delete user',
                cancelButtonText: 'Cancel',
                input: 'text',
                inputLabel: 'Reason for deletion (optional)',
                inputPlaceholder: 'Enter reason...'
            }).then((result) => {
                if (result.isConfirmed) {
                    const reason = result.value || '';
                    const form = document.createElement('form');
                    form.method = 'post';
                    form.action = '<%= request.getContextPath() %>/admin/admin-user-delete';
                    
                    const userIdInput = document.createElement('input');
                    userIdInput.type = 'hidden';
                    userIdInput.name = 'userId';
                    userIdInput.value = userId;
                    
                    const reasonInput = document.createElement('input');
                    reasonInput.type = 'hidden';
                    reasonInput.name = 'reason';
                    reasonInput.value = reason;
                    
                    form.appendChild(userIdInput);
                    form.appendChild(reasonInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            });
        }

        // Impersonate user
        function impersonateUser(userId, userName) {
            Swal.fire({
                title: 'Impersonate User?',
                html: `You will be logged in as <b>${userName}</b> temporarily.<br><small class="text-warning">This action will create a temporary session.</small>`,
                icon: 'info',
                showCancelButton: true,
                confirmButtonColor: '#2563eb',
                cancelButtonColor: '#6b7280',
                confirmButtonText: 'Continue as User',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '<%= request.getContextPath() %>/admin/impersonate?userId=' + userId;
                }
            });
        }

        // Export users to CSV
        function exportUsers() {
            Swal.fire({
                title: 'Export Users',
                text: 'Export all users to CSV format?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#0f766e',
                cancelButtonColor: '#6b7280',
                confirmButtonText: 'Export',
                cancelButtonText: 'Cancel'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = '<%= request.getContextPath() %>/admin/export-users';
                }
            });
        }

        // Auto-refresh page every 60 seconds for updates
        setTimeout(function() {
            location.reload();
        }, 60000);
    </script>
</body>
</html>