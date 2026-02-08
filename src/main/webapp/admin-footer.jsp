<footer class="admin-footer">
    <div class="footer-content">
        <div class="footer-section">
            <div class="footer-logo">
                <i class="fas fa-building"></i>
                <span>RealEstate Pro</span>
            </div>
            <p class="footer-description">
                Professional real estate administration platform for managing properties, users, and listings efficiently.
            </p>
            <div class="footer-social">
                <a href="#" class="social-icon" title="Facebook">
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a href="#" class="social-icon" title="Twitter">
                    <i class="fab fa-twitter"></i>
                </a>
                <a href="#" class="social-icon" title="LinkedIn">
                    <i class="fab fa-linkedin-in"></i>
                </a>
                <a href="#" class="social-icon" title="Instagram">
                    <i class="fab fa-instagram"></i>
                </a>
            </div>
        </div>
        
        <div class="footer-section">
            <h4 class="footer-heading">Quick Links</h4>
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-chevron-right"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-chevron-right"></i> Manage Users</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/properties"><i class="fas fa-chevron-right"></i> All Properties</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/property-approval"><i class="fas fa-chevron-right"></i> Pending Approvals</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h4 class="footer-heading">Resources</h4>
            <ul class="footer-links">
                <li><a href="#"><i class="fas fa-chevron-right"></i> Documentation</a></li>
                <li><a href="#"><i class="fas fa-chevron-right"></i> API Reference</a></li>
                <li><a href="#"><i class="fas fa-chevron-right"></i> Support Center</a></li>
                <li><a href="#"><i class="fas fa-chevron-right"></i> Privacy Policy</a></li>
            </ul>
        </div>
        
        <div class="footer-section">
            <h4 class="footer-heading">Contact Info</h4>
            <ul class="footer-contact">
                <li>
                    <i class="fas fa-envelope"></i>
                    <span>admin@realestatepro.com</span>
                </li>
                <li>
                    <i class="fas fa-phone"></i>
                    <span>+1 (555) 123-4567</span>
                </li>
                <li>
                    <i class="fas fa-map-marker-alt"></i>
                    <span>123 Business Ave, Suite 100<br>New York, NY 10001</span>
                </li>
            </ul>
        </div>
    </div>
    
    <div class="footer-bottom">
        <div class="footer-copyright">
            © <%= java.time.LocalDate.now().getYear() %> RealEstate Pro Admin Panel. All rights reserved.
        </div>
        <div class="footer-stats">
            <span class="stat-item">
                <i class="fas fa-users"></i>
                <%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "0" %> Users
            </span>
            <span class="stat-item">
                <i class="fas fa-home"></i>
                <%= request.getAttribute("totalProperties") != null ? request.getAttribute("totalProperties") : "0" %> Properties
            </span>
            <span class="stat-item">
                <i class="fas fa-server"></i>
                v2.5.1
            </span>
        </div>
    </div>
</footer>