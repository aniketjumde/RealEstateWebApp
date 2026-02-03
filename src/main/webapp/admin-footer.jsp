<!-- admin-footer.jsp -->
<footer class="admin-footer">
    <div class="footer-content">
        <div class="footer-grid">
            <!-- Logo and Description -->
            <div class="footer-section">
                <div class="footer-logo">
                    <div class="logo-icon">
                        <i class="fas fa-home"></i>
                    </div>
                    <div class="logo-text">
                        <h3>RealEstate Pro</h3>
                        <p>Professional Property Management</p>
                    </div>
                </div>
                <p class="footer-description">
                    Advanced property management system for real estate professionals.
                    Manage properties, clients, and transactions efficiently.
                </p>
                <div class="social-links">
                    <a href="#" class="social-link" title="Facebook">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="social-link" title="Twitter">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="social-link" title="LinkedIn">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                    <a href="#" class="social-link" title="Instagram">
                        <i class="fab fa-instagram"></i>
                    </a>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="footer-section">
                <h4 class="footer-title">Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="<%= request.getContextPath() %>/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                    <li><a href="<%= request.getContextPath() %>/admin/properties"><i class="fas fa-building"></i> Properties</a></li>
                    <li><a href="<%= request.getContextPath() %>/admin/users"><i class="fas fa-users"></i> Users</a></li>
                    <li><a href="<%= request.getContextPath() %>/admin/transactions"><i class="fas fa-exchange-alt"></i> Transactions</a></li>
                    <li><a href="<%= request.getContextPath() %>/admin/reports"><i class="fas fa-chart-bar"></i> Reports</a></li>
                </ul>
            </div>

            <!-- Resources -->
            <div class="footer-section">
                <h4 class="footer-title">Resources</h4>
                <ul class="footer-links">
                    <li><a href="#"><i class="fas fa-book"></i> Documentation</a></li>
                    <li><a href="#"><i class="fas fa-question-circle"></i> Help Center</a></li>
                    <li><a href="#"><i class="fas fa-video"></i> Tutorials</a></li>
                    <li><a href="#"><i class="fas fa-file-alt"></i> API Reference</a></li>
                    <li><a href="#"><i class="fas fa-bullhorn"></i> Changelog</a></li>
                </ul>
            </div>

            <!-- Contact Info -->
            <div class="footer-section">
                <h4 class="footer-title">Contact Us</h4>
                <ul class="contact-info">
                    <li>
                        <i class="fas fa-map-marker-alt"></i>
                        <span>123 Business Street, City, Country 12345</span>
                    </li>
                    <li>
                        <i class="fas fa-phone"></i>
                        <span>+1 (555) 123-4567</span>
                    </li>
                    <li>
                        <i class="fas fa-envelope"></i>
                        <span>support@realestatepro.com</span>
                    </li>
                    <li>
                        <i class="fas fa-clock"></i>
                        <span>Mon-Fri: 9:00 AM - 6:00 PM</span>
                    </li>
                </ul>
                <div class="newsletter">
                    <h5>Stay Updated</h5>
                    <form class="newsletter-form">
                        <input type="email" placeholder="Enter your email" class="newsletter-input">
                        <button type="submit" class="newsletter-btn">
                            <i class="fas fa-paper-plane"></i>
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="footer-bottom-content">
                <div class="copyright">
                    &copy; <span id="currentYear"></span> RealEstate Pro. All rights reserved.
                </div>
                <div class="footer-legal">
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Service</a>
                    <a href="#">Cookie Policy</a>
                    <a href="#">Sitemap</a>
                </div>
                <div class="system-info">
                    <span class="version">v1.5.2</span>
                    <span class="server-status online">
                        <i class="fas fa-circle"></i> Server Online
                    </span>
                </div>
            </div>
        </div>
    </div>
</footer>

<script>
    // Set current year in copyright
    document.getElementById('currentYear').textContent = new Date().getFullYear();
    
    // Update server status (example - you can make this dynamic)
    function updateServerStatus() {
        fetch('/admin/api/status')
            .then(response => response.json())
            .then(data => {
                const statusElement = document.querySelector('.server-status');
                if (data.status === 'online') {
                    statusElement.className = 'server-status online';
                    statusElement.innerHTML = '<i class="fas fa-circle"></i> Server Online';
                } else {
                    statusElement.className = 'server-status offline';
                    statusElement.innerHTML = '<i class="fas fa-circle"></i> Server Offline';
                }
            });
    }
    
    // Check server status every 5 minutes
    setInterval(updateServerStatus, 300000);
</script>

