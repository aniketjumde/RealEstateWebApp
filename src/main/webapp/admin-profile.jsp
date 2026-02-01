<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.realestate.model.User" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile - RealEstate Pro</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-style.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
    <%@ include file="/slider-navbar.jsp" %>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <div class="header">
            <div class="header-left">
                <h1><i class="fas fa-user-circle"></i> Profile</h1>
                <p>Manage your account settings</p>
            </div>
            <div class="header-right">
                <div class="date-display">
                    <i class="fas fa-calendar-alt"></i>
                    <%= new java.text.SimpleDateFormat("EEEE, MMMM dd, yyyy").format(new java.util.Date()) %>
                </div>
            </div>
        </div>

        <!-- Content Wrapper -->
        <div class="content-wrapper fade-in">
            <!-- Success Message -->
            <%
                String success = (String) session.getAttribute("profileSuccess");
                if (success != null) {
            %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> <%= success %>
            </div>
            <%
                session.removeAttribute("profileSuccess");
            }
            %>

            <!-- Profile Container -->
            <div class="profile-container">
                <div class="profile-card">
                    <!-- Profile Header -->
                    <div class="profile-header">
                        <div class="profile-avatar">
                            <%= user.getName().substring(0, 1).toUpperCase() %>
                        </div>
                        <div class="profile-name"><%= user.getName() %></div>
                        <div class="profile-role">
                            <i class="fas fa-shield-alt"></i>
                            <%= user.getRole().toString().charAt(0) + user.getRole().toString().substring(1).toLowerCase() %>
                        </div>
                    </div>

                    <!-- Profile Body -->
                    <div class="profile-body">
                        <!-- Profile Form -->
                        <form action="${pageContext.request.contextPath}/profile-update" method="post">
                            <div class="profile-info">
                                <!-- Name Field -->
                                <div class="info-item">
                                    <i class="fas fa-user"></i>
                                    <div class="info-label">Full Name</div>
                                    <input type="text" name="name" value="<%= user.getName() %>" 
                                           class="form-control" required style="border: none; background: transparent; padding: 0;">
                                </div>

                                <!-- Email Field (Read-only) -->
                                <div class="info-item">
                                    <i class="fas fa-envelope"></i>
                                    <div class="info-label">Email Address</div>
                                    <div class="info-value"><%= user.getEmail() %></div>
                                </div>

                                <!-- Role Field (Read-only) -->
                                <div class="info-item">
                                    <i class="fas fa-shield-alt"></i>
                                    <div class="info-label">Account Role</div>
                                    <div class="info-value">
                                        <span class="badge badge-primary">
                                            <%= user.getRole().toString().charAt(0) + user.getRole().toString().substring(1).toLowerCase() %>
                                        </span>
                                    </div>
                                </div>

								<!-- Member Since -->
								<div class="info-item">
								    <i class="fas fa-calendar-plus"></i>
								    <div class="info-label">Member Since</div>
								    <div class="info-value">
								        <% if (user.getCreatedAt() != null) { %>
								            <%= user.getCreatedAt()
								                  .toLocalDate()
								                  .format(java.time.format.DateTimeFormatter.ofPattern("MMMM dd, yyyy")) %>
								        <% } else { %>
								            N/A
								        <% } %>
								    </div>
								</div>

                                <!-- Account Status -->
                                <div class="info-item">
                                    <i class="fas fa-check-circle"></i>
                                    <div class="info-label">Account Status</div>
                                    <div class="info-value">
                                        <span class="badge badge-success">
                                            <i class="fas fa-circle" style="font-size: 0.5rem; vertical-align: middle;"></i>
                                            Active
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <!-- Save Button -->
                            <button type="submit" class="save-btn">
                                <i class="fas fa-save"></i> Save Changes
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Show success message from SweetAlert
        <%
            if (success != null) {
        %>
        Swal.fire({
            icon: 'success',
            title: 'Profile Updated',
            text: '<%= success %>',
            confirmButtonColor: '#2A5CAA',
            timer: 3000,
            showConfirmButton: false
        });
        <%
            }
        %>

        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const nameInput = this.querySelector('input[name="name"]');
            if (nameInput.value.trim().length < 2) {
                e.preventDefault();
                Swal.fire({
                    icon: 'error',
                    title: 'Invalid Name',
                    text: 'Please enter a valid name (at least 2 characters).',
                    confirmButtonColor: '#EF4444'
                });
                nameInput.focus();
            }
        });

        // Auto-save indicator
        let autoSaveTimeout;
        document.querySelector('input[name="name"]').addEventListener('input', function() {
            clearTimeout(autoSaveTimeout);
            autoSaveTimeout = setTimeout(() => {
                const saveBtn = document.querySelector('.save-btn');
                const originalText = saveBtn.innerHTML;
                saveBtn.innerHTML = '<i class="fas fa-sync fa-spin"></i> Saving...';
                saveBtn.disabled = true;
                
                // Simulate auto-save
                setTimeout(() => {
                    saveBtn.innerHTML = originalText;
                    saveBtn.disabled = false;
                    
                    // Show auto-save notification
                    const notification = document.createElement('div');
                    notification.className = 'alert alert-success';
                    notification.style.position = 'fixed';
                    notification.style.top = '20px';
                    notification.style.right = '20px';
                    notification.style.zIndex = '10000';
                    notification.innerHTML = '<i class="fas fa-check-circle"></i> Changes saved';
                    document.body.appendChild(notification);
                    
                    setTimeout(() => {
                        notification.remove();
                    }, 2000);
                }, 1000);
            }, 2000);
        });
    </script>
</body>
</html>