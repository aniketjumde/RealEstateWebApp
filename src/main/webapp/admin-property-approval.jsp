<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.model.User" %>

<%
  
    List<Property> properties = (List<Property>) request.getAttribute("pendingProperties");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Property Approval - RealEstate Pro</title>
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
                <h1><i class="fas fa-clipboard-check"></i> Approvals</h1>
                <p>Review and approve property listings</p>
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
            <!-- Page Header -->
            <div class="table-header mb-30">
                <div>
                    <div class="table-title">Pending Approvals</div>
                    <p class="text-muted"><%= properties != null ? properties.size() : 0 %> properties awaiting review</p>
                </div>
                <div class="table-actions">
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="approvalSearch" class="search-input" placeholder="Search pending properties...">
                    </div>
                </div>
            </div>

            <!-- Success Message -->
            <%
                String successMessage = (String) session.getAttribute("successMessage");
                if (successMessage != null) {
            %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> <%= successMessage %>
            </div>
            <%
                session.removeAttribute("successMessage");
                }
            %>

            <!-- Approval Cards Grid -->
            <% if (properties != null && !properties.isEmpty()) { %>
            <div class="dashboard-grid">
                <% for(Property p : properties){ %>
                <div class="card">
                    <div class="card-header">
                        <div class="card-title">
                            <i class="fas fa-home"></i>
                            <%= p.getTitle() %>
                        </div>
                        <span class="badge badge-warning">Pending</span>
                    </div>
                    <div class="card-body">
                        <div class="list-item" style="border: none; padding: 20px 24px;">
                            <div class="item-info" style="align-items: flex-start;">
                               <% if (p.getImages() != null && !p.getImages().isEmpty()) { %>
								    <img src="${pageContext.request.contextPath}/property-image?id=<%= p.getImages().get(0).getImageId() %>"
								         style="width:100px;height:80px;object-fit:cover;">
								<% } else { %>
								    <div class="no-image">
								        <i class="fas fa-home"></i>
								    </div>
								<% } %>

                                <div class="item-details" style="flex: 1;">
                                    <div class="item-title"><%= p.getTitle() %></div>
                                    <div class="item-subtitle mb-20">
                                        <i class="fas fa-user"></i> <%= p.getUser().getName() %>
                                    </div>
                                    
                                    <!-- Property Details -->
                                    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; margin-top: 16px;">
                                        <div>
                                            <small class="text-muted">Location</small>
                                            <div><i class="fas fa-map-marker-alt"></i> <%= p.getCity() %></div>
                                        </div>
                                        <div>
                                            <small class="text-muted">Price</small>
                                            <div class="text-primary" style="font-weight: 600;">₹ <%= p.getPrice() %></div>
                                        </div>
                                        <div>
                                            <small class="text-muted">Type</small>
                                            <div><%= p.getPropertyType() %></div>
                                        </div>
                                        <div>
                                            <small class="text-muted">Size</small>
                                            <div><%= p.getAreaSqarefit() != null ? p.getAreaSqarefit() + " sq.ft." : "N/A" %></div>
                                        </div>
                                    </div>
                                    
                                    <!-- Description -->
                                    <% if (p.getDescription() != null && p.getDescription().length() > 0) { %>
                                    <div style="margin-top: 16px; padding-top: 16px; border-top: 1px solid var(--gray-200);">
                                        <small class="text-muted">Description</small>
                                        <div style="font-size: 0.875rem; color: var(--gray-600); line-height: 1.5;">
                                            <%= p.getDescription().length() > 150 ? p.getDescription().substring(0, 150) + "..." : p.getDescription() %>
                                        </div>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div style="padding: 20px 24px; border-top: 1px solid var(--gray-200); background: var(--gray-50);">
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <a href="${pageContext.request.contextPath}/property-details?id=<%= p.getId() %>" 
                                   class="btn-icon" style="text-decoration: none;">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                                
                                <div style="display: flex; gap: 12px;">
                                    <!-- APPROVE FORM -->
                                    <form action="${pageContext.request.contextPath}/admin/property-approval" method="post" style="display:inline;">
                                        <input type="hidden" name="propertyId" value="<%= p.getId() %>">
                                        <input type="hidden" name="action" value="APPROVE">
                                        <button type="submit" class="export-btn" style="background: var(--success); border: none;">
                                            <i class="fas fa-check"></i> Approve
                                        </button>
                                    </form>

                                    <!-- REJECT FORM -->
                                    <form action="${pageContext.request.contextPath}/admin/property-approval" method="post" style="display:inline;">
                                        <input type="hidden" name="propertyId" value="<%= p.getId() %>">
                                        <input type="hidden" name="action" value="REJECT">
                                        <button type="submit" class="export-btn" style="background: var(--danger); border: none;">
                                            <i class="fas fa-times"></i> Reject
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <div class="empty-state">
                <i class="fas fa-clipboard-check"></i>
                <h4>No Pending Approvals</h4>
                <p>All properties have been reviewed and approved. Check back later for new submissions.</p>
            </div>
            <% } %>
        </div>
    </div>

    <script>
        // Search functionality
        document.getElementById('approvalSearch').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const cards = document.querySelectorAll('.card');
            
            cards.forEach(card => {
                const title = card.querySelector('.card-title').textContent.toLowerCase();
                const owner = card.querySelector('.item-subtitle').textContent.toLowerCase();
                const location = card.textContent.toLowerCase();
                
                if (title.includes(searchTerm) || 
                    owner.includes(searchTerm) || 
                    location.includes(searchTerm)) {
                    card.style.display = '';
                } else {
                    card.style.display = 'none';
                }
            });
        });
        
        // Confirmation for approve/reject
        document.addEventListener('submit', function(e) {
            if (e.target.matches('form[action*="property-approval"]')) {
                const action = e.target.querySelector('input[name="action"]').value;
                const actionText = action === 'APPROVE' ? 'approve' : 'reject';
                
                e.preventDefault();
                
                Swal.fire({
                    title: `${actionText.charAt(0).toUpperCase() + actionText.slice(1)} Property?`,
                    text: `Are you sure you want to ${actionText} this property listing?`,
                    icon: action === 'APPROVE' ? 'question' : 'warning',
                    showCancelButton: true,
                    confirmButtonColor: action === 'APPROVE' ? '#10B981' : '#EF4444',
                    cancelButtonColor: '#6B7280',
                    confirmButtonText: `Yes, ${actionText} it!`,
                    cancelButtonText: 'Cancel'
                }).then((result) => {
                    if (result.isConfirmed) {
                        e.target.submit();
                    }
                });
            }
        });
    </script>
</body>
</html>