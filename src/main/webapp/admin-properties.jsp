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

    List<Property> properties = (List<Property>) request.getAttribute("properties");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Properties Management - RealEstate Pro</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                <h1><i class="fas fa-home"></i> Properties</h1>
                <p>Manage all property listings</p>
            </div>
            <div class="header-right">
                <div class="date-display">
                    <i class="fas fa-calendar-alt"></i>
                    <%= new java.text.SimpleDateFormat("EEEE, MMMM dd, yyyy").format(new java.util.Date()) %>
                </div>
                <div class="user-profile">
                    <div class="user-avatar">
                        <%= admin.getName().substring(0, 1).toUpperCase() %>
                    </div>
                    <div class="user-info">
                        <strong><%= admin.getName() %></strong>
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
                    <div class="table-title">All Properties</div>
                    <p class="text-muted"><%= properties != null ? properties.size() : 0 %> properties found</p>
                </div>
                <div class="table-actions">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="propertySearch" class="search-input" placeholder="Search properties...">
                    </div>
                   
                </div>
            </div>

            <!-- Properties Table -->
            <div class="table-container">
                <div class="table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Property</th>
                                <th>Owner</th>
                                <th>Location</th>
                                <th>Price</th>
                                <th>Type</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (properties != null && !properties.isEmpty()) { %>
                                <% for (Property p : properties) { %>
                                <tr>
                                    <!-- Property Cell -->
                                    <td>
                                        <div class="property-cell">
                                            <% if (p.getImages() != null && !p.getImages().isEmpty()) { %>
                                                <img src="${pageContext.request.contextPath}/property-image?id=<%= p.getImages().get(0).getImageId() %>"
                                                     class="property-image" alt="<%= p.getTitle() %>">
                                            <% } else { %>
                                                <div class="property-image-placeholder">
                                                    <i class="fas fa-home"></i>
                                                </div>
                                            <% } %>
                                            <div class="property-info">
                                                <div class="property-title"><%= p.getTitle() %></div>
                                                <div class="property-id">ID: <%= p.getId() %></div>
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Owner -->
                                    <td>
                                        <div class="user-cell">
                                            <div class="user-avatar-small">
                                                <%= p.getUser() != null ? p.getUser().getName().substring(0, 1).toUpperCase() : "N" %>
                                            </div>
                                            <div class="user-info">
                                                <div class="user-name"><%= p.getUser() != null ? p.getUser().getName() : "N/A" %></div>
                                                <div class="user-email"><%= p.getUser() != null ? p.getUser().getEmail() : "" %></div>
                                            </div>
                                        </div>
                                    </td>

                                    <!-- Location -->
                                    <td>
                                        <div class="text-muted">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <%= p.getCity() != null ? p.getCity() : "N/A" %>
                                        </div>
                                    </td>

                                    <!-- Price -->
                                    <td>
                                        <strong class="text-primary">₹ <%= p.getPrice() %></strong>
                                    </td>

                                    <!-- Type -->
                                    <td>
                                        <span class="badge badge-primary">
                                            <%= p.getPurpose() != null ? p.getPurpose() : "N/A" %>
                                        </span>
                                    </td>

                                    <!-- Status -->
                                    <td>
                                        <%
                                            String status = p.getVerification().name();
                                            String badgeClass = "";
                                            if ("PENDING".equals(status)) {
                                                badgeClass = "badge-warning";
                                            } else if ("APPROVED".equals(status)) {
                                                badgeClass = "badge-success";
                                            } else if ("REJECTED".equals(status)) {
                                                badgeClass = "badge-danger";
                                            }
                                        %>
                                        <span class="badge <%= badgeClass %>">
                                            <%= status %>
                                        </span>
                                    </td>

                                    
                                </tr>
                                <% } %>
                            <% } else { %>
                                <tr>
                                    <td colspan="7">
                                        <div class="empty-state">
                                            <i class="fas fa-home"></i>
                                            <h4>No Properties Found</h4>
                                            <p>There are no properties in the system yet.</p>
                                        </div>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <% if (properties != null && !properties.isEmpty()) { %>
                <div class="pagination">
                    <button class="page-btn"><i class="fas fa-chevron-left"></i></button>
                    <button class="page-btn active">1</button>
                    <button class="page-btn">2</button>
                    <button class="page-btn">3</button>
                    <button class="page-btn"><i class="fas fa-chevron-right"></i></button>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <script>
        // Search functionality
        document.getElementById('propertySearch').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const rows = document.querySelectorAll('.data-table tbody tr');
            
            rows.forEach(row => {
                const propertyTitle = row.querySelector('.property-title').textContent.toLowerCase();
                const ownerName = row.querySelector('.user-name').textContent.toLowerCase();
                const location = row.querySelector('.text-muted').textContent.toLowerCase();
                
                if (propertyTitle.includes(searchTerm) || 
                    ownerName.includes(searchTerm) || 
                    location.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
        
      
        
        // Status filter
        function filterByStatus(status) {
            const rows = document.querySelectorAll('.data-table tbody tr');
            
            rows.forEach(row => {
                const statusBadge = row.querySelector('.badge').textContent;
                if (status === 'all' || statusBadge === status) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>