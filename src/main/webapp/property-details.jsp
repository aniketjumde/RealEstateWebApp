<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.enums.PropertyVerificationStatus" %>

<%
Property property = (Property) request.getAttribute("property");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title><%= property.getTitle() %> | RealEstate</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
    :root {
        --primary: #0f766e;
        --primary-dark: #115e59;
        --secondary: #2563eb;
        --light-bg: #f8fafc;
        --dark-text: #1e293b;
        --light-text: #64748b;
        --success: #16a34a;
        --warning: #f59e0b;
        --danger: #dc2626;
    }
    
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
        margin: 0;
        min-height: 100vh;
    }
    
    .property-container {
        max-width: 1200px;
        margin: 0 auto;
        background: white;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 20px 60px rgba(0,0,0,0.1);
    }
    
    .property-header {
        padding: 40px;
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: white;
        position: relative;
    }
    
    .property-header h2 {
        font-size: 2.5rem;
        font-weight: 800;
        margin-bottom: 10px;
        max-width: 800px;
        line-height: 1.3;
    }
    
    .property-badge {
        display: inline-block;
        background: rgba(255,255,255,0.2);
        padding: 8px 20px;
        border-radius: 25px;
        font-weight: 600;
        font-size: 0.9rem;
        margin-bottom: 20px;
        backdrop-filter: blur(10px);
    }
    
    .property-price {
        font-size: 2rem;
        font-weight: 800;
        color: white;
        margin-bottom: 10px;
    }
    
    .property-location {
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 1.1rem;
        opacity: 0.9;
    }
    
    .property-location i {
        color: rgba(255,255,255,0.8);
    }
    
    .property-content {
        padding: 40px;
        display: grid;
        grid-template-columns: 2fr 1fr;
        gap: 40px;
    }
    
    .property-images {
        margin-bottom: 30px;
    }
    
    .main-image {
        width: 100%;
        height: 400px;
        border-radius: 15px;
        overflow: hidden;
        margin-bottom: 20px;
    }
    
    .main-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
    
    .main-image:hover img {
        transform: scale(1.05);
    }
    
    .image-thumbnails {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 10px;
    }
    
    .thumbnail {
        height: 100px;
        border-radius: 10px;
        overflow: hidden;
        cursor: pointer;
        opacity: 0.7;
        transition: all 0.3s ease;
        border: 2px solid transparent;
    }
    
    .thumbnail:hover, .thumbnail.active {
        opacity: 1;
        transform: translateY(-5px);
        border-color: var(--primary);
    }
    
    .thumbnail img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .property-details {
        margin-bottom: 40px;
    }
    
    .section-title {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--dark-text);
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 3px solid var(--primary);
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .section-title i {
        color: var(--primary);
    }
    
    .description {
        color: var(--light-text);
        line-height: 1.7;
        font-size: 1.1rem;
        margin-bottom: 30px;
    }
    
    .features-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .feature-item {
        display: flex;
        align-items: center;
        gap: 15px;
        padding: 20px;
        background: #f8fafc;
        border-radius: 10px;
        border: 1px solid #e2e8f0;
        transition: all 0.3s ease;
    }
    
    .feature-item:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .feature-icon {
        width: 50px;
        height: 50px;
        background: rgba(15, 118, 110, 0.1);
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--primary);
        font-size: 1.2rem;
    }
    
    .feature-text {
        flex: 1;
    }
    
    .feature-label {
        font-size: 0.9rem;
        color: var(--light-text);
        margin-bottom: 5px;
    }
    
    .feature-value {
        font-weight: 700;
        color: var(--dark-text);
        font-size: 1.1rem;
    }
    
    /* SIDEBAR */
    .sidebar {
        background: #f8fafc;
        padding: 30px;
        border-radius: 15px;
        border: 1px solid #e2e8f0;
        height: fit-content;
        position: sticky;
        top: 20px;
    }
    
    .owner-info {
        text-align: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 1px solid #e2e8f0;
    }
    
    .owner-avatar {
        width: 80px;
        height: 80px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.8rem;
        font-weight: 700;
        margin: 0 auto 15px;
    }
    
    .owner-name {
        font-weight: 700;
        font-size: 1.2rem;
        color: var(--dark-text);
        margin-bottom: 5px;
    }
    
    .owner-role {
        color: var(--light-text);
        font-size: 0.9rem;
    }
    
    /* INQUIRY BOX - SAME FUNCTIONALITY */
    .inquiry-box {
        margin-top: 30px;
    }
    
    .inquiry-box h3 {
        font-size: 1.3rem;
        font-weight: 700;
        color: var(--dark-text);
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .inquiry-box textarea {
        width: 100%;
        padding: 15px;
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        font-family: inherit;
        font-size: 1rem;
        margin-bottom: 15px;
        resize: vertical;
        min-height: 120px;
        transition: border-color 0.3s ease;
    }
    
    .inquiry-box textarea:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.1);
    }
    
    .inquiry-box button {
        width: 100%;
        padding: 15px;
        background: linear-gradient(135deg, var(--primary), var(--secondary));
        color: white;
        border: none;
        border-radius: 10px;
        font-weight: 600;
        font-size: 1.1rem;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }
    
    .inquiry-box button:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(15, 118, 110, 0.3);
    }
    
    .login-prompt {
        text-align: center;
        padding: 20px;
        background: #fef3c7;
        border-radius: 10px;
        color: #92400e;
        margin-top: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }
    
    .login-prompt a {
        color: var(--primary);
        font-weight: 600;
        text-decoration: none;
        transition: color 0.3s ease;
    }
    
    .login-prompt a:hover {
        color: var(--secondary);
        text-decoration: underline;
    }
    
    .back-button {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        padding: 12px 25px;
        background: #f1f5f9;
        color: var(--primary);
        text-decoration: none;
        border-radius: 10px;
        font-weight: 600;
        margin-top: 30px;
        transition: all 0.3s ease;
    }
    
    .back-button:hover {
        background: var(--primary);
        color: white;
        transform: translateX(-5px);
    }
    
    .verification-status {
        padding: 20px;
        background: #f1f5f9;
        border-radius: 10px;
        margin-top: 30px;
    }
    
    .status-label {
        font-weight: 600;
        color: var(--dark-text);
        margin-bottom: 10px;
        display: block;
    }
    
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        padding: 8px 16px;
        border-radius: 20px;
        font-weight: 600;
        font-size: 0.9rem;
    }
    
    .status-approved {
        background: #d1fae5;
        color: #065f46;
    }
    
    .status-pending {
        background: #fef3c7;
        color: #92400e;
    }
    
    .status-rejected {
        background: #fee2e2;
        color: #991b1b;
    }
    
    .property-actions {
        display: flex;
        gap: 15px;
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid #e2e8f0;
    }
    
    .action-btn {
        flex: 1;
        padding: 12px;
        border: 2px solid #e2e8f0;
        background: white;
        color: var(--primary);
        border-radius: 8px;
        font-weight: 600;
        text-decoration: none;
        text-align: center;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }
    
    .action-btn:hover {
        background: var(--primary);
        color: white;
        border-color: var(--primary);
        transform: translateY(-2px);
    }
    
    .no-images {
        height: 400px;
        background: linear-gradient(135deg, #f8fafc, #e2e8f0);
        border-radius: 15px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--light-text);
        font-size: 1.2rem;
    }
    
    @media (max-width: 992px) {
        .property-content {
            grid-template-columns: 1fr;
            gap: 30px;
        }
        
        .main-image {
            height: 300px;
        }
        
        .image-thumbnails {
            grid-template-columns: repeat(3, 1fr);
        }
    }
    
    @media (max-width: 768px) {
        .property-header {
            padding: 30px 20px;
        }
        
        .property-header h2 {
            font-size: 2rem;
        }
        
        .features-grid {
            grid-template-columns: 1fr;
        }
        
        .property-content {
            padding: 30px 20px;
        }
        
        .property-actions {
            flex-direction: column;
        }
    }
