<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.realestate.model.Property" %>
<%@ page import="java.util.List" %>
<%@ page import="com.realestate.model.User" %>

<%
    // Get featured properties from request attribute
    List<Property> featuredProperties = (List<Property>) request.getAttribute("featuredProperties");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RealEstate - Find Your Dream Property</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
            background-color: var(--light-bg);
            color: var(--dark-text);
        }
        
        .hero-section {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 20px;
        }
        
        .hero-subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
            margin-bottom: 40px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .search-container {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            margin-top: -50px;
            position: relative;
            z-index: 10;
        }
        
        .feature-card {
            background: white;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            border: 1px solid #e2e8f0;
            height: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            border-color: var(--primary);
        }
        
        .feature-icon {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 20px;
        }
        
        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        
        .stats-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 5px;
        }
        
        .property-highlight {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid #e2e8f0;
            height: 100%;
        }
        
        .property-highlight:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .property-img {
            height: 200px;
            width: 100%;
            object-fit: cover;
        }
        
        .property-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: var(--primary);
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            z-index: 2;
        }
        
        .property-badge.rent {
            background: var(--secondary);
        }
        
        .no-property-img {
            height: 200px;
            width: 100%;
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #94a3b8;
            font-size: 1.5rem;
        }
        
        .btn-primary-custom {
            background-color: var(--primary);
            border-color: var(--primary);
            padding: 12px 30px;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .btn-primary-custom:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .section-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: var(--dark-text);
            position: relative;
            display: inline-block;
        }
        
        .section-title:after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 4px;
            background: var(--primary);
            border-radius: 2px;
        }
        
        .section-subtitle {
            color: var(--light-text);
            margin-bottom: 40px;
            font-size: 1.1rem;
        }
        
        footer {
            background: var(--dark-text);
            color: white;
            padding: 60px 0 20px;
            margin-top: 80px;
        }
        
        .footer-links a {
            color: #cbd5e1;
            text-decoration: none;
            transition: color 0.3s ease;
            display: block;
            margin-bottom: 10px;
        }
        
        .footer-links a:hover {
            color: white;
        }
        
        .copyright {
            border-top: 1px solid #334155;
            padding-top: 20px;
            margin-top: 40px;
            color: #94a3b8;
            font-size: 0.9rem;
        }
        
        .property-price {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary);
        }
        
        .no-properties-message {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 40px;
        }
        
        .no-properties-message i {
            font-size: 4rem;
            color: #cbd5e1;
            margin-bottom: 20px;
        }
        
        .property-meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
            color: var(--light-text);
        }
        
        .property-meta-item i {
            color: var(--primary);
        }
    </style>
