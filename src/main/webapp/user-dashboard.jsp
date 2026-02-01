<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="java.util.*" %>
<%@ page import="com.realestate.model.Inquiry" %>
<%@ page import="com.realestate.enums.InquiryStatus" %>
<%@ page import="com.realestate.enums.PropertyVerificationStatus" %>

<%@ include file="/Header.jsp" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String mode = request.getParameter("mode");
    if (mode == null) mode = "BUYER";

    List<Property> myProperties = (List<Property>) request.getAttribute("myProperties");
    Long totalProperties = (Long) request.getAttribute("totalProperties");
    
    // FIXED: Changed from Integer to Long
    Long pendingCount = (Long) request.getAttribute("pendingCount");
    Long approvedCount = (Long) request.getAttribute("approvedCount");
    Long rejectedCount = (Long) request.getAttribute("rejectedCount");
    
    List<Inquiry> buyerInquiries = (List<Inquiry>) request.getAttribute("buyerInquiries");
    List<Inquiry> sellerInquiries = (List<Inquiry>) request.getAttribute("sellerInquiries");
    
    // Calculate statistics
    int totalInquiriesSent = buyerInquiries != null ? buyerInquiries.size() : 0;
    int responsesReceived = buyerInquiries != null ? 
        (int) buyerInquiries.stream().filter(i -> InquiryStatus.REPLIED.name().equals(i.getStatus())).count() : 0;
%>

<!DOCTYPE html>
<html>
<head>
<title>User Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

<style>
/* Modern Dashboard Styling */
:root {
    --primary: #0f766e;
    --primary-dark: #115e59;
    --secondary: #2563eb;
    --light-bg: #f8fafc;
    --card-shadow: 0 4px 14px rgba(0,0,0,0.08);
}

body {
    background-color: var(--light-bg);
    font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
}

.container {
    max-width: 1400px;
}

/* Dashboard Header */
.dashboard-header {
    background: linear-gradient(135deg, var(--primary), var(--secondary));
    border-radius: 16px;
    padding: 30px;
    color: white;
    margin-bottom: 30px;
    box-shadow: var(--card-shadow);
    position: relative;
    overflow: hidden;
}

.dashboard-header::before {
    content: '';
    position: absolute;
    top: 0;
    right: 0;
    width: 300px;
    height: 300px;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 70%);
}

.dashboard-header h1 {
    font-weight: 800;
    margin-bottom: 8px;
    font-size: 2.2rem;
}

.dashboard-header .user-role {
    background: rgba(255, 255, 255, 0.15);
    padding: 6px 16px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 600;
    display: inline-block;
}

.mode-switcher {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    padding: 6px;
    display: inline-flex;
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255,255,255,0.2);
}

.mode-btn {
    padding: 10px 24px;
    border: none;
    border-radius: 10px;
    font-weight: 600;
    transition: all 0.3s ease;
    color: white;
    background: transparent;
    font-size: 15px;
}

.mode-btn:hover {
    background: rgba(255, 255, 255, 0.2);
    transform: translateY(-2px);
}

.mode-btn.active {
    background: white;
    color: var(--primary);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

/* Stat Cards */
.stat-card {
    background: white;
    border-radius: 16px;
    padding: 25px;
    box-shadow: var(--card-shadow);
    transition: all 0.3s ease;
    height: 100%;
    border: 1px solid #e2e8f0;
    position: relative;
    overflow: hidden;
}

.stat-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, var(--primary), var(--secondary));
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0,0,0,0.12);
}

.stat-icon {
    width: 60px;
    height: 60px;
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    margin-bottom: 20px;
    box-shadow: 0 4px 12px rgba(15, 118, 110, 0.15);
}

.stat-number {
    font-size: 2.8rem;
    font-weight: 800;
    color: var(--primary);
    margin-bottom: 8px;
    line-height: 1;
}

