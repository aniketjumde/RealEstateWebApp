<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>About RealEstate | Premium Property Platform</title>
    <meta name="description" content="RealEstate Portal - Enterprise-grade property management system built with Java, Hibernate, and modern web technologies">
    	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- Custom Styles -->
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
            --border: #e2e8f0;
            --card-shadow: 0 8px 30px rgba(15, 118, 110, 0.08);
            --card-shadow-hover: 0 15px 40px rgba(15, 118, 110, 0.15);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
       
        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 100px 0 80px;
            position: relative;
            overflow: hidden;
            border-radius: 0 0 40px 40px;
            margin-bottom: 60px;
        }
        
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="%23ffffff" fill-opacity="0.1" d="M0,224L48,213.3C96,203,192,181,288,181.3C384,181,480,203,576,192C672,181,768,139,864,128C960,117,1056,139,1152,149.3C1248,160,1344,160,1392,160L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
            background-size: cover;
            background-position: bottom;
            opacity: 0.1;
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 800px;
            margin: 0 auto;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: 20px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.2);
        }
        
        .hero-subtitle {
            font-size: 1.3rem;
            opacity: 0.9;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        
        /* Stats Cards */
        .stats-container {
            position: relative;
            z-index: 3;
            margin-top: 40px;
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 25px;
            text-align: center;
            transition: all 0.4s ease;
            height: 100%;
        }
        
        .stat-card:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
        }
        
        .stat-number {
            font-size: 2.8rem;
            font-weight: 800;
            color: white;
            margin-bottom: 5px;
        }
        
        .stat-label {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 500;
        }
        
        /* Section Cards */
        .section-card {
            background: white;
            border-radius: 24px;
            padding: 40px;
            box-shadow: var(--card-shadow);
            margin-bottom: 30px;
            border: 1px solid var(--border);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
        }
        
        .section-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 6px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary), var(--primary-dark));
            border-radius: 24px 0 0 24px;
        }
        
        .section-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--card-shadow-hover);
        }
        
        .section-title {
            color: var(--primary);
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .section-title i {
            font-size: 1.3rem;
            width: 40px;
            height: 40px;
            background: rgba(15, 118, 110, 0.1);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        /* Feature Items */
        .feature-items {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .feature-item {
            background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
            border-radius: 18px;
            padding: 25px;
            border: 1px solid var(--border);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .feature-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--primary-dark));
        }
        
        .feature-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow);
            border-color: var(--primary);
        }
        
        .feature-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, rgba(15, 118, 110, 0.1), rgba(21, 94, 117, 0.1));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: var(--primary);
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }
        
        .feature-item:hover .feature-icon {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            transform: scale(1.1) rotate(5deg);
        }
        
        .feature-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 10px;
        }
        
        .feature-desc {
            color: var(--light-text);
            font-size: 0.95rem;
            line-height: 1.6;
        }
        
        /* Technology Badges */
        .tech-stack {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 20px;
        }
        
        .tech-badge {
            background: linear-gradient(135deg, var(--light-bg), #ffffff);
            color: var(--dark-text);
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            border: 1px solid var(--border);
            transition: all 0.3s ease;
            cursor: default;
        }
        
        .tech-badge i {
            color: var(--primary);
            font-size: 16px;
        }
        
        .tech-badge:hover {
            background: linear-gradient(135deg, rgba(15, 118, 110, 0.1), rgba(21, 94, 117, 0.05));
            color: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(15, 118, 110, 0.1);
            border-color: var(--primary);
        }
        
        /* Developer Section */
        .developer-card {
            background: linear-gradient(135deg, white, var(--light-bg));
            border-radius: 24px;
            padding: 40px;
            text-align: center;
            border: 1px solid var(--border);
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
        }
        
        .developer-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
        }
        
        .dev-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            margin: 0 auto 25px;
            border: 5px solid white;
            box-shadow: 0 10px 30px rgba(15, 118, 110, 0.15);
            overflow: hidden;
            background: linear-gradient(135deg, rgba(15, 118, 110, 0.1), rgba(37, 99, 235, 0.1));
        }
        
        .dev-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .dev-name {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-text);
            margin-bottom: 5px;
        }
        
        .dev-title {
            color: var(--primary);
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 15px;
        }
        
        .dev-bio {
            color: var(--light-text);
            max-width: 600px;
            margin: 0 auto 30px;
            line-height: 1.7;
        }
        
        .social-links {
            display: flex;
            justify-content: center;
            gap: 15px;
        }
        
        .social-link {
            width: 45px;
            height: 45px;
            background: var(--light-bg);
            color: var(--primary);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 1px solid var(--border);
        }
        
        .social-link:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-3px) rotate(5deg);
            box-shadow: 0 8px 20px rgba(15, 118, 110, 0.2);
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-section {
                padding: 60px 0 40px;
                border-radius: 0 0 30px 30px;
            }
            
            .section-card {
                padding: 25px;
            }
            
            .feature-items {
                grid-template-columns: 1fr;
            }
            
            .stat-number {
                font-size: 2.2rem;
            }
        }
        
        @media (max-width: 576px) {
            .hero-title {
                font-size: 2rem;
            }
            
            .hero-subtitle {
                font-size: 1.1rem;
            }
        }
        
        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .animate-in {
            animation: fadeInUp 0.6s ease forwards;
        }
        
        .delay-1 { animation-delay: 0.1s; opacity: 0; }
        .delay-2 { animation-delay: 0.2s; opacity: 0; }
        .delay-3 { animation-delay: 0.3s; opacity: 0; }
    </style>
