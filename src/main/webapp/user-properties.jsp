<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/Header.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.enums.PropertyVerificationStatus" %>
<%@ page import="com.realestate.model.PropertyImage" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Properties</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
:root {
    --primary-color: #0f766e;
    --secondary-color: #2563eb;
    --danger-color: #dc2626;
    --light-bg: #f8fafc;
    --card-shadow: 0 5px 15px rgba(0,0,0,0.08);
}

body {
    background-color: var(--light-bg);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.container {
    max-width: 1200px;
}

.page-title {
    color: #1e293b;
    font-weight: 700;
    margin-bottom: 30px;
    padding-bottom: 15px;
    border-bottom: 3px solid var(--primary-color);
}

.property-card {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: var(--card-shadow);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    margin-bottom: 25px;
    border: 1px solid #e2e8f0;
    height: 100%;
}

.property-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.12);
}

.property-image-container {
    height: 220px;
    overflow: hidden;
    position: relative;
}

.property-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
}

.property-card:hover .property-image {
    transform: scale(1.05);
}

.no-image {
    background: linear-gradient(135deg, #f8fafc, #e2e8f0);
    height: 220px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #94a3b8;
    font-size: 3rem;
}

.property-badge {
    position: absolute;
    top: 15px;
    left: 15px;
    background: var(--primary-color);
    color: white;
    padding: 6px 15px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
    z-index: 10;
}

.property-badge.rent {
    background: var(--secondary-color);
}

.property-badge.sold {
    background: #dc2626;
}

.property-badge.pending {
    background: #f59e0b;
}

.property-content {
    padding: 20px;
}

.property-title {
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 10px;
    font-size: 1.25rem;
    line-height: 1.3;
}

.property-location {
    color: #64748b;
    font-size: 0.95rem;
    margin-bottom: 15px;
}

.property-location i {
    color: var(--primary-color);
    margin-right: 8px;
}

.property-price {
    font-size: 1.5rem;
    font-weight: 800;
    color: var(--primary-color);
    margin-bottom: 15px;
}

.property-meta {
    display: flex;
    gap: 20px;
    margin-bottom: 15px;
    flex-wrap: wrap;
}

.meta-item {
    display: flex;
    align-items: center;
    gap: 6px;
    color: #64748b;
    font-size: 0.9rem;
}

.meta-item i {
    color: var(--primary-color);
}

.property-status {
    margin-top: 15px;
    padding-top: 15px;
    border-top: 1px solid #e2e8f0;
}

.status-badge {
    display: inline-block;
    padding: 5px 12px;
    border-radius: 6px;
    font-size: 0.85rem;
    font-weight: 600;
}

.status-approved {
    background-color: #dcfce7;
    color: #16a34a;
}

.status-pending {
    background-color: #fef9c3;
    color: #d97706;
}

.status-rejected {
    background-color: #fee2e2;
    color: #dc2626;
}

.verification-badge {
    display: inline-block;
    padding: 5px 12px;
    border-radius: 6px;
    font-size: 0.85rem;
    font-weight: 600;
    margin-left: 10px;
}

.verification-verified {
    background-color: #dcfce7;
    color: #16a34a;
}

.verification-pending {
    background-color: #fef9c3;
    color: #d97706;
}

.action-buttons {
    display: flex;
    gap: 10px;
    margin-top: 15px;
}

.btn-edit {
    flex: 1;
    background-color: var(--primary-color);
    color: white;
    border: none;
    padding: 10px;
    border-radius: 6px;
    font-weight: 600;
    text-align: center;
    text-decoration: none;
    transition: background-color 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.btn-edit:hover {
    background-color: #115e59;
    color: white;
}

.btn-delete {
    flex: 1;
    background-color: var(--danger-color);
    color: white;
    border: none;
    padding: 10px;
    border-radius: 6px;
    font-weight: 600;
    text-align: center;
    text-decoration: none;
    transition: background-color 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    cursor: pointer;
}

.btn-delete:hover {
    background-color: #b91c1c;
    color: white;
}

.btn-view {
    display: block;
    text-align: center;
    padding: 10px;
    background-color: var(--secondary-color);
    color: white;
    text-decoration: none;
    border-radius: 6px;
    font-weight: 600;
    transition: background-color 0.3s ease;
    margin-top: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.btn-view:hover {
    background-color: #1d4ed8;
    color: white;
}

.no-properties {
    text-align: center;
    padding: 60px 20px;
    background: white;
    border-radius: 12px;
    box-shadow: var(--card-shadow);
}

.no-properties i {
    font-size: 4rem;
    color: #cbd5e1;
    margin-bottom: 20px;
}

.no-properties h4 {
    color: #64748b;
    margin-bottom: 15px;
}

.add-property-btn {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    border: none;
    padding: 12px 30px;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    text-decoration: none;
    display: inline-block;
    box-shadow: 0 4px 12px rgba(13, 110, 253, 0.2);
}

.add-property-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(13, 110, 253, 0.3);
    color: white;
}

/* Confirmation Modal */
.modal-content {
    border-radius: 12px;
    border: none;
}

.modal-header {
    background-color: #f8fafc;
    border-bottom: 1px solid #e2e8f0;
    border-radius: 12px 12px 0 0;
}

.modal-title {
    color: var(--danger-color);
    font-weight: 600;
}

.btn-confirm-delete {
    background-color: var(--danger-color);
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    font-weight: 600;
}

.btn-confirm-delete:hover {
    background-color: #b91c1c;
}

.btn-cancel {
    background-color: #6b7280;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 6px;
    font-weight: 600;
}

.btn-cancel:hover {
    background-color: #4b5563;
}
</style>
</head>

<body>

<div class="container mt-4 mb-5">
    <!-- Success Message -->
    <%
    String msg = (String) session.getAttribute("successMessage");
    if (msg != null) {
    %>
    <script>
    Swal.fire({
        icon: 'success',
        title: 'Success',
        text: '<%= msg %>',
        confirmButtonColor: '#16a34a'
    });
    </script>
    <%
    session.removeAttribute("successMessage");
    }
    %>

    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="page-title">My Properties</h1>
        <a href="add-property.jsp" class="add-property-btn">
            <i class="fas fa-plus me-2"></i> Add New Property
        </a>
    </div>

    <%
    List<Property> properties = (List<Property>) request.getAttribute("properties");
    %>

    <% if (properties == null || properties.isEmpty()) { %>

        <div class="no-properties">
            <i class="fas fa-home"></i>
            <h4>No Properties Found</h4>
            <p class="text-muted mb-4">You haven't listed any properties yet. Start by adding your first property.</p>
            <a href="add-property.jsp" class="add-property-btn">
                <i class="fas fa-plus me-2"></i> Add Your First Property
            </a>
        </div>

    <% } else { %>

        <!-- Properties Grid -->
        <div class="row">
            <% for(Property p : properties) { 
                String badgeClass = "property-badge";
                if ("RENT".equals(p.getPurpose())) {
                    badgeClass += " rent";
                } else if ("SOLD".equals(p.getPropetystatus())) {
                    badgeClass += " sold";
                } else if ("PENDING".equals(p.getPropetystatus())) {
                    badgeClass += " pending";
                }
                
                String statusClass = "";
                if ("APPROVED".equals(p.getPropetystatus())) {
                    statusClass = "status-approved";
                } else if ("PENDING".equals(p.getPropetystatus())) {
                    statusClass = "status-pending";
                } else if ("REJECTED".equals(p.getPropetystatus())) {
                    statusClass = "status-rejected";
                }
                
                String verificationClass = "";
                if ("VERIFIED".equals(p.getVerification())) {
                    verificationClass = "verification-verified";
                } else if ("PENDING".equals(p.getVerification())) {
                    verificationClass = "verification-pending";
                }
            %>
            <div class="col-lg-4 col-md-6">
                <div class="property-card">
                    <!-- Property Image -->
                    <div class="property-image-container">
                        <% if (p.getImages() != null && !p.getImages().isEmpty()) { 
                            PropertyImage firstImage = p.getImages().get(0);
                        %>
                            <img src="property-image?id=<%= firstImage.getImageId() %>" 
                                 class="property-image" 
                                 alt="<%= p.getTitle() %>">
                        <% } else { %>
                            <div class="no-image">
                                <i class="fas fa-home"></i>
                            </div>
                        <% } %>
                        <div class="<%= badgeClass %>">
                            <%= "RENT".equals(p.getPurpose()) ? "FOR RENT" : "FOR SALE" %>
                        </div>
                    </div>
                    
                    <!-- Property Details -->
                    <div class="property-content">
                        <h3 class="property-title"><%= p.getTitle() %></h3>
                        
                        <div class="property-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <%= p.getCity() != null ? p.getCity() : "" %>
                            <%= p.getState() != null ? ", " + p.getState() : "" %>
                        </div>
                        
                        <div class="property-price">₹ <%= p.getPrice() %></div>
                        
                        <div class="property-meta">
                            <% if (p.getBedrooms() > 0) { %>
                            <div class="meta-item">
                                <i class="fas fa-bed"></i>
                                <span><%= p.getBedrooms() %> Beds</span>
                            </div>
                            <% } %>
                            
                            <% if (p.getBathrooms() > 0) { %>
                            <div class="meta-item">
                                <i class="fas fa-bath"></i>
                                <span><%= p.getBathrooms() %> Baths</span>
                            </div>
                            <% } %>
                            
                            <% if (p.getAreaSqarefit() > 0) { %>
                            <div class="meta-item">
                                <i class="fas fa-ruler-combined"></i>
                                <span><%= p.getAreaSqarefit() %> sqft</span>
                            </div>
                            <% } %>
                        </div>
                        
                        <div class="property-status">
                            <span class="status-badge <%= statusClass %>">
                                <%= p.getPropetystatus() %>
                            </span>
                            
                            <% if (p.getVerification() != null) { %>
                            <span class="verification-badge <%= verificationClass %>">
                                <%= p.getVerification() %>
                            </span>
                            <% } %>
                        </div>
                        
                        <!-- Action Buttons -->
                        <div class="action-buttons">
                            <!-- Edit Button -->
                            <a href="property-edit?id=<%= p.getId() %>" class="btn-edit">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            
                            <!-- Delete Button with Confirmation -->
                            <button class="btn-delete" onclick="showDeleteConfirmation('<%= p.getId() %>', '<%= p.getTitle() %>')">
                                <i class="fas fa-trash-alt"></i> Delete
                            </button>
                        </div>
                        
                        <!-- View Details Button -->
                        <a href="property-details?id=<%= p.getId() %>" class="btn-view">
                            <i class="fas fa-eye"></i> View Details
                        </a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>

    <% } %>

</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">
                    <i class="fas fa-exclamation-triangle me-2"></i>Confirm Delete
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the property "<span id="propertyTitle"></span>"?</p>
                <p class="text-danger small"><i class="fas fa-exclamation-circle me-1"></i>This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-cancel" data-bs-dismiss="modal">Cancel</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-confirm-delete">
                    <i class="fas fa-trash-alt me-1"></i> Delete Property
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
// Show delete confirmation modal
function showDeleteConfirmation(propertyId, propertyTitle) {
    document.getElementById('propertyTitle').textContent = propertyTitle;
    document.getElementById('confirmDeleteBtn').href = 'property-delete?id=' + propertyId;
    
    const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
    deleteModal.show();
}

// Alternative: SweetAlert confirmation (if you prefer)
function confirmDelete(propertyId, propertyTitle) {
    Swal.fire({
        title: 'Delete Property?',
        html: `Are you sure you want to delete <b>"${propertyTitle}"</b>?`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc2626',
        cancelButtonColor: '#6b7280',
        confirmButtonText: 'Yes, delete it!',
        cancelButtonText: 'Cancel'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = 'property-delete?id=' + propertyId;
        }
    });
}
</script>

</body>
</html>