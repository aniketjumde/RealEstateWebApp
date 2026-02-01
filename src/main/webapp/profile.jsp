<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.realestate.model.User" %>
<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile</title>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
body {
    background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
    min-height: 100vh;
    padding: 20px;
}

.container {
    max-width: 600px;
}

.profile-card {
    background: white;
    border-radius: 16px;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
    padding: 40px;
    margin-top: 40px;
}

.profile-header {
    text-align: center;
    margin-bottom: 40px;
    padding-bottom: 30px;
    border-bottom: 1px solid #e2e8f0;
}

.profile-photo {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    object-fit: cover;
    border: 5px solid white;
    box-shadow: 0 5px 20px rgba(15, 118, 110, 0.15);
    margin-bottom: 20px;
}

.profile-name {
    font-size: 28px;
    font-weight: 700;
    color: #0f766e;
    margin-bottom: 8px;
}

.profile-role {
    font-size: 16px;
    color: #64748b;
    background: #f1f5f9;
    padding: 6px 16px;
    border-radius: 20px;
    display: inline-block;
}

.form-group {
    margin-bottom: 24px;
}

.form-label {
    font-weight: 600;
    color: #475569;
    margin-bottom: 8px;
    font-size: 14px;
}

.form-control, .form-control:read-only {
    padding: 12px 16px;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    font-size: 16px;
    transition: all 0.2s;
}

.form-control:focus {
    border-color: #0f766e;
    box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.1);
}

.form-control:read-only {
    background-color: #f8fafc;
    color: #64748b;
    cursor: not-allowed;
}

.photo-upload {
    text-align: center;
    margin-top: 10px;
}

.photo-upload input {
    max-width: 250px;
    margin: 0 auto;
    font-size: 14px;
}

.save-btn {
    background: linear-gradient(135deg, #0f766e, #115e59);
    border: none;
    padding: 14px 32px;
    font-size: 16px;
    font-weight: 600;
    border-radius: 8px;
    width: 100%;
    margin-top: 10px;
    transition: all 0.3s ease;
}

.save-btn:hover {
    background: linear-gradient(135deg, #115e59, #0f766e);
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(15, 118, 110, 0.3);
}

.member-since {
    font-size: 14px;
    color: #94a3b8;
    text-align: center;
    margin-top: 30px;
    padding-top: 20px;
    border-top: 1px solid #e2e8f0;
}

.profile-icon {
    width: 24px;
    height: 24px;
    margin-right: 10px;
    color: #0f766e;
}
</style>
</head>

<body>
<%@ include file="/Header.jsp" %>

<div class="container">
    <div class="profile-card">
        <%
        String success = (String) session.getAttribute("profileSuccess");
        if (success != null) {
        %>
        <script>
        Swal.fire({
            icon: 'success',
            title: 'Profile Updated',
            text: '<%= success %>',
            confirmButtonColor: '#0f766e',
            timer: 3000,
            showConfirmButton: false
        });
        </script>
        <%
            session.removeAttribute("profileSuccess");
        }
        %>

        <!-- Profile Header -->
        <div class="profile-header">
            <!-- Profile Photo -->
            <img src="profile-image?id=<%= user.getId() %>" class="profile-photo" 
                 onerror="this.src='https://ui-avatars.com/api/?name=<%= user.getName() %>&background=0f766e&color=fff&size=120'">
            
            <!-- Name -->
            <h1 class="profile-name"><%= user.getName() %></h1>
            
            <!-- Role Badge -->
            <div class="profile-role">
                <%= user.getRole().toString().charAt(0) + user.getRole().toString().substring(1).toLowerCase() %>
            </div>
        </div>

        <!-- Profile Form -->
        <form action="profile-update" method="post" >
            
           
            <!-- Name Field -->
            <div class="form-group">
                <label class="form-label">Full Name</label>
                <input type="text" name="name" value="<%= user.getName() %>" 
                       class="form-control" required>
            </div>

            <!-- Email Field (Read-only) -->
            <div class="form-group">
                <label class="form-label">Email Address</label>
                <input type="email" value="<%= user.getEmail() %>" 
                       class="form-control" readonly>
            </div>

         

            <!-- Member Since (Read-only) -->
            <div class="form-group">
                <label class="form-label">Member Since</label>
                <input type="text" value="<%= user.getCreatedAt() %>" 
                       class="form-control" readonly>
            </div>

            <!-- Save Button -->
            <button type="submit" class="btn btn-primary save-btn">
                Save Changes
            </button>

            <!-- Member Since Footer -->
            <div class="member-since">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
                    <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z"/>
                    <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0"/>
                </svg>
                Member since <%= user.getCreatedAt() %>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>