</head>
<body>
<%@ include file="/Header.jsp" %>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <h1 class="hero-title">Find Your Perfect Property</h1>
            <p class="hero-subtitle">Discover thousands of properties for sale and rent across the country. Your dream home is just a click away.</p>
            <a href="property" class="btn btn-light btn-lg px-5 py-3 rounded-pill fw-bold">Browse Properties <i class="fas fa-arrow-right ms-2"></i></a>
        </div>
    </section>
    
    <!-- Search Section -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="search-container">
                    <h3 class="mb-4">Search Properties</h3>
                    <form action="property" method="get" class="row g-3">
                        <div class="col-md-4">
                            <input type="text" name="city" class="form-control form-control-lg" placeholder="City or Location">
                        </div>
                        <div class="col-md-3">
                            <select name="type" class="form-select form-select-lg">
                                <option value="">Property Type</option>
                                <option>House</option>
                                <option>Apartment</option>
                                <option>Villa</option>
                                <option>Plot</option>
                            </select>
                        </div>
                        <div class="col-md-3">
                            <select name="purpose" class="form-select form-select-lg">
                                <option value="">Purpose</option>
                                <option value="SELL">Buy</option>
                                <option value="RENT">Rent</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary-custom w-100">Search</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Stats Section -->
    <section class="py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-3 col-6">
                    <div class="stats-card">
                        <div class="stats-number">5,000+</div>
                        <div class="text-muted">Properties Listed</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stats-card">
                        <div class="stats-number">1,200+</div>
                        <div class="text-muted">Happy Clients</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stats-card">
                        <div class="stats-number">150+</div>
                        <div class="text-muted">Cities</div>
                    </div>
                </div>
                <div class="col-md-3 col-6">
                    <div class="stats-card">
                        <div class="stats-number">98%</div>
                        <div class="text-muted">Satisfaction Rate</div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Featured Properties from Database -->
    <section class="py-5">
        <div class="container">
            <h2 class="section-title text-center">Featured Properties</h2>
            <p class="section-subtitle text-center">Latest approved properties in our platform</p>
            
            <% if (featuredProperties != null && !featuredProperties.isEmpty()) { %>
                <div class="row g-4">
                    <% for (Property property : featuredProperties) { 
                        String badgeClass = "property-badge";
                        if ("RENT".equals(property.getPurpose())) {
                            badgeClass += " rent";
                        }
                    %>
                    <div class="col-lg-4 col-md-6">
                        <div class="property-highlight">
                            <div class="position-relative">
                                <% if (property.getImages() != null && !property.getImages().isEmpty()) { %>
                                    <img src="property-image?id=<%= property.getImages().get(0).getImageId() %>" 
                                         class="property-img" alt="<%= property.getTitle() %>">
                                <% } else { %>
                                    <div class="no-property-img">
                                        <i class="fas fa-home"></i>
                                    </div>
                                <% } %>
                                <div class="<%= badgeClass %>">
                                    <%= "RENT".equals(property.getPurpose()) ? "FOR RENT" : "FOR SALE" %>
                                </div>
                            </div>
                            <div class="p-4">
                                <h5 class="fw-bold"><%= property.getTitle() %></h5>
                                <p class="text-muted mb-2">
                                    <i class="fas fa-map-marker-alt me-2"></i> 
                                    <%= property.getCity() != null ? property.getCity() : "" %>
                                    <%= property.getState() != null ? ", " + property.getState() : "" %>
                                </p>
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <span class="property-price">₹ <%= property.getPrice() %></span>
                                    </div>
                                    <div class="d-flex gap-3 text-muted">
                                        <% if (property.getBedrooms() > 0) { %>
                                        <div class="property-meta-item">
                                            <i class="fas fa-bed"></i>
                                            <span><%= property.getBedrooms() %></span>
                                        </div>
                                        <% } %>
                                        
                                        <% if (property.getBathrooms() > 0) { %>
                                        <div class="property-meta-item">
                                            <i class="fas fa-bath"></i>
                                            <span><%= property.getBathrooms() %></span>
                                        </div>
                                        <% } %>
                                        
                                        <% if (property.getAreaSqarefit() > 0) { %>
                                        <div class="property-meta-item">
                                            <i class="fas fa-ruler-combined"></i>
                                            <span><%= property.getAreaSqarefit() %> sqft</span>
                                        </div>
                                        <% } %>
                                    </div>
                                </div>
                                <a href="property-details?id=<%= property.getId() %>" class="btn btn-outline-primary w-100">View Details</a>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
                
                <div class="text-center mt-5">
                    <a href="property" class="btn btn-primary-custom px-5">View All Properties <i class="fas fa-arrow-right ms-2"></i></a>
                </div>
                
            <% } else { %>
                <div class="no-properties-message">
                    <i class="fas fa-home"></i>
                    <h3 class="mb-3">No Featured Properties Yet</h3>
                    <p class="text-muted mb-4">Check back soon for new property listings or browse all properties.</p>
                    <a href="property" class="btn btn-primary-custom">Browse All Properties</a>
                </div>
            <% } %>
        </div>
    </section>
    
    <!-- Features Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <h2 class="section-title text-center">Why Choose RealEstate?</h2>
            <p class="section-subtitle text-center">We provide the best platform for buying, selling, and renting properties</p>
            
            <div class="row g-4 mt-4">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-search-location"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Smart Search</h4>
                        <p class="text-muted">Find properties that match your exact preferences with our advanced search filters and AI recommendations.</p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Verified Listings</h4>
                        <p class="text-muted">All properties are verified by our team to ensure accurate information and protect against fraud.</p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-handshake"></i>
                        </div>
                        <h4 class="fw-bold mb-3">Expert Support</h4>
                        <p class="text-muted">Our dedicated support team is available 24/7 to help you through every step of the process.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Call to Action -->
    <section class="py-5" style="background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%); color: white;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h2 class="fw-bold mb-3">Ready to Find Your Dream Property?</h2>
                    <p class="mb-0">Join thousands of satisfied customers who found their perfect home through RealEstate.</p>
                </div>
                <div class="col-lg-4 text-lg-end text-center mt-3 mt-lg-0">
                    <%
                        if (loggedUser == null) {
                    %>
                        <a href="login.jsp" class="btn btn-light btn-lg px-5 py-3 rounded-pill fw-bold">Get Started Now</a>
                    <% } else { %>
                        <a href="add-property.jsp" class="btn btn-light btn-lg px-5 py-3 rounded-pill fw-bold">List Your Property</a>
                    <% } %>
                </div>
            </div>
        </div>
    </section>
    
   <%@ include file="/Footer.jsp" %>
   
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>