<style>
/* Admin Footer Styles */
.admin-footer {
    background: linear-gradient(180deg, #1A1F36 0%, #111827 100%);
    color: #fff;
    padding: 40px 0 0 0;
    margin-top: auto;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.footer-content {
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 32px;
}

.footer-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 40px;
    margin-bottom: 40px;
}

.footer-section {
    padding: 0 10px;
}

.footer-logo {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 20px;
}

.logo-icon {
    width: 48px;
    height: 48px;
    background: linear-gradient(135deg, #2563eb 0%, #3b82f6 100%);
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    color: white;
}

.logo-text h3 {
    font-size: 20px;
    font-weight: 700;
    color: white;
    margin: 0;
}

.logo-text p {
    font-size: 12px;
    color: rgba(255, 255, 255, 0.6);
    margin: 4px 0 0 0;
}

.footer-description {
    color: rgba(255, 255, 255, 0.7);
    font-size: 14px;
    line-height: 1.6;
    margin-bottom: 24px;
}

.social-links {
    display: flex;
    gap: 12px;
}

.social-link {
    width: 36px;
    height: 36px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: rgba(255, 255, 255, 0.7);
    transition: all 0.3s ease;
    text-decoration: none;
}

.social-link:hover {
    background: #2563eb;
    color: white;
    transform: translateY(-3px);
}

.footer-title {
    font-size: 16px;
    font-weight: 600;
    color: white;
    margin-bottom: 20px;
    padding-bottom: 10px;
    border-bottom: 2px solid rgba(255, 255, 255, 0.1);
}

.footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
}

.footer-links li {
    margin-bottom: 12px;
}

.footer-links a {
    color: rgba(255, 255, 255, 0.7);
    text-decoration: none;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 10px;
    transition: all 0.3s ease;
}

.footer-links a:hover {
    color: #3b82f6;
    transform: translateX(5px);
}

.footer-links i {
    width: 16px;
    font-size: 12px;
    opacity: 0.7;
}

.contact-info {
    list-style: none;
    padding: 0;
    margin: 0 0 24px 0;
}

.contact-info li {
    display: flex;
    align-items: flex-start;
    gap: 12px;
    margin-bottom: 16px;
    color: rgba(255, 255, 255, 0.7);
    font-size: 14px;
}

.contact-info i {
    color: #3b82f6;
    margin-top: 3px;
    font-size: 14px;
}

.newsletter h5 {
    font-size: 14px;
    color: white;
    margin-bottom: 12px;
    font-weight: 600;
}

.newsletter-form {
    display: flex;
    gap: 8px;
}

.newsletter-input {
    flex: 1;
    padding: 10px 16px;
    background: rgba(255, 255, 255, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 8px;
    color: white;
    font-size: 14px;
    transition: all 0.3s ease;
}

.newsletter-input:focus {
    outline: none;
    border-color: #3b82f6;
    background: rgba(255, 255, 255, 0.15);
}

.newsletter-input::placeholder {
    color: rgba(255, 255, 255, 0.5);
}

.newsletter-btn {
    width: 44px;
    background: #3b82f6;
    border: none;
    border-radius: 8px;
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
}

.newsletter-btn:hover {
    background: #2563eb;
    transform: translateY(-2px);
}

/* Footer Bottom */
.footer-bottom {
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    padding: 24px 0;
    background: rgba(0, 0, 0, 0.2);
}

.footer-bottom-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
}

.copyright {
    color: rgba(255, 255, 255, 0.6);
    font-size: 14px;
}

.footer-legal {
    display: flex;
    gap: 24px;
}

.footer-legal a {
    color: rgba(255, 255, 255, 0.6);
    text-decoration: none;
    font-size: 14px;
    transition: all 0.3s ease;
}

.footer-legal a:hover {
    color: #3b82f6;
}

.system-info {
    display: flex;
    align-items: center;
    gap: 20px;
}

.version {
    color: rgba(255, 255, 255, 0.6);
    font-size: 13px;
    padding: 4px 12px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 12px;
}

.server-status {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 13px;
    padding: 4px 12px;
    border-radius: 12px;
}

.server-status.online {
    background: rgba(16, 185, 129, 0.15);
    color: #10b981;
}

.server-status.offline {
    background: rgba(239, 68, 68, 0.15);
    color: #ef4444;
}

.server-status i {
    font-size: 8px;
}

/* Responsive Design */
@media (max-width: 768px) {
    .admin-footer {
        padding: 32px 0 0 0;
    }
    
    .footer-content {
        padding: 0 20px;
    }
    
    .footer-grid {
        gap: 30px;
        grid-template-columns: 1fr;
    }
    
    .footer-bottom-content {
        flex-direction: column;
        text-align: center;
        gap: 16px;
    }
    
    .footer-legal {
        flex-wrap: wrap;
        justify-content: center;
        gap: 16px;
    }
    
    .system-info {
        flex-direction: column;
        gap: 12px;
    }
}

/* Animation for footer links */
@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateX(-10px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.footer-links li {
    animation: slideIn 0.3s ease-out;
    animation-fill-mode: both;
}

.footer-links li:nth-child(1) { animation-delay: 0.1s; }
.footer-links li:nth-child(2) { animation-delay: 0.2s; }
.footer-links li:nth-child(3) { animation-delay: 0.3s; }
.footer-links li:nth-child(4) { animation-delay: 0.4s; }
.footer-links li:nth-child(5) { animation-delay: 0.5s; }
</style>