</head>

<body>
<%@ include file="/Header.jsp" %>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="hero-content text-center">
            <h1 class="hero-title animate-in">
                About RealEstate Platform
            </h1>
            <p class="hero-subtitle animate-in delay-1">
                <p style="font-size: 1.1rem; line-height: 1.8;">
                    The RealEstate Portal is a real-world inspired Java enterprise web application 
                    developed to apply and demonstrate modern software engineering concepts in a 
                    production-like environment.
                </p>
                <p style="font-size: 1.1rem; line-height: 1.8;">
                    This project was created to bridge the gap between theoretical knowledge and 
                    real-world application development by implementing a complete property management 
                    system using Java, Hibernate, MySQL, and MVC architecture.
                </p>
            </p>
        </div>
        
       
    </div>
</section>

<div class="container my-5">
    
    <!-- Project Overview -->
    <div class="section-card animate-in delay-1">
        <h3 class="section-title">
            <i class="fas fa-info-circle"></i> Project Overview
        </h3>
        
        <div class="mb-4">
            <p style="font-size: 1.15rem; line-height: 1.9; color: var(--light-text);">
                <strong style="color: var(--primary);">RealEstate Portal</strong> is a 
                full-stack, enterprise-grade web application developed using Java technologies 
                to digitize and simplify real-estate property management.  
                The platform enables property owners to list properties, buyers to explore and 
                inquire, and administrators to verify and manage all activities through a 
                centralized system.
            </p>
            
            <p style="font-size: 1.05rem; line-height: 1.8; color: var(--light-text);">
                Designed with a <strong>real-world business workflow</strong> in mind, the system 
                follows a clean <strong>MVC architecture</strong>, uses <strong>Hibernate ORM</strong> 
                for database interaction, and ensures secure access through 
                <strong>Firebase Authentication</strong> and role-based authorization.
            </p>
        </div>
        
        <div class="mt-4 p-4" style="background: rgba(15, 118, 110, 0.05); border-radius: 12px; border-left: 4px solid var(--primary);">
            <h5 style="color: var(--primary); margin-bottom: 10px;">
                <i class="fas fa-lightbulb me-2"></i>How It Works
            </h5>
            <p style="margin: 0; color: var(--light-text);">
                Property owners can list their properties with detailed information and images. 
                These listings undergo verification before becoming publicly searchable. 
                Potential buyers/renters can browse properties, apply filters, and directly contact 
                sellers through the platform. The system manages the entire communication and 
                transaction process in a secure, organized manner.
            </p>
        </div>
    </div>
    
   
    
    <!-- Technology Stack -->
    <div class="section-card animate-in delay-3">
        <h3 class="section-title">
            <i class="fas fa-code"></i> Technology Stack
        </h3>
        
        <div class="mb-4">
            <h5 class="mb-3" style="color: var(--primary);">
                <i class="fas fa-server me-2"></i>Backend Development
            </h5>
            <div class="tech-stack">
                <span class="tech-badge">
                    <i class="fab fa-java"></i> Java 11
                </span>
                <span class="tech-badge">
                    <i class="fas fa-layer-group"></i> Java Servlets
                </span>
                <span class="tech-badge">
                    <i class="fab fa-js-square"></i> JSP
                </span>
                <span class="tech-badge">
                    <i class="fas fa-database"></i> Hibernate ORM
                </span>
                <span class="tech-badge">
                    <i class="fas fa-database"></i> MySQL
                </span>
                <span class="tech-badge">
                    <i class="fas fa-project-diagram"></i> Maven
                </span>
            </div>
        </div>
        
        <div class="mb-4">
            <h5 class="mb-3" style="color: var(--primary);">
                <i class="fas fa-desktop me-2"></i>Frontend Development
            </h5>
            <div class="tech-stack">
                <span class="tech-badge">
                    <i class="fab fa-html5"></i> HTML5
                </span>
                <span class="tech-badge">
                    <i class="fab fa-css3-alt"></i> CSS3
                </span>
                <span class="tech-badge">
                    <i class="fab fa-js-square"></i> JavaScript
                </span>
                <span class="tech-badge">
                    <i class="fab fa-bootstrap"></i> Bootstrap 5
                </span>
                <span class="tech-badge">
                    <i class="fas fa-map"></i> Leaflet.js
                </span>
                <span class="tech-badge">
                    <i class="fas fa-chart-pie"></i> Chart.js
                </span>
            </div>
        </div>
        
     
        
    </div>
    
    <!-- Developer Info -->
    <div class="section-card animate-in">
        <div class="developer-card">
            <div class="dev-avatar">
                <!-- Replace this with your actual photo URL -->
                <img src="https://avatars.githubusercontent.com/u/158746574?v=4" alt="Aniket Jumde" onerror="this.style.display='none'; this.parentNode.innerHTML='<i class=\"fas fa-user-tie\" style=\"font-size: 48px; color: var(--primary); line-height: 150px;\"></i>'">
            </div>
            <h2 class="dev-name">Aniket Jumde</h2>
            <p class="dev-title">Software Developer</p>
            <p class="dev-bio">
			    A Java developer learning and applying real-world concepts through hands-on projects.
			    This RealEstate Portal was built to practice Java, Hibernate, MySQL, and MVC architecture
			    while developing a complete web application from scratch.
			</p>


            
           
            
            <div class="social-links">
				<a href="mailto:aniketjumde55@gmail.com" class="social-link" title="Email">
                    <i class="fas fa-envelope"></i>
                </a>
                <a href="https://github.com/aniketjumde" class="social-link" title="GitHub">
                    <i class="fab fa-github"></i>
                </a>
                <a href="https://www.linkedin.com/in/aniket-jumde-74275a289/" class="social-link" title="LinkedIn">
                    <i class="fab fa-linkedin-in"></i>
                </a>
                <a href="https://aniketjumdeportfolio.vercel.app" class="social-link" title="Portfolio">
                    <i class="fas fa-briefcase"></i>
                </a>
            </div>
        </div>
    </div>
    
</div>

<%@ include file="/Footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Animation Script -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Intersection Observer for scroll animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-in');
                }
            });
        }, observerOptions);
        
        // Observe all section cards
        document.querySelectorAll('.section-card').forEach(card => {
            observer.observe(card);
        });
    });
</script>

</body>
</html>