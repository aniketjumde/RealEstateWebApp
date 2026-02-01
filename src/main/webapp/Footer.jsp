<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Footer</title>
<style>
    .footer {
        background: #1e293b;
        color: white;
        padding: 60px 0 20px;
        margin-top: auto;
    }
    
    .footer h5 {
        font-weight: 700;
        margin-bottom: 20px;
        color: white;
    }
    
    .footer-links {
        list-style: none;
        padding: 0;
    }
    
    .footer-links li {
        margin-bottom: 10px;
    }
    
    .footer-links a {
        color: #cbd5e1;
        text-decoration: none;
        transition: color 0.3s ease;
    }
    
    .footer-links a:hover {
        color: white;
        padding-left: 5px;
    }
    
    .social-icons a {
        display: inline-block;
        width: 40px;
        height: 40px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        text-align: center;
        line-height: 40px;
        margin-right: 10px;
        color: white;
        transition: all 0.3s ease;
    }
    
    .social-icons a:hover {
        background: var(--primary);
        transform: translateY(-3px);
    }
    
    .copyright {
        border-top: 1px solid #334155;
        padding-top: 20px;
        margin-top: 40px;
        text-align: center;
        color: #94a3b8;
        font-size: 0.9rem;
    }
    
    .newsletter-form {
        display: flex;
        margin-top: 15px;
    }
    
    .newsletter-form input {
        flex: 1;
        padding: 10px;
        border: none;
        border-radius: 5px 0 0 5px;
    }
    
    .newsletter-form button {
        background: var(--primary);
        color: white;
        border: none;
        padding: 0 20px;
        border-radius: 0 5px 5px 0;
        cursor: pointer;
        transition: background 0.3s ease;
    }
    
    .newsletter-form button:hover {
        background: var(--primary-dark);
    }
</style>
</head>
<body>

<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mb-4 mb-lg-0">
                <h5>🏠 RealEstate</h5>
                <p>Your trusted partner in finding the perfect property. We connect buyers, sellers, and renters across the country.</p>
                <div class="social-icons mt-4">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            
            <div class="col-lg-2 col-md-4 mb-4 mb-md-0">
                <h5>Quick Links</h5>
                <ul class="footer-links">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="property">Properties</a></li>
                    <li><a href="about.jsp">About Us</a></li>
                    <li><a href="contact.jsp">Contact</a></li>
                </ul>
            </div>
            
            <div class="col-lg-3 col-md-4 mb-4 mb-md-0">
                <h5>Resources</h5>
                <ul class="footer-links">
                    <li><a href="faq.jsp">FAQ</a></li>
                    <li><a href="blog.jsp">Blog</a></li>
                    <li><a href="privacy.jsp">Privacy Policy</a></li>
                    <li><a href="terms.jsp">Terms of Service</a></li>
                </ul>
            </div>
            
            <div class="col-lg-3 col-md-4">
                <h5>Newsletter</h5>
                <p>Subscribe to get updates on new properties</p>
                <form class="newsletter-form">
                    <input type="email" placeholder="Your email" required>
                    <button type="submit"><i class="fas fa-paper-plane"></i></button>
                </form>
                <div class="mt-4">
                    <p><i class="fas fa-phone me-2"></i> (555) 123-4567</p>
                    <p><i class="fas fa-envelope me-2"></i> info@realestate.com</p>
                </div>
            </div>
        </div>
        
        <div class="row mt-5">
            <div class="col-12">
                <div class="copyright">
                    &copy; 2024 RealEstate. All rights reserved.
                </div>
            </div>
        </div>
    </div>
</footer>

</body>
</html>