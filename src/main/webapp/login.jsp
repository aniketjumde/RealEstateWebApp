<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Real Estate</title>
    <script src="https://www.gstatic.com/firebasejs/9.6.0/firebase-app-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.6.0/firebase-auth-compat.js"></script>
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
            --google-blue: #4285f4;
            --google-dark-blue: #357ae8;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        
        .login-main {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: calc(100vh - 76px); /* Subtract header height */
            padding: 40px 20px;
        }
        
        .login-wrapper {
            width: 100%;
            max-width: 450px;
            animation: fadeIn 0.6s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .login-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            border: 1px solid rgba(255,255,255,0.2);
        }
        
        .login-header {
            background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
            color: white;
            padding: 50px 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .login-header::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 150px;
            height: 150px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }
        
        .logo-container {
            margin-bottom: 25px;
        }
        
        .logo {
            font-size: 3rem;
            display: inline-block;
            animation: bounce 2s infinite;
        }
        
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        
        .login-header h1 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 10px;
            letter-spacing: -0.5px;
        }
        
        .login-header p {
            opacity: 0.9;
            font-size: 1.1rem;
            max-width: 300px;
            margin: 0 auto;
            line-height: 1.5;
        }
        
        .login-content {
            padding: 50px 40px;
        }
        
        .welcome-section {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .welcome-section h2 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-text);
            margin-bottom: 10px;
        }
        
        .welcome-section p {
            color: var(--light-text);
            font-size: 1rem;
            line-height: 1.6;
            max-width: 320px;
            margin: 0 auto;
        }
        
        .google-btn {
            width: 100%;
            padding: 16px;
            background: var(--google-blue);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            position: relative;
            overflow: hidden;
        }
        
        .google-btn:hover {
            background: var(--google-dark-blue);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(66, 133, 244, 0.3);
        }
        
        .google-btn:active {
            transform: translateY(0);
        }
        
        .google-icon {
            font-size: 1.3rem;
            background: white;
            color: var(--google-blue);
            width: 36px;
            height: 36px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        
        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .error-message {
            margin-top: 20px;
            padding: 15px;
            background: #fee2e2;
            color: #991b1b;
            border-radius: 10px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: shake 0.5s ease-in-out;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        
        .error-message i {
            font-size: 1.2rem;
        }
        
        .login-footer {
            text-align: center;
            padding-top: 30px;
            margin-top: 30px;
            border-top: 1px solid #e2e8f0;
        }
        
        .login-footer p {
            color: var(--light-text);
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        .terms-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }
        
        .terms-link:hover {
            text-decoration: underline;
        }
        
        /* Responsive Design */
        @media (max-width: 576px) {
            .login-main {
                min-height: calc(100vh - 60px);
                padding: 20px 15px;
            }
            
            .login-wrapper {
                max-width: 100%;
            }
            
            .login-header {
                padding: 40px 30px;
            }
            
            .login-content {
                padding: 40px 30px;
            }
            
            .login-header h1 {
                font-size: 1.8rem;
            }
            
            .welcome-section h2 {
                font-size: 1.5rem;
            }
            
            .google-btn {
                padding: 14px;
                font-size: 1rem;
            }
        }
        
        /* Success animation */
        .success-animation {
            animation: successPulse 0.5s ease-in-out;
        }
        
        @keyframes successPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.02); }
        }
        
        /* Back to home link */
        .back-home {
            text-align: center;
            margin-top: 30px;
        }
        
        .back-home a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }
        
        .back-home a:hover {
            color: var(--secondary);
            transform: translateX(-5px);
        }
    </style>
    <script>
        // Firebase configuration - Get from environment variable or Firebase Console
        const firebaseConfig = {
        		apiKey: "AIzaSyAM61wFhV6v2z08TH32gZz1utxDGfqG2e4",
        		  authDomain: "realestatewebapp-907fb.firebaseapp.com",
        		  projectId: "realestatewebapp-907fb",
        		  storageBucket: "realestatewebapp-907fb.firebasestorage.app",
        		  messagingSenderId: "121414644636",
        		  appId: "1:121414644636:web:c092197321e68a794a4e59",
        		  measurementId: "G-6V88ZMSB02"
        };
        
        // Initialize Firebase
        firebase.initializeApp(firebaseConfig);
        
        function signInWithGoogle() {
            const btn = document.getElementById('googleSignInBtn');
            const spinner = document.getElementById('loadingSpinner');
            const btnText = document.querySelector('.btn-text');
            const errorDiv = document.getElementById('error');
            
            // Show loading state
            btn.disabled = true;
            spinner.style.display = 'inline-block';
            btnText.style.opacity = '0.7';
            errorDiv.textContent = '';
            errorDiv.style.display = 'none';
            
            const provider = new firebase.auth.GoogleAuthProvider();
            
            firebase.auth().signInWithPopup(provider)
                .then((result) => {
                    const user = result.user;
                    user.getIdToken().then((idToken) => {
                        authenticateWithBackend(idToken);
                    }).catch((error) => {
                        console.error('Error getting ID token:', error);
                        showError('Failed to get authentication token. Please try again.');
                        resetButton(btn, spinner, btnText);
                    });
                })
                .catch((error) => {
                    console.error("Google Sign-In Error:", error);
                    
                    let errorMessage = error.message;
                    if (error.code === 'auth/popup-closed-by-user') {
                        errorMessage = 'Sign-in popup was closed. Please try again.';
                    } else if (error.code === 'auth/cancelled-popup-request') {
                        errorMessage = 'Sign-in was cancelled. Please try again.';
                    } else if (error.code === 'auth/popup-blocked') {
                        errorMessage = 'Popup was blocked by your browser. Please allow popups for this site.';
                    }
                    
                    showError(errorMessage);
                    resetButton(btn, spinner, btnText);
                });
        }
        
        function authenticateWithBackend(idToken) {
            const formData = new FormData();
            formData.append('idToken', idToken);
            
            fetch('${pageContext.request.contextPath}/auth/google', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    // Show success animation
                    const btn = document.getElementById('googleSignInBtn');
                    btn.classList.add('success-animation');
                    btn.style.background = '#10b981';
                    
                    // Redirect to dashboard
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/dashboard';
                    }, 500);
                } else {
                    throw new Error(data.error || 'Authentication failed');
                }
            })
            .catch(error => {
                console.error("Backend Authentication Error:", error);
                showError(error.message || "Authentication failed. Please try again.");
                resetButton(
                    document.getElementById('googleSignInBtn'),
                    document.getElementById('loadingSpinner'),
                    document.querySelector('.btn-text')
                );
            });
        }
        
        function showError(message) {
            const errorDiv = document.getElementById('error');
            errorDiv.innerHTML = `
                <i class="fas fa-exclamation-circle"></i>
                <span>${message}</span>
            `;
            errorDiv.style.display = 'flex';
        }
        
        function resetButton(btn, spinner, btnText) {
            btn.disabled = false;
            spinner.style.display = 'none';
            btnText.style.opacity = '1';
        }
        
        // Add enter key support for accessibility
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Enter') {
                signInWithGoogle();
            }
        });
        
        // Add ripple effect for button
        document.getElementById('googleSignInBtn').addEventListener('click', function(e) {
            // Create ripple element
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;
            
            ripple.style.cssText = `
                position: absolute;
                border-radius: 50%;
                background: rgba(255, 255, 255, 0.3);
                transform: scale(0);
                animation: ripple 0.6s linear;
                width: ${size}px;
                height: ${size}px;
                left: ${x}px;
                top: ${y}px;
            `;
            
            this.appendChild(ripple);
            
            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    </script>
</head>
<body>
    <!-- Header included from Header.jsp -->
    <%@ include file="/Header.jsp" %>
    
    <main class="login-main">
        <div class="login-wrapper">
            <div class="login-card">
                <!-- Header -->
                <div class="login-header">
                    <div class="logo-container">
                        <div class="logo">
                            <i class="fas fa-home"></i>
                        </div>
                    </div>
                    <h1>Real Estate Portal</h1>
                    <p>Your trusted property marketplace</p>
                </div>
                
                <!-- Content -->
                <div class="login-content">
                    <div class="welcome-section">
                        <h2>Welcome Back!</h2>
                        <p>Sign in with your Google account to access your dashboard and manage properties</p>
                    </div>
                    
                    <!-- Google Sign-In Button -->
                    <button id="googleSignInBtn" class="google-btn" onclick="signInWithGoogle()">
                        <div class="google-icon">
                            <i class="fab fa-google"></i>
                        </div>
                        <span class="btn-text">Sign in with Google</span>
                        <div id="loadingSpinner" class="loading-spinner"></div>
                    </button>
                    
                    <!-- Error Message -->
                    <div id="error" class="error-message" style="display: none;"></div>
                    
                    <!-- Footer -->
                    <div class="login-footer">
                        <p>
                            By continuing, you agree to our 
                            <a href="#" class="terms-link">Terms of Service</a> and 
                            <a href="#" class="terms-link">Privacy Policy</a>.
                            Your privacy and security are important to us.
                        </p>
                    </div>
                    
                    <!-- Back to Home Link -->
                    <div class="back-home">
                        <a href="index.jsp">
                            <i class="fas fa-arrow-left"></i>
                            Back to Home
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <script>
        // Add CSS for ripple animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
        
        // Auto-focus the button for accessibility
        window.addEventListener('load', function() {
            document.getElementById('googleSignInBtn').focus();
        });
        
        // Check if user is already logged in
        <%
             loggedUser = (User) session.getAttribute("user");
            if (loggedUser != null) {
        %>
            // Redirect to dashboard if already logged in
            window.location.href = '${pageContext.request.contextPath}/dashboard';
        <%
            }
        %>
    </script>
    
<%@ include file="/Footer.jsp" %>

</body>
</html>