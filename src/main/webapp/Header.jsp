
<%@ page import="com.realestate.model.User" %>

<%
    User loggedUser = (User) session.getAttribute("user");
    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RealEstate</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
    /* SAME COLORS AS BEFORE - just added CSS variables for consistency */
    :root {
        --primary-blue: #0d6efd;
        --primary-teal: #0f766e;
        --danger-red: #dc3545;
    }
    
    /* ENHANCED NAVBAR STYLING */
    .navbar {
        background: white;
        box-shadow: 0 2px 15px rgba(0,0,0,0.08);
        padding-top: 12px;
        padding-bottom: 12px;
        transition: all 0.3s ease;
    }
    
    .navbar-brand {
        font-weight: 800;
        color: var(--primary-blue) !important;
        font-size: 1.8rem;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .navbar-brand i {
        color: var(--primary-teal);
    }
    
    .nav-link {
        color: #333 !important;
        font-weight: 500;
        padding: 8px 16px !important;
        border-radius: 6px;
        transition: all 0.2s ease;
        margin: 0 2px;
    }
    
    .nav-link:hover {
        background-color: rgba(13, 110, 253, 0.05);
        color: var(--primary-blue) !important;
        transform: translateY(-1px);
    }
    
    .btn-nav-primary {
        background: linear-gradient(135deg, var(--primary-teal), #0d6efd);
        color: white !important;
        border: none;
        padding: 8px 20px !important;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(13, 110, 253, 0.2);
    }
    
    .btn-nav-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(13, 110, 253, 0.3);
    }
    
    .dropdown-menu {
        border: none;
        box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        border-radius: 12px;
        padding: 10px 0;
        margin-top: 10px;
        min-width: 220px;
    }
    
    .dropdown-item {
        padding: 10px 20px;
        color: #333;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .dropdown-item i {
        width: 20px;
        text-align: center;
        color: var(--primary-teal);
    }
    
    .dropdown-item:hover {
        background-color: rgba(13, 110, 253, 0.08);
        color: var(--primary-blue);
        padding-left: 25px;
    }
    
    .dropdown-divider {
        margin: 8px 20px;
        opacity: 0.2;
    }
    
    .user-avatar {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary-teal), var(--primary-blue));
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        margin-right: 8px;
    }
    
    .navbar-toggler {
        border: none;
        padding: 8px;
        border-radius: 8px;
    }
    
    .navbar-toggler:focus {
        box-shadow: 0 0 0 3px rgba(13, 110, 253, 0.1);
    }
    
    /* Mobile responsive adjustments */
    @media (max-width: 991px) {
        .navbar-collapse {
            padding: 20px 0;
        }
        
        .nav-link {
            margin: 5px 0;
            padding: 10px 15px !important;
        }
        
        .btn-nav-primary {
            margin-top: 10px;
            display: inline-block;
        }
    }
</style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-light">
  <div class="container">

    <!-- Logo -->
    <a class="navbar-brand" href="index.jsp">
        <i class="fas fa-home"></i> RealEstate
    </a>

    <!-- Mobile Toggle -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
      data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Menu -->
    <div class="collapse navbar-collapse" id="navbarNav">

      <!-- Center Menu -->
      <ul class="navbar-nav mx-auto">
        <li class="nav-item">
          <a class="nav-link" href="index.jsp">
            <i class="fas fa-home me-1"></i> Home
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="property">
            <i class="fas fa-building me-1"></i> Properties
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="about.jsp">
            <i class="fas fa-info-circle me-1"></i> About
          </a>
        </li>
        <% if (loggedUser != null) { %>
        <li class="nav-item">
          <a class="nav-link" href="dashboard">
            <i class="fas fa-tachometer-alt me-1"></i> Dashboard
          </a>
        </li>
        <% } %>
      </ul>

      <!-- Right Side -->
      <ul class="navbar-nav ms-auto">

        <% if (loggedUser == null) { %>
          <!-- Guest User -->
          <li class="nav-item">
            <a class="btn btn-nav-primary"    href="login.jsp">	
              <i class="fas fa-sign-in-alt me-1"></i> Sign In
            </a>
          </li>

        <% } else { %>
          <!-- Logged User -->
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button"
               data-bs-toggle="dropdown">
	               <%
	    String displayName = "U";
	    String fullName = "User";
	
	    if (loggedUser != null && loggedUser.getName() != null && !loggedUser.getName().trim().isEmpty()) {
	        fullName = loggedUser.getName();
	        displayName = fullName.substring(0, 1).toUpperCase();
	    }
	%>
	
	<div class="user-avatar">
	    <%= displayName %>
	</div>
	<div>
	    <%= fullName %>
	</div>

            </a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="dashboard">
                <i class="fas fa-tachometer-alt"></i> Dashboard
              </a></li>
              <li><a class="dropdown-item" href="profile.jsp">
                <i class="fas fa-user"></i> Profile
              </a></li>
              <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user-properties">
                <i class="fas fa-home"></i> My Properties
              </a></li>
            
              	
              <li><hr class="dropdown-divider"></li>
              <!-- FIXED LOGOUT LINK -->
              <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">
                <i class="fas fa-sign-out-alt"></i> Logout
              </a></li>
            </ul>
          </li>
        <% } %>

      </ul>

    </div>
  </div>
</nav>

</body>
</html>