.stat-label {
    color: #64748b;
    font-size: 14px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

/* Dashboard Box */
.dashboard-box {
    background: white;
    border-radius: 16px;
    padding: 28px;
    box-shadow: var(--card-shadow);
    margin-bottom: 30px;
    border: 1px solid #e2e8f0;
    position: relative;
}

.dashboard-box h4 {
    color: #1e293b;
    font-weight: 700;
    margin-bottom: 8px;
}

/* Tabs */
.tab-buttons {
    background: #f8fafc;
    border-radius: 12px;
    padding: 8px;
    display: inline-flex;
    margin-bottom: 25px;
}

.tab-btn {
    padding: 12px 24px;
    border-radius: 10px;
    font-weight: 600;
    margin-right: 8px;
    transition: all 0.3s ease;
    border: none;
    background: transparent;
    color: #64748b;
    font-size: 15px;
}

.tab-btn:hover {
    background: white;
    color: var(--primary);
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

.tab-btn.active {
    background: white;
    color: var(--primary);
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

/* Property Card */
.property-card {
    background: white;
    border-radius: 14px;
    overflow: hidden;
    box-shadow: var(--card-shadow);
    transition: all 0.3s ease;
    height: 100%;
    border: 1px solid #e2e8f0;
}

.property-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.15);
}

.property-image-container {
    height: 200px;
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
    height: 200px;
    background: linear-gradient(135deg, #f8fafc, #e2e8f0);
    display: flex;
    align-items: center;
    justify-content: center;
    color: #94a3b8;
    font-size: 2.5rem;
}

.property-badge {
    position: absolute;
    top: 15px;
    left: 15px;
    background: var(--primary);
    color: white;
    padding: 6px 15px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.5px;
}

/* Inquiry Table */
.inquiry-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
}

.inquiry-table thead {
    background: linear-gradient(135deg, #f8fafc, #e2e8f0);
}

.inquiry-table th {
    padding: 18px 16px;
    text-align: left;
    font-weight: 700;
    color: #475569;
    border-bottom: 2px solid #e2e8f0;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.inquiry-table td {
    padding: 18px 16px;
    border-bottom: 1px solid #e2e8f0;
    vertical-align: middle;
}

.inquiry-table tbody tr {
    transition: background-color 0.2s ease;
}

.inquiry-table tbody tr:hover {
    background-color: #f8fafc;
}

.inquiry-table tbody tr:last-child td {
    border-bottom: none;
}

/* Status Badges */
.status-badge {
    padding: 8px 16px;
    border-radius: 8px;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: 0.3px;
    display: inline-block;
}

.status-pending {
    background: linear-gradient(135deg, #fef9c3, #fde68a);
    color: #92400e;
}

.status-replied {
    background: linear-gradient(135deg, #dcfce7, #bbf7d0);
    color: #166534;
}

.status-read {
    background: linear-gradient(135deg, #e0f2fe, #bae6fd);
    color: #1e40af;
}

/* Empty State */
.empty-state {
    padding: 80px 30px;
    text-align: center;
    background: white;
    border-radius: 16px;
    border: 2px dashed #e2e8f0;
}

.empty-state i {
    font-size: 4.5rem;
    color: #cbd5e1;
    margin-bottom: 25px;
    opacity: 0.6;
}

.empty-state h5 {
    color: #475569;
    font-weight: 700;
    margin-bottom: 12px;
}

.empty-state p {
    color: #94a3b8;
    font-size: 15px;
    max-width: 400px;
    margin: 0 auto 25px;
}

/* Action Buttons */
.action-buttons {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}

.action-btn {
    padding: 14px 28px;
    border-radius: 12px;
    font-weight: 700;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    transition: all 0.3s ease;
    font-size: 15px;
    border: none;
    cursor: pointer;
}

.action-btn-primary {
    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    color: white;
    box-shadow: 0 4px 14px rgba(15, 118, 110, 0.3);
}

.action-btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(15, 118, 110, 0.4);
    color: white;
}

.action-btn-secondary {
    background: white;
    color: var(--primary);
    border: 2px solid var(--primary);
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.action-btn-secondary:hover {
    background: #f0f9ff;
    transform: translateY(-3px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    color: var(--primary);
}

/* Property Status */
.property-status {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 6px;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.status-approved {
    background: linear-gradient(135deg, #dcfce7, #bbf7d0);
    color: #166534;
}

.status-pending-property {
    background: linear-gradient(135deg, #fef9c3, #fde68a);
    color: #92400e;
}

.status-rejected {
    background: linear-gradient(135deg, #fee2e2, #fecaca);
    color: #991b1b;
}

/* Property Actions */
.property-actions {
    display: flex;
    gap: 10px;
    margin-top: 20px;
}

.property-actions .btn {
    flex: 1;
    padding: 10px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

/* Responsive */
@media (max-width: 768px) {
    .dashboard-header {
        padding: 25px 20px;
    }
    
    .dashboard-header h1 {
        font-size: 1.8rem;
    }
    
    .stat-card {
        padding: 20px;
    }
    
    .stat-number {
        font-size: 2.2rem;
    }
    
    .dashboard-box {
        padding: 20px;
    }
    
    .action-buttons {
        flex-direction: column;
    }
    
    .action-btn {
        width: 100%;
    }
    
    .property-actions {
        flex-direction: column;
    }
    
    .tab-buttons {
        width: 100%;
        overflow-x: auto;
        padding-bottom: 5px;
    }
    
    .tab-btn {
        white-space: nowrap;
    }
}

/* Loading Animation */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

.dashboard-box, .stat-card {
    animation: fadeIn 0.5s ease-out;
}
</style>
</head>

<body>

<div class="container mt-4 mb-5">

<!-- ================= DASHBOARD HEADER ================= -->
<div class="dashboard-header">
    <div class="row align-items-center">
        <div class="col-md-8">
            <div class="d-flex align-items-center mb-3">
                <div class="user-avatar me-3" style="width: 60px; height: 60px; background: linear-gradient(135deg, #f8fafc, #e2e8f0); border-radius: 15px; display: flex; align-items: center; justify-content: center; font-size: 24px; font-weight: 700; color: var(--primary);">
                    <%= user.getName().substring(0, 1).toUpperCase() %>
                </div>
                <div>
                    <h1>Welcome, <%= user.getName() %>!</h1>
                    <div class="d-flex align-items-center gap-2">
                        <span class="user-role">
                            <i class="fas fa-user-circle me-2"></i><%= mode.equals("BUYER") ? "Buyer" : "Seller" %> Account
                        </span>
                        <span class="user-role">
                            <i class="fas fa-envelope me-2"></i><%= user.getEmail() %>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4 text-md-end">
            <div class="mode-switcher">
                <a href="dashboard?mode=BUYER" 
                   class="mode-btn <%= mode.equals("BUYER") ? "active" : "" %>">
                    <i class="fas fa-shopping-cart me-2"></i>Buyer Mode
                </a>
                <a href="dashboard?mode=SELLER" 
                   class="mode-btn <%= mode.equals("SELLER") ? "active" : "" %>">
                    <i class="fas fa-home me-2"></i>Seller Mode
                </a>
            </div>
        </div>
    </div>
</div>

<!-- ================= BUYER DASHBOARD ================= -->
<% if ("BUYER".equals(mode)) { %>

<div class="dashboard-box">
    <!-- Header Section -->
    <div class="row align-items-center mb-4">
        <div class="col-md-6">
            <h4 class="mb-1">Buyer Dashboard</h4>
            <p class="text-muted mb-0">Track your property inquiries and explore new listings</p>
        </div>
        <div class="col-md-6 text-md-end">
            <div class="action-buttons justify-content-md-end">
                <a href="property" class="action-btn action-btn-primary">
                    <i class="fas fa-search me-2"></i>Browse Properties
                </a>
            </div>
        </div>
    </div>

    <!-- Buyer Statistics -->
    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, #e0f2fe, #bae6fd); color: #2563eb;">
                    <i class="fas fa-paper-plane"></i>
                </div>
                <div class="stat-number"><%= totalInquiriesSent %></div>
                <div class="stat-label">Inquiries Sent</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, #dcfce7, #bbf7d0); color: #16a34a;">
                    <i class="fas fa-reply"></i>
                </div>
                <div class="stat-number"><%= responsesReceived %></div>
                <div class="stat-label">Responses Received</div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, #fef9c3, #fde68a); color: #d97706;">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-number"><%= totalInquiriesSent - responsesReceived %></div>
                <div class="stat-label">Pending Responses</div>
            </div>
        </div>
    </div>

    <!-- Tabs -->
    <div class="mb-4">
        <div class="tab-buttons">
            <button class="tab-btn active" onclick="showTab('buyerInquiries')">
                <i class="fas fa-envelope me-2"></i>My Inquiries
            </button>
        </div>
    </div>

    <!-- Buyer Inquiries -->
    <div id="buyerInquiriesTab">
        <% if (buyerInquiries != null && !buyerInquiries.isEmpty()) { %>
            <div class="dashboard-box">
                <h5 class="mb-4"><i class="fas fa-envelope me-2"></i>My Sent Inquiries</h5>
                <div class="table-responsive">
                    <table class="inquiry-table">
                        <thead>
                            <tr>
                                <th>Property</th>
                                <th>Seller</th>
                                <th>Message</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Inquiry inquiry : buyerInquiries) { 
                                Property property = inquiry.getProperty();
                                User seller = inquiry.getReceiver();
                                String statusClass = "";
                                if ("PENDING".equals(inquiry.getStatus())) {
                                    statusClass = "status-pending";
                                } else if ("REPLIED".equals(inquiry.getStatus())) {
                                    statusClass = "status-replied";
                                } else if ("READ".equals(inquiry.getStatus())) {
                                    statusClass = "status-read";
                                }
                            %>
                            <tr>
                                <td>
                                    <strong><%= property.getTitle() %></strong><br>
                                    <small class="text-muted"><i class="fas fa-map-marker-alt me-1"></i><%= property.getCity() %></small>
                                </td>
                                <td>
                                    <strong><%= seller.getName() %></strong><br>
                                    <small class="text-muted"><i class="fas fa-envelope me-1"></i><%= seller.getEmail() %></small>
                                </td>
                                <td><%= inquiry.getMessage() %></td>
                                
                                <td>
                                    <span class="status-badge <%= statusClass %>">
                                        <%= inquiry.getStatus() %>
                                    </span>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        <% } else { %>
            <div class="empty-state">
                <i class="fas fa-envelope-open-text"></i>
                <h5 class="mt-4">No Inquiries Yet</h5>
                <p>You haven't sent any inquiries yet. Start by browsing properties.</p>
                <a href="property" class="action-btn action-btn-primary mt-3">
                    <i class="fas fa-search me-2"></i>Browse Properties
                </a>
            </div>
        <% } %>
    </div>
</div>

<% } %>

<!-- ================= SELLER DASHBOARD ================= -->
<% if ("SELLER".equals(mode)) { %>

<div class="dashboard-box">
    <!-- Header Section -->
    <div class="row align-items-center mb-4">
        <div class="col-md-6">
            <h4 class="mb-1">Seller Dashboard</h4>
            <p class="text-muted mb-0">Manage your property listings and buyer inquiries</p>
        </div>
        <div class="col-md-6 text-md-end">
            <div class="action-buttons justify-content-md-end">
                <a href="add-property.jsp" class="action-btn action-btn-primary">
                    <i class="fas fa-plus me-2"></i>Add New Property
                </a>
                <a href="user-properties.jsp" class="action-btn action-btn-secondary">
                    <i class="fas fa-list me-2"></i>View All Properties
                </a>
            </div>
        </div>
    </div>

    <!-- Seller Statistics -->
    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, #e0f2fe, #bae6fd); color: #2563eb;">
                    <i class="fas fa-home"></i>
                </div>
                <div class="stat-number"><%= totalProperties != null ? totalProperties : 0 %></div>
                <div class="stat-label">Total Properties</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, #fef9c3, #fde68a); color: #d97706;">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-number"><%= pendingCount != null ? pendingCount : 0 %></div>
                <div class="stat-label">Pending</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, #dcfce7, #bbf7d0); color: #16a34a;">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-number"><%= approvedCount != null ? approvedCount : 0 %></div>
                <div class="stat-label">Approved</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="stat-icon" style="background: linear-gradient(135deg, #fee2e2, #fecaca); color: #dc2626;">
                    <i class="fas fa-times-circle"></i>
                </div>
                <div class="stat-number"><%= rejectedCount != null ? rejectedCount : 0 %></div>
                <div class="stat-label">Rejected</div>
            </div>
        </div>
    </div>

    <!-- Tabs -->
    <div class="mb-4">
        <div class="tab-buttons">
            <button class="tab-btn active" onclick="showTab('properties')">
                <i class="fas fa-home me-2"></i>My Properties
            </button>
            <button class="tab-btn" onclick="showTab('inquiries')">
                <i class="fas fa-envelope me-2"></i>Buyer Inquiries
            </button>
        </div>
    </div>

    <!-- Properties Tab -->
    <div id="propertiesTab">
        <% if (myProperties != null && !myProperties.isEmpty()) { %>
            <div class="row g-4">
                <% for (Property property : myProperties) { 
                    String statusClass = "";
                    if ("APPROVED".equals(property.getPropetystatus())) {
                        statusClass = "status-approved";
                    } else if ("PENDING".equals(property.getPropetystatus())) {
                        statusClass = "status-pending-property";
                    } else if ("REJECTED".equals(property.getPropetystatus())) {
                        statusClass = "status-rejected";
                    }
                %>
                <div class="col-lg-4 col-md-6">
                    <div class="property-card">
                        <!-- Property Image -->
                        <div class="property-image-container">
                            <% if (property.getImages() != null && !property.getImages().isEmpty()) { %>
                                <img src="property-image?id=<%= property.getImages().get(0).getImageId() %>" 
                                     class="property-image" alt="<%= property.getTitle() %>">
                            <% } else { %>
                                <div class="no-image">
                                    <i class="fas fa-home"></i>
                                </div>
                            <% } %>
                            <div class="property-badge">
                                <%= "RENT".equals(property.getPurpose()) ? "FOR RENT" : "FOR SALE" %>
                            </div>
                        </div>
                        
                        <!-- Property Details -->
                        <div class="p-3">
                            <h6 class="fw-bold mb-2"><%= property.getTitle() %></h6>
                            <p class="text-muted mb-2">
                                <i class="fas fa-map-marker-alt me-1"></i>
                                <%= property.getCity() %>
                            </p>
                            
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div class="fw-bold" style="color: var(--primary); font-size: 1.25rem;">₹ <%= property.getPrice() %></div>
                                <span class="property-status <%= statusClass %>">
                                    <%= property.getPropetystatus() %>
                                </span>
                            </div>
                            
                            <div class="property-actions">
                                <a href="property-edit?id=<%= property.getId() %>" 
                                   class="btn btn-outline-primary btn-sm">
                                    <i class="fas fa-edit me-1"></i> Edit
                                </a>
                                <a href="property-delete?id=<%= property.getId() %>" 
                                   onclick="return confirm('Are you sure you want to delete this property?')"
                                   class="btn btn-outline-danger btn-sm">
                                    <i class="fas fa-trash-alt me-1"></i> Delete
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            
            <div class="text-center mt-5">
                <a href="user-properties.jsp" class="action-btn action-btn-secondary">
                    <i class="fas fa-list me-2"></i>View All Properties
                </a>
            </div>
            
        <% } else { %>
            <div class="empty-state">
                <i class="fas fa-home"></i>
                <h5 class="mt-4">No Properties Listed</h5>
                <p>You haven't listed any properties yet. Start by adding your first property.</p>
                <a href="add-property.jsp" class="action-btn action-btn-primary mt-3">
                    <i class="fas fa-plus me-2"></i>Add Your First Property
                </a>
            </div>
        <% } %>
    </div>

    <!-- Inquiries Tab -->
    <div id="inquiriesTab" style="display: none;">
        <% if (sellerInquiries != null && !sellerInquiries.isEmpty()) { %>
            <div class="dashboard-box">
                <h5 class="mb-4"><i class="fas fa-envelope me-2"></i>Buyer Inquiries</h5>
                <div class="table-responsive">
                    <table class="inquiry-table">
                        <thead>
                            <tr>
                                <th>Property</th>
                                <th>Buyer</th>
                                <th>Message</th>
                                <th>Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Inquiry inquiry : sellerInquiries) { 
                                Property property = inquiry.getProperty();
                                User buyer = inquiry.getSender();
                                String statusClass = "";
                                if ("PENDING".equals(inquiry.getStatus())) {
                                    statusClass = "status-pending";
                                } else if ("REPLIED".equals(inquiry.getStatus())) {
                                    statusClass = "status-replied";
                                } else if ("READ".equals(inquiry.getStatus())) {
                                    statusClass = "status-read";
                                }
                            %>
                            <tr>
                                <td>
                                    <strong><%= property.getTitle() %></strong><br>
                                    <small class="text-muted"><i class="fas fa-map-marker-alt me-1"></i><%= property.getCity() %></small>
                                </td>
                                <td>
                                    <strong><%= buyer.getName() %></strong><br>
                                    <small class="text-muted"><i class="fas fa-envelope me-1"></i><%= buyer.getEmail() %></small>
                                </td>
                                <td><%= inquiry.getMessage() %></td>
                                
                                <td>
                                    <span class="status-badge <%= statusClass %>">
                                        <%= inquiry.getStatus() %>
                                    </span>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        <% } else { %>
            <div class="empty-state">
                <i class="fas fa-envelope-open-text"></i>
                <h5 class="mt-4">No Inquiries Yet</h5>
                <p>You haven't received any inquiries yet. List more properties to attract buyers.</p>
                <a href="add-property.jsp" class="action-btn action-btn-primary mt-3">
                    <i class="fas fa-plus me-2"></i>Add New Property
                </a>
            </div>
        <% } %>
    </div>
</div>

<% } %>

</div>

<script>
// Tab Switching Functionality
function showTab(tabName) {
    // Remove active class from all tab buttons
    const tabButtons = document.querySelectorAll('.tab-btn');
    tabButtons.forEach(btn => btn.classList.remove('active'));
    
    // Add active class to clicked button
    event.target.classList.add('active');
    
    // Show/hide tabs based on mode
    <% if ("BUYER".equals(mode)) { %>
        if (tabName === 'buyerInquiries') {
            document.getElementById('buyerInquiriesTab').style.display = 'block';
        }
    <% } else { %>
        if (tabName === 'properties') {
            document.getElementById('propertiesTab').style.display = 'block';
            document.getElementById('inquiriesTab').style.display = 'none';
        } else if (tabName === 'inquiries') {
            document.getElementById('propertiesTab').style.display = 'none';
            document.getElementById('inquiriesTab').style.display = 'block';
        }
    <% } %>
}

// Initialize tooltips
document.addEventListener('DOMContentLoaded', function() {
    // Add any initialization code here
});

// Confirmation for delete actions
function confirmDelete(message) {
    return confirm(message || 'Are you sure you want to delete this item?');
}
</script>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>