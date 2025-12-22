<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Real Estate</title>
    <script src="https://www.gstatic.com/firebasejs/9.6.0/firebase-app-compat.js"></script>
    <script src="https://www.gstatic.com/firebasejs/9.6.0/firebase-auth-compat.js"></script>
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
            const provider = new firebase.auth.GoogleAuthProvider();
            firebase.auth().signInWithPopup(provider)
                .then((result) => {
                    const user = result.user;
                    user.getIdToken().then((idToken) => {
                        authenticateWithBackend(idToken);
                    });
                })
                .catch((error) => {
                    console.error("Google Sign-In Error:", error);
                    document.getElementById("error").innerText = error.message;
                });
        }
        
        function authenticateWithBackend(idToken) {
            const formData = new FormData();
            formData.append('idToken', idToken);
            
            fetch('${pageContext.request.contextPath}/auth/google', {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    window.location.href = '${pageContext.request.contextPath}/dashboard';
                } else {
                    document.getElementById("error").innerText = data.error;
                }
            })
            .catch(error => {
                console.error("Backend Authentication Error:", error);
                document.getElementById("error").innerText = "Authentication failed";
            });
        }
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .google-btn {
            background: #4285f4;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
        }
        .google-btn:hover {
            background: #357ae8;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Real Estate Portal</h1>
        <p>Sign in with Google to continue</p>
        <button class="google-btn" onclick="signInWithGoogle()">
            Sign in with Google
        </button>
        <div id="error" class="error"></div>
    </div>
</body>
</html>