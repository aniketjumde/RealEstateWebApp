
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.enums.Role" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.temporal.ChronoUnit" %>

<%
   
    
    List<User> users = (List<User>) request.getAttribute("users");
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Management - RealEstate Pro</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .role-form {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .role-select-small {
            padding: 6px 12px;
            border-radius: 8px;
            border: 1px solid var(--gray-300);
            background: white;
            font-size: 0.875rem;
            cursor: pointer;
            min-width: 100px;
        }
        
        .role-select-small:disabled {
            background: var(--gray-100);
            cursor: not-allowed;
            opacity: 0.7;
        }
        
        .action-group {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        
        .btn-icon-sm {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid var(--gray-300);
            background: white;
            color: var(--gray-600);
            cursor: pointer;
            font-size: 0.875rem;
            transition: all 0.3s ease;
        }
        
        .btn-icon-sm:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        
        .btn-icon-sm.danger {
            background: var(--danger);
            color: white;
            border-color: var(--danger);
        }
        
        .btn-icon-sm.danger:hover {
            background: #dc2626;
            border-color: #dc2626;
        }
        
        .btn-icon-sm.danger:disabled {
            background: var(--gray-300);
            border-color: var(--gray-300);
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .current-user-badge {
            font-size: 0.7rem;
            padding: 2px 6px;
            background: var(--primary);
            color: white;
            border-radius: 4px;
            margin-left: 5px;
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
                <h1><i class="fas fa-users-cog"></i> User Management</h1>
                <p>Manage user accounts and permissions</p>
            </div>
            <div class="header-right">
                <div class="date-display">
                    <i class="fas fa-calendar-alt"></i>
                    <%= java.time.LocalDate.now().format(DateTimeFormatter.ofPattern("EEEE, MMMM dd, yyyy")) %>
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
            <!-- Page Header -->
            <div class="table-header mb-30">
                <div>
                    <div class="table-title">All Users</div>
                    <p class="text-muted"><%= users != null ? users.size() : 0 %> registered users</p>
                </div>
                <div class="table-actions">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="userSearch" class="search-input" placeholder="Search by name or email...">
                    </div>
                </div>
            </div>

            <!-- Success/Error Messages -->
            <%
                String successMessage = (String) session.getAttribute("successMessage");
                String errorMessage = (String) session.getAttribute("errorMessage");
                
                if (successMessage != null) {
            %>
            <div class="alert alert-success" style="margin-bottom: 20px;">
                <i class="fas fa-check-circle"></i> <%= successMessage %>
            </div>
            <%
                    session.removeAttribute("successMessage");
                }
                
                if (errorMessage != null) {
            %>
            <div class="alert alert-error" style="margin-bottom: 20px;">
                <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
            </div>
            <%
                    session.removeAttribute("errorMessage");
                }
            %>

            <!-- Users Table -->
            <div class="table-container">
                <div class="table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>User</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Joined Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (users != null && !users.isEmpty()) { %>
                                <% for(User u : users){ 
                                    boolean isCurrentUser = u.getId().equals(user.getId());
                                %>
                                <tr data-user-id="<%= u.getId() %>">
                                    <!-- User Cell -->
                                    <td>
                                        <div class="user-cell">
                                            <div class="user-avatar-small" 
                                                 style="background: <%= isCurrentUser ? "linear-gradient(135deg, var(--primary), var(--primary-dark))" : "linear-gradient(135deg, var(--secondary), var(--secondary-dark))" %>;">
                                                <%= u.getName().substring(0, 1).toUpperCase() %>
                                            </div>
                                            <div class="user-info">
                                                <div class="user-name">
                                                    <%= u.getName() %>
                                                    <% if (isCurrentUser) { %>
                                                    <span class="current-user-badge">You</span>
                                                    <% } %>
                                                </div>
                                                <div class="user-email"><%= u.getEmail() %></div>
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Role -->
                                    <td>
    <form action="<%= request.getContextPath() %>/admin/admin-user-role"
          method="post"
          style="display:inline;"
          onsubmit="return confirmRoleChange('<%= u.getName() %>');">

        <!-- Always send userId -->
        <input type="hidden" name="userId" value="<%= u.getId() %>">

        <!-- Role Select (THIS sends role directly) -->
        <select name="role"
                class="role-select-small"
                <%= isCurrentUser ? "disabled" : "" %>>
            <option value="USER"
                <%= u.getRole() == Role.USER ? "selected" : "" %>>
                User
            </option>

            <option value="ADMIN"
                <%= u.getRole() == Role.ADMIN ? "selected" : "" %>>
                Admin
            </option>
        </select>

        <% if (!isCurrentUser) { %>
            <button type="submit" class="btn-icon-sm" title="Update Role">
                <i class="fas fa-save"></i>
            </button>
        <% } %>

    </form>
</td>


                                    
                                    <!-- Status -->
                                    <td>
                                        <span class="badge badge-success">
                                            <i class="fas fa-circle" style="font-size: 0.5rem; vertical-align: middle; margin-right: 4px;"></i>
                                            Active
                                        </span>
                                    </td>

                                    <!-- Joined Date -->
                                    <td>
									<% if (u.getCreatedAt() != null) { %>
									
									    <!-- Joined Date -->
									    <div>
									        <%= u.getCreatedAt()
									              .toLocalDate()
									              .format(java.time.format.DateTimeFormatter.ofPattern("dd MMM yyyy")) %>
									    </div>
									
									    <!-- Days Ago -->
									    <small class="text-muted">
									        <%
									            long daysAgo = java.time.temporal.ChronoUnit.DAYS.between(
									                    u.getCreatedAt().toLocalDate(),
									                    java.time.LocalDate.now()
									            );
									        %>
									
									        <%= (daysAgo == 0) ? "Today" :
									            (daysAgo == 1 ? "1 day ago" : daysAgo + " days ago") %>
									    </small>
									
									<% } else { %>
									    N/A
									<% } %>
									</td>

                                </tr>
                                <% } %>
                            <% } else { %>
                                <tr>
                                    <td colspan="5">
                                        <div class="empty-state">
                                            <i class="fas fa-users"></i>
                                            <h4>No Users Found</h4>
                                            <p>There are no registered users in the system yet.</p>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <% if (users != null && !users.isEmpty()) { %>
                <div class="pagination">
                    <button class="page-btn" onclick="changePage('prev')"><i class="fas fa-chevron-left"></i></button>
                    <button class="page-btn active">1</button>
                    <button class="page-btn" onclick="changePage(2)">2</button>
                    <button class="page-btn" onclick="changePage(3)">3</button>
                    <button class="page-btn" onclick="changePage('next')"><i class="fas fa-chevron-right"></i></button>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <script>
        // Search functionality
        document.getElementById('userSearch').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase().trim();
            const rows = document.querySelectorAll('.data-table tbody tr');
            
            rows.forEach(row => {
                const userName = row.querySelector('.user-name').textContent.toLowerCase();
                const userEmail = row.querySelector('.user-email').textContent.toLowerCase();
                
                if (searchTerm === '' || userName.includes(searchTerm) || userEmail.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });

       


      


        // Page navigation
        function changePage(page) {
            // In a real application, this would make an AJAX call to load the next page
            // For now, we'll just show a loading message
            if (page === 'prev' || page === 'next') {
                Swal.fire({
                    title: 'Loading...',
                    text: 'Please wait while we load the next page',
                    icon: 'info',
                    showConfirmButton: false,
                    timer: 1500
                });
            } else {
                // For numbered pages
                Swal.fire({
                    title: 'Loading Page ' + page,
                    text: 'Please wait...',
                    icon: 'info',
                    showConfirmButton: false,
                    timer: 1500
                });
            }
        }

        // Auto-refresh page every 60 seconds
        setTimeout(function() {
            location.reload();
        }, 60000);

        // Store original role values on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Highlight current user row
            const currentUserId = '<%= user.getId() %>';
            const currentUserRow = document.querySelector(`tr[data-user-id="${currentUserId}"]`);
            if (currentUserRow) {
                currentUserRow.style.backgroundColor = 'rgba(42, 92, 170, 0.05)';
            }
        });
        

    </script>
</body>
</html>
	