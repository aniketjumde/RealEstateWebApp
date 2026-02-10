 <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-4 mb-lg-0">
					<div class="footer-logo">
                    <i class="fas fa-home"></i>
                    <span class="fw-bold ">RealEstate Web Application</span>
                </div>                    
                <p class="text-light">Your trusted partner in finding the perfect property. We connect buyers, sellers, and renters across the country.</p>
                    <div class="mt-4">
						<a href="https://github.com/aniketjumde/RealEstateWebApp" class="text-light me-3"><i class="fab fa-github fa-lg"></i></a>
                        <a href="#" class="text-light me-3"><i class="fab fa-twitter fa-lg"></i></a>
                        <a href="#" class="text-light me-3"><i class="fab fa-instagram fa-lg"></i></a>
                        <a href="https://www.linkedin.com/in/aniket-jumde-74275a289/" class="text-light"><i class="fab fa-linkedin fa-lg"></i></a>
                    </div>
                </div>
                
                <div class="col-lg-2 col-md-4 mb-4 mb-md-0">
                    <h5 class="fw-bold mb-3">Quick Links</h5>
                    <div class="footer-links">
                        <a href="index">Home</a>
                        <a href="property">Properties</a>
                        <a href="about.jsp">About Us</a>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-4 mb-4 mb-md-0">
                    <h5 class="fw-bold mb-3">For Users</h5>
                    <div class="footer-links">
                        <a href="dashboard">Dashboard</a>
                        <a href="profile.jsp">My Profile</a>
                        <a href="add-property.jsp">Add Property</a>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-4">
                    <h5 class="fw-bold mb-3">Contact Info</h5>
                    <div class="text-light">
                        <p class="mb-2"><i class="fas fa-map-marker-alt me-2"></i> 123 Real Estate St, New York, NY</p>
                        <p class="mb-2"><i class="fas fa-phone me-2"></i> (555) 123-4567</p>
                        <p class="mb-0"><i class="fas fa-envelope me-2"></i> info@realestate.com</p>
                    </div>
                </div>
            </div>
            
            <div class="row mt-5">
                <div class="col-12">
                    <div class="copyright text-center">
                        &copy; 2026 RealEstate. All rights reserved. | <a href="#" class="text-light">Privacy Policy</a> | <a href="#" class="text-light">Terms of Service</a>
                    </div>
                </div>
            </div>
        </div>
    </footer>
  
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
       