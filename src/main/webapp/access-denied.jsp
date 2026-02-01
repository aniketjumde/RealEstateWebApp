<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Access Denied | RealEstate</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        padding: 20px;
    }
    
    .access-denied-container {
        background: white;
        padding: 60px;
        border-radius: 20px;
        width: 100%;
        max-width: 500px;
        text-align: center;
        box-shadow: 0 20px 60px rgba(0,0,0,0.15);
        border: 1px solid rgba(255,255,255,0.2);
        transform: translateY(0);
        animation: float 3s ease-in-out infinite;
    }
    
    @keyframes float {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-10px); }
    }
    
    .access-denied-icon {
        font-size: 5rem;
        color: #ef4444;
        margin-bottom: 30px;
        animation: pulse 2s infinite;
    }
    
    @keyframes pulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.1); }
    }
    
    .access-denied-container h2 {
        font-size: 2.5rem;
        font-weight: 800;
        color: #1e293b;
        margin-bottom: 15px;
        background: linear-gradient(135deg, #ef4444, #dc2626);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }
    
    .access-denied-container p {
        color: #64748b;
        font-size: 1.1rem;
        line-height: 1.6;
        margin-bottom: 30px;
    }
    
    .action-buttons {
        display: flex;
        gap: 15px;
        justify-content: center;
        flex-wrap: wrap;
        margin-top: 30px;
    }
    
    .btn-primary {
        padding: 15px 30px;
        background: linear-gradient(135deg, #0f766e, #0d6efd);
        color: white;
        text-decoration: none;
        border-radius: 10px;
        font-weight: 600;
        font-size: 1rem;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        border: none;
        cursor: pointer;
        font-family: inherit;
    }
    
    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(15, 118, 110, 0.3);
    }
    
    .btn-secondary {
        padding: 15px 30px;
        background: #f1f5f9;
        color: #0f766e;
        text-decoration: none;
        border-radius: 10px;
        font-weight: 600;
        font-size: 1rem;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        border: 2px solid #e2e8f0;
    }
    
    .btn-secondary:hover {
        background: #0f766e;
        color: white;
        border-color: #0f766e;
    }
    
    .icon-container {
        position: relative;
        margin-bottom: 30px;
    }
    
    .icon-ring {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 120px;
        height: 120px;
        border: 3px dashed #fee2e2;
        border-radius: 50%;
        animation: spin 20s linear infinite;
    }
    
    @keyframes spin {
        0% { transform: translate(-50%, -50%) rotate(0deg); }
        100% { transform: translate(-50%, -50%) rotate(360deg); }
    }
    
    @media (max-width: 600px) {
        .access-denied-container {
            padding: 40px 30px;
        }
        
        .access-denied-container h2 {
            font-size: 2rem;
        }
        
        .action-buttons {
            flex-direction: column;
        }
        
        .btn-primary, .btn-secondary {
            width: 100%;
            justify-content: center;
        }
    }
</style>
</head>

<body>

<div class="access-denied-container">
    <div class="icon-container">
        <div class="icon-ring"></div>
        <div class="access-denied-icon">
            <i class="fas fa-ban"></i>
        </div>
    </div>
    
    <h2>Access Denied</h2>
    <p>
        You do not have permission to access this page.<br>
        This action is restricted to the property owner or administrator.
    </p>
    
    <div class="action-buttons">
        <a href="property" class="btn-primary">
            <i class="fas fa-arrow-left"></i> Back to Properties
        </a>
        
        <a href="dashboard" class="btn-secondary">
            <i class="fas fa-tachometer-alt"></i> Go to Dashboard
        </a>
    </div>
</div>

</body>
</html>