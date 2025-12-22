package com.realestate.service;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.logging.Logger;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.realestate.enums.Role;
import com.realestate.factory.UserServiceFactory;
import com.realestate.model.User;

public class FirebaseAuthService {
    
    private static final Logger logger = Logger.getLogger(FirebaseAuthService.class.getName());
    private UserService userService=UserServiceFactory.getServiceInstance();
    private boolean initialized = false;
    
    public FirebaseAuthService() {
        initializeFirebase();
    }
    
    private void initializeFirebase() {
        try {
            if (FirebaseApp.getApps().isEmpty()) {
                // Get Firebase credentials from environment variable
                String firebaseCredentialsJson = System.getenv("FIREBASE_CREDENTIALS_JSON");
                
                if (firebaseCredentialsJson == null || firebaseCredentialsJson.trim().isEmpty()) {
                    throw new RuntimeException("FIREBASE_CREDENTIALS_JSON environment variable is not set");
                }
                
                InputStream serviceAccount = new ByteArrayInputStream(
                    firebaseCredentialsJson.getBytes());
                
                FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();
                
                FirebaseApp.initializeApp(options);
                logger.info("Firebase initialized successfully");
                initialized = true;
            } else {
                initialized = true;
            }
        } catch (Exception e) {
            logger.severe("Failed to initialize Firebase: " + e.getMessage());
            throw new RuntimeException("Firebase initialization failed", e);
        }
    }
    
    public User authenticateWithGoogle(String idToken) throws Exception {
        if (!initialized) {
            throw new RuntimeException("Firebase not initialized");
        }
        
        try {
            // Verify the ID token
            FirebaseToken decodedToken = FirebaseAuth.getInstance()
                .verifyIdToken(idToken);
            
            String uid = decodedToken.getUid();
            String email = decodedToken.getEmail();
            String name = decodedToken.getName();
            String picture = decodedToken.getPicture();
            
            // Check if user exists in database
            User user = userService.findByFirebaseUid(uid);
                
            
            if (user == null) {
                // Create new user with default USER role
                user = new User(email, name, uid);
                user.setProfilePicture(picture);
                user = userService.save(user);
            } else {
                // Update existing user
                user.setName(name);
                user.setProfilePicture(picture);
                if (user.getFirebaseUid() == null) {
                    user.setFirebaseUid(uid);
                }
                user = userService.save(user);
            }
            
            return user;
            
        } catch (FirebaseAuthException e) {
            logger.severe("Firebase authentication failed: " + e.getMessage());
            throw new Exception("Invalid ID token", e);
        }
    }
    
    public boolean isAdmin(User user) {
        return user != null && user.getRole() == Role.ADMIN;
    }
}