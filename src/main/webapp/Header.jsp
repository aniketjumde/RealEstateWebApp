
<%@ page import="com.realestate.model.User" %>

<%
    User loggedUser = (User) session.getAttribute("user");
    String contextPath = request.getContextPath();
%>


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
          <a class="nav-link" href="index">
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