</style>
</head>
<body>
<%@ include file="/Header.jsp" %>
<%
 loggedUser = (User) session.getAttribute("user");
%>
<div class="property-container">

    <!-- ENHANCED HEADER -->
    <div class="property-header">
        <div class="property-badge">
            <%= property.getPropetystatus() %>
        </div>
        <h2><%= property.getTitle() %></h2>
        <div class="property-price">₹ <%= property.getPrice() %></div>
        <div class="property-location">
            <i class="fas fa-map-marker-alt"></i>
            <%= property.getCity() %>, <%= property.getState() %>
        </div>
    </div>
    
    <div class="property-content">
        <!-- MAIN CONTENT -->
        <div class="main-content">
            <!-- IMAGES -->
            <div class="property-images">
                <div class="main-image">
                    <%
                    if (property.getImages() != null && !property.getImages().isEmpty()) {
                    %>
                        <img src="property-image?id=<%= property.getImages().get(0).getImageId() %>" 
                             id="mainImage" alt="<%= property.getTitle() %>">
                    <%
                    } else {
                    %>
                        <div class="no-images">
                            <i class="fas fa-image fa-3x mb-3"></i>
                            <p>No images available</p>
                        </div>
                    <%
                    }
                    %>
                </div>
                
                <% if (property.getImages() != null && property.getImages().size() > 1) { %>
                <div class="image-thumbnails" id="thumbnailContainer">
                    <%
                    for (int i = 0; i < Math.min(property.getImages().size(), 4); i++) {
                    %>
                        <div class="thumbnail <%= i == 0 ? "active" : "" %>" 
                             onclick="changeMainImage('<%= property.getImages().get(i).getImageId() %>', this)">
                            <img src="property-image?id=<%= property.getImages().get(i).getImageId() %>" 
                                 alt="Property Image <%= i+1 %>">
                        </div>
                    <%
                    }
                    %>
                </div>
                <% } %>
            </div>
            
            <!-- DESCRIPTION -->
            <div class="property-details">
                <h3 class="section-title">
                    <i class="fas fa-align-left"></i> Description
                </h3>
                <div class="description">
                    <%= property.getDescription() != null && !property.getDescription().isEmpty() ? 
                        property.getDescription() : "No description available for this property." %>
                </div>
            </div>
            
            <!-- FEATURES -->
            <div class="property-details">
                <h3 class="section-title">
                    <i class="fas fa-list"></i> Property Features
                </h3>
                <div class="features-grid">
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <div class="feature-text">
                            <div class="feature-label">Property Type</div>
                            <div class="feature-value"><%= property.getPropertyType() %></div>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-tag"></i>
                        </div>
                        <div class="feature-text">
                            <div class="feature-label">Purpose</div>
                            <div class="feature-value"><%= "SELL".equals(property.getPurpose()) ? "For Sale" : "For Rent" %></div>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-bed"></i>
                        </div>
                        <div class="feature-text">
                            <div class="feature-label">Bedrooms</div>
                            <div class="feature-value"><%= property.getBedrooms() %></div>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-bath"></i>
                        </div>
                        <div class="feature-text">
                            <div class="feature-label">Bathrooms</div>
                            <div class="feature-value"><%= property.getBathrooms() %></div>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-ruler-combined"></i>
                        </div>
                        <div class="feature-text">
                            <div class="feature-label">Area</div>
                            <div class="feature-value"><%= property.getAreaSqarefit() %> sqft</div>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="feature-text">
                            <div class="feature-label">Status</div>
                            <div class="feature-value"><%= property.getPropetystatus() %></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- SIDEBAR -->
        <div class="sidebar">
            <!-- OWNER INFO -->
            <div class="owner-info">
                <div class="owner-avatar">
                    <%= property.getUser().getName().substring(0, 1).toUpperCase() %>
                </div>
                <div class="owner-name"><%= property.getUser().getName() %></div>
                <div class="owner-role">Property Owner</div>
            </div>
            
            <!-- INQUIRY FORM - SAME FUNCTIONALITY -->
            <%
            boolean canInquire =
                loggedUser != null &&
                !property.getUser().getId().equals(loggedUser.getId()) &&
                property.getVerification() == PropertyVerificationStatus.APPROVED;
            %>
            
            <% if (canInquire) { %>
            <div class="inquiry-box">
                <h3><i class="fas fa-envelope"></i> Contact Owner</h3>
                <form action="send-inquiry" method="post">
                    <input type="hidden" name="propertyId" value="<%= property.getId() %>">
                    <textarea name="message" 
                              placeholder="Write your message to the owner. Include your contact details and any specific questions..."
                              required></textarea>
                    <button type="submit">
                        <i class="fas fa-paper-plane me-2"></i> Send Inquiry
                    </button>
                </form>
            </div>
            <% } else if (loggedUser == null) { %>
            <div class="login-prompt">
                <i class="fas fa-info-circle"></i>
                <a href="login.jsp">Login</a> to contact the owner
            </div>
            <% } else if (property.getUser().getId().equals(loggedUser.getId())) { %>
            <div class="login-prompt">
                <i class="fas fa-info-circle"></i>
                This is your property
            </div>
            <% } %>
            
            <!-- VERIFICATION STATUS -->
            <div class="verification-status">
                <span class="status-label">Verification Status</span>
                <%
                String statusClass = "";
                String statusIcon = "";
                switch(property.getVerification()) {
                    case APPROVED:
                        statusClass = "status-badge status-approved";
                        statusIcon = "fas fa-check-circle";
                        break;
                    case PENDING:
                        statusClass = "status-badge status-pending";
                        statusIcon = "fas fa-clock";
                        break;
                    case REJECTED:
                        statusClass = "status-badge status-rejected";
                        statusIcon = "fas fa-times-circle";
                        break;
                    default:
                        statusClass = "status-badge";
                        statusIcon = "fas fa-question-circle";
                }
                %>
                <div class="<%= statusClass %>">
                    <i class="<%= statusIcon %>"></i>
                    <%= property.getVerification() %>
                </div>
            </div>
            
            <!-- PROPERTY ACTIONS -->
            <div class="property-actions">
                <a href="property" class="action-btn">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
                <% if (loggedUser != null && property.getUser().getId().equals(loggedUser.getId())) { %>
                <a href="property-edit?id=<%= property.getId() %>" class="action-btn">
                    <i class="fas fa-edit"></i> Edit Property
                </a>
                <% } %>
            </div>
        </div>
    </div>
</div>

<script>
    function changeMainImage(imageId, element) {
        const mainImage = document.getElementById('mainImage');
        if (mainImage) {
            mainImage.src = 'property-image?id=' + imageId;
        }
        
        // Update active thumbnail
        document.querySelectorAll('.thumbnail').forEach(thumb => {
            thumb.classList.remove('active');
        });
        element.classList.add('active');
    }
</script>

<%@ include file="/Footer.jsp" %>

</body>
</html>