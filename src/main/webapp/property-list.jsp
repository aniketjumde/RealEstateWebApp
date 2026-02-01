<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="com.realestate.model.User" %>
<%@ page import="com.realestate.enums.PropertyVerificationStatus" %>
<%@ include file="/Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Properties | RealEstate</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>

    /* ENHANCED STYLING WITH SAME FUNCTIONALITY */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
        margin: 0;
        padding: 20px;
        min-height: 100vh;
    }
    
    .container {
        max-width: 1400px;
        margin: 0 auto;
    }
    
    /* ENHANCED PAGE HEADER */
    .page-header {
        background: linear-gradient(135deg, #0f766e 0%, #0d6efd 100%);
        color: white;
        padding: 40px;
        border-radius: 20px;
        margin-bottom: 30px;
        text-align: center;
        position: relative;
        overflow: hidden;
    }
    
    .page-header:before {
        content: '';
        position: absolute;
        top: -50px;
        right: -50px;
        width: 200px;
        height: 200px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
    }
    
    .page-header h2 {
        font-size: 2.5rem;
        font-weight: 800;
        margin-bottom: 10px;
    }
    
    .page-header p {
        opacity: 0.9;
        font-size: 1.1rem;
        max-width: 600px;
        margin: 0 auto;
    }
    
    /* ENHANCED SEARCH BAR */
    .search-bar-container {
        background: white;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 15px 40px rgba(0,0,0,0.1);
        margin-bottom: 40px;
        position: relative;
        z-index: 10;
    }
    
    .search-title {
        font-size: 1.5rem;
        font-weight: 700;
        color: #1e293b;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .search-title i {
        color: #0f766e;
    }
    
    /* SAME FORM STRUCTURE WITH ENHANCED STYLING */
    .search-form {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        align-items: end;
    }
    
    .form-group {
        margin-bottom: 0;
    }
    
    .search-input,
    .search-select {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid #e2e8f0;
        border-radius: 10px;
        font-size: 1rem;
        font-family: inherit;
        transition: all 0.3s ease;
        box-sizing: border-box;
        background: white;
    }
    
    .search-input:focus,
    .search-select:focus {
        outline: none;
        border-color: #0f766e;
        box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.1);
    }
    
    .search-button {
        padding: 14px 30px;
        background: linear-gradient(135deg, #0f766e, #0d6efd);
        color: white;
        border: none;
        border-radius: 10px;
        font-weight: 600;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        height: 100%;
        min-height: 52px;
    }
    
    .search-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(15, 118, 110, 0.3);
    }
    
    .search-button:active {
        transform: translateY(0);
    }
    
    /* SEARCH RESULTS INFO */
    .results-info {
        background: white;
        padding: 20px 30px;
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .results-count {
        font-size: 1.2rem;
        font-weight: 600;
        color: #1e293b;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .results-count i {
        color: #0f766e;
    }
    
    .clear-search {
        padding: 10px 20px;
        background: #f1f5f9;
        color: #0f766e;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 600;
        font-size: 0.95rem;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .clear-search:hover {
        background: #0f766e;
        color: white;
        transform: translateY(-2px);
    }
    
    /* ENHANCED PROPERTY GRID - SAME STRUCTURE */
    .property-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
        gap: 25px;
        margin-bottom: 50px;
    }
    
    /* ENHANCED CARD */
    .property-card {
        background: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        transition: all 0.3s ease;
        position: relative;
        text-decoration: none;
        color: inherit;
        display: block;
        border: 1px solid rgba(255,255,255,0.2);
    }
    
    .property-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 20px 40px rgba(0,0,0,0.15);
        color: inherit;
    }
    
    /* ENHANCED IMAGE */
    .property-image {
        position: relative;
        height: 220px;
        overflow: hidden;
    }
    
    .property-image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
    
    .property-card:hover .property-image img {
        transform: scale(1.05);
    }
    
    /* ENHANCED BADGES */
    .property-badge {
        position: absolute;
        top: 15px;
        left: 15px;
        padding: 8px 18px;
        font-size: 0.85rem;
        font-weight: 700;
        border-radius: 25px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        z-index: 2;
    }
    
    .badge-available {
        background: linear-gradient(135deg, #10b981, #059669);
        color: white;
    }
    
    .badge-sold {
        background: linear-gradient(135deg, #ef4444, #dc2626);
        color: white;
    }
    
    .badge-rent {
        background: linear-gradient(135deg, #0d6efd, #2563eb);
        color: white;
    }
    
    .price-tag {
        position: absolute;
        bottom: 15px;
        left: 15px;
        background: rgba(255,255,255,0.95);
        padding: 10px 20px;
        border-radius: 10px;
        font-size: 1.3rem;
        font-weight: 800;
        color: #0f766e;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        backdrop-filter: blur(5px);
        z-index: 2;
    }
    
    /* ENHANCED BODY */
    .property-body {
        padding: 25px;
    }
    
    .property-title {
        font-size: 1.3rem;
        font-weight: 700;
        color: #1e293b;
        margin-bottom: 8px;
        line-height: 1.4;
    }
    
    .property-location {
        color: #64748b;
        font-size: 1rem;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .property-location i {
        color: #0f766e;
    }
    
    .property-meta {
        display: flex;
        justify-content: space-between;
        font-size: 0.95rem;
        color: #475569;
        background: #f8fafc;
        padding: 15px;
        border-radius: 10px;
        margin-bottom: 15px;
    }
    
    .property-meta span {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 5px;
    }
    
    .property-meta i {
        font-size: 1.2rem;
        color: #0f766e;
    }
    
    .property-purpose {
        padding: 8px 15px;
        background: #f1f5f9;
        color: #0f766e;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 600;
        display: inline-block;
        margin-top: 10px;
    }
    
    /* EMPTY STATE */
    .empty-state {
        text-align: center;
        padding: 80px 20px;
        background: white;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        margin-top: 30px;
    }
    
    .empty-state i {
        font-size: 4rem;
        margin-bottom: 20px;
        color: #cbd5e1;
    }
    
    .empty-state h3 {
        font-size: 1.8rem;
        font-weight: 600;
        margin-bottom: 10px;
        color: #475569;
    }
    
    .empty-state p {
        color: #64748b;
        margin-bottom: 30px;
        max-width: 500px;
        margin-left: auto;
        margin-right: auto;
    }
    
    .adjust-search-btn {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        padding: 12px 25px;
        background: linear-gradient(135deg, #0f766e, #0d6efd);
        color: white;
        text-decoration: none;
        border-radius: 10px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .adjust-search-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(15, 118, 110, 0.3);
    }
    
    /* BACK BUTTON */
    .back-button {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        padding: 12px 25px;
        background: #f1f5f9;
        color: #0f766e;
        text-decoration: none;
        border-radius: 10px;
        font-weight: 600;
        margin-top: 30px;
        transition: all 0.3s ease;
    }
    
    .back-button:hover {
        background: #0f766e;
        color: white;
        transform: translateX(-5px);
    }
    
    /* RESPONSIVE DESIGN */
    @media (max-width: 992px) {
        .property-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }
    
    @media (max-width: 768px) {
        .property-grid {
            grid-template-columns: 1fr;
        }
        
        .search-form {
            grid-template-columns: 1fr;
        }
        
        .page-header {
            padding: 30px 20px;
        }
        
        .page-header h2 {
            font-size: 2rem;
        }
        
        .results-info {
            flex-direction: column;
            align-items: flex-start;
        }
        
        body {
            padding: 10px;
        }
    }
    
    @media (max-width: 480px) {
        .property-meta {
            flex-direction: column;
            gap: 10px;
            align-items: flex-start;
        }
        
        .property-meta span {
            flex-direction: row;
            gap: 10px;
        }
    }
    
    /* FILTER TAGS */
    .filter-tags {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin-top: 20px;
    }
    
    .filter-tag {
        background: #e0f2fe;
        color: #0369a1;
        padding: 6px 15px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .filter-tag i {
        font-size: 0.8rem;
    }
</style>
</head>
<body>

<div class="container">
    <!-- ENHANCED PAGE HEADER -->
    <div class="page-header">
        <h2>Find Your Perfect Property</h2>
        <p>Search through our extensive collection of verified properties with advanced filters</p>
    </div>
    
    <!-- ENHANCED SEARCH FORM - SAME ACTION AND INPUTS -->
    <div class="search-bar-container">
        <div class="search-title">
            <i class="fas fa-search"></i> Advanced Search
        </div>
        
        <form action="property" method="get" class="search-form">
            <!-- City Search -->
            <div class="form-group">
                <input type="text" name="city" class="search-input" 
                       placeholder="Search by city..." 
                       value="<%= request.getParameter("city") != null ? request.getParameter("city") : "" %>">
            </div>
            
            <!-- Property Type -->
            <div class="form-group">
                <select name="type" class="search-select">
                    <option value="">All Property Types</option>
                    <option value="House" <%= "House".equals(request.getParameter("type")) ? "selected" : "" %>>House</option>
                    <option value="Apartment" <%= "Apartment".equals(request.getParameter("type")) ? "selected" : "" %>>Apartment</option>
                    <option value="Villa" <%= "Villa".equals(request.getParameter("type")) ? "selected" : "" %>>Villa</option>
                    <option value="Plot" <%= "Plot".equals(request.getParameter("type")) ? "selected" : "" %>>Plot</option>
                </select>
            </div>
            
            <!-- Purpose -->
            <div class="form-group">
                <select name="purpose" class="search-select">
                    <option value="">All Purposes</option>
                    <option value="SELL" <%= "SELL".equals(request.getParameter("purpose")) ? "selected" : "" %>>Buy</option>
                    <option value="RENT" <%= "RENT".equals(request.getParameter("purpose")) ? "selected" : "" %>>Rent</option>
                </select>
            </div>
            
            <!-- Bedrooms -->
            <div class="form-group">
                <select name="bedrooms" class="search-select">
                    <option value="">Min Bedrooms</option>
                    <option value="1" <%= "1".equals(request.getParameter("bedrooms")) ? "selected" : "" %>>1 Bedroom</option>
                    <option value="2" <%= "2".equals(request.getParameter("bedrooms")) ? "selected" : "" %>>2 Bedrooms</option>
                    <option value="3" <%= "3".equals(request.getParameter("bedrooms")) ? "selected" : "" %>>3 Bedrooms</option>
                    <option value="4" <%= "4".equals(request.getParameter("bedrooms")) ? "selected" : "" %>>4+ Bedrooms</option>
                </select>
            </div>
            
            <!-- Search Button -->
            <div class="form-group">
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i> Search Properties
                </button>
            </div>
        </form>
        
        <!-- ACTIVE FILTER TAGS -->
        <%
        String city = request.getParameter("city");
        String type = request.getParameter("type");
        String purpose = request.getParameter("purpose");
        String bedrooms = request.getParameter("bedrooms");
        boolean hasFilters = (city != null && !city.isEmpty()) || 
                           (type != null && !type.isEmpty()) || 
                           (purpose != null && !purpose.isEmpty()) || 
                           (bedrooms != null && !bedrooms.isEmpty());
        %>
        
        <% if (hasFilters) { %>
        <div class="filter-tags">
            <% if (city != null && !city.isEmpty()) { %>
            <div class="filter-tag">
                <i class="fas fa-map-marker-alt"></i> <%= city %>
            </div>
            <% } %>
            
            <% if (type != null && !type.isEmpty()) { %>
            <div class="filter-tag">
                <i class="fas fa-home"></i> <%= type %>
            </div>
            <% } %>
            
            <% if (purpose != null && !purpose.isEmpty()) { %>
            <div class="filter-tag">
                <i class="fas fa-tag"></i> <%= purpose.equals("SELL") ? "Buy" : "Rent" %>
            </div>
            <% } %>
            
            <% if (bedrooms != null && !bedrooms.isEmpty()) { %>
            <div class="filter-tag">
                <i class="fas fa-bed"></i> <%= bedrooms %>+ Beds
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
    
    <!-- SEARCH RESULTS INFO -->
    <%
    List<Property> properties = (List<Property>) request.getAttribute("properties");
   	loggedUser = (User) session.getAttribute("user");
    
    if (properties != null && !properties.isEmpty()) {
    %>
    <div class="results-info">
        <div class="results-count">
            <i class="fas fa-home"></i>
            <%= properties.size() %> Properties Found
        </div>
        
        <% if (hasFilters) { %>
        <a href="property" class="clear-search">
            <i class="fas fa-times"></i> Clear All Filters
        </a>
        <% } %>
    </div>
    <% } %>
    
    <!-- PROPERTY RESULTS - SAME DATA DISPLAY LOGIC -->
    <%
    if (properties == null || properties.isEmpty()) {
    %>
    <div class="empty-state">
        <i class="fas fa-search"></i>
        <h3>No Properties Found</h3>
        <p>
            <% if (hasFilters) { %>
            We couldn't find any properties matching your search criteria. Try adjusting your filters or search for a different location.
            <% } else { %>
            No properties are currently listed. Check back soon or list your own property!
            <% } %>
        </p>
        <% if (hasFilters) { %>
        <a href="property" class="adjust-search-btn">
            <i class="fas fa-filter"></i> Adjust Search Filters
        </a>
        <% } else { %>
        <a href="add-property.jsp" class="adjust-search-btn">
            <i class="fas fa-plus-circle"></i> List Your Property
        </a>
        <% } %>
    </div>
    <%
    } else {
    %>
    
    <div class="property-grid">
        <%
        for (Property property : properties) {
            // Determine badge style
            String badgeClass = "property-badge badge-available";
            if ("Sold".equals(property.getPropetystatus())) {
                badgeClass = "property-badge badge-sold";
            } else if ("RENT".equals(property.getPurpose())) {
                badgeClass = "property-badge badge-rent";
            }
        %>
        
        <a href="property-details?id=<%= property.getId() %>" class="property-card">
            <!-- IMAGE -->
            <div class="property-image">
                <%
                if (property.getImages() != null && !property.getImages().isEmpty()) {
                %>
                    <img src="property-image?id=<%= property.getImages().get(0).getImageId() %>" 
                         alt="<%= property.getTitle() %>">
                <%
                } else {
                %>
                    <img src="https://images.unsplash.com/photo-1568605114967-8130f3a36994?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80" 
                         alt="Property Image">
                <%
                }
                %>
                
                <!-- BADGE -->
                <div class="<%= badgeClass %>">
                    <%= "RENT".equals(property.getPurpose()) ? "FOR RENT" : property.getPropetystatus() %>
                </div>
                
                <!-- PRICE -->
                <div class="price-tag">₹ <%= property.getPrice() %></div>
            </div>
            
            <!-- BODY -->
            <div class="property-body">
                <div class="property-title"><%= property.getTitle() %></div>
                <div class="property-location">
                    <i class="fas fa-map-marker-alt"></i> <%= property.getCity() %>
                </div>
                
                <div class="property-meta">
                    <span>
                        <i class="fas fa-bed"></i>
                        <%= property.getBedrooms() %> Beds
                    </span>
                    <span>
                        <i class="fas fa-bath"></i>
                        <%= property.getBathrooms() %> Baths
                    </span>
                    <span>
                        <i class="fas fa-ruler-combined"></i>
                        <%= property.getAreaSqarefit() %> sqft
                    </span>
                </div>
                
                <!-- PURPOSE BADGE -->
                <div class="property-purpose">
                    <i class="fas fa-tag me-1"></i>
                    <%= "SELL".equals(property.getPurpose()) ? "For Sale" : "For Rent" %>
                </div>
            </div>
        </a>
        <%
        }
        %>
    </div>
    
    <% } %>
    
    <!-- BACK BUTTON -->
    <div style="text-align: center; margin-top: 40px;">
        <a href="property" class="back-button">
            <i class="fas fa-arrow-left"></i> Back to All Properties
        </a>
    </div>
</div>

</body>
</html>