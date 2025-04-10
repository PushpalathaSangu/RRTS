<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        /* Center the form container */
        .form-container {
            max-width: 500px;
            margin-top:50px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
           
  
        }
      .background {
   		background-image: url("loginbg.jpg");
    	background-repeat: no-repeat; /* Prevents repeating the image */
    	background-size: cover; /* Ensures the image covers the full area */
    	background-position: center; /* Centers the image */
    	width: 100%; /* Ensures the background covers the full width */
    	height: 100vh; /* Makes the element take the full height of the viewport */
    	position: fixed; /* Fix the background image */
    	top: 0;
    	left: 0;
    	z-index: -1; /* Places the background behind the content */
	}

/* Overlay to enhance text readability */
.background-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.3); /* Semi-transparent black */
    z-index: -1; /* Ensures overlay is below content */
}

        
    </style>
</head>
<body class="background">
	<!-- Navbar -->
   
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark" id="navbar">
        <a class="navbar-brand" href="#">
            <img src="logo.jpg" alt="Logo" style="width: 40px; height: 40px; margin-right: 10px;">
            <span id="page_heading" style="font-size: 30px;">Road Repair and Tracking System</span>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.html">
                        <i class="fas fa-home"></i> Home
                    </a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="signup.jsp">
                        <i class="fas fa-user-plus"></i> Sign In
                    </a>
                </li>
            </ul>
        </div>
    </nav>
    <!-- Form Container -->
    <div class="container form-container">
        <h3 class="text-center mb-4">User Login Form</h3>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <!-- Username Field -->
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" class="form-control" name="username" id="username" placeholder="Enter your username">
            </div>
            
            <!-- Password Field -->
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" class="form-control" name="password" id="password" placeholder="Enter your password">
            </div>
            
            <!-- Select Field with 6 Options -->
            <div class="form-group">
                <label for="selectField">Select</label>
                <select class="form-control" name="userType" id="selectField">
                    <option>Choose</option>
                    <option>Resident</option>
                    <option>Clerk</option>
                    <option>Supervisor</option>
                    <option>Administrator</option>
                    <option>WorkManager</option>
                    <option>Mayor</option>
                   
                </select>
            </div>
            
             <!-- Forgot Password Link -->
             <div class="form-group text-right">
                <a href="signup.jsp" class="text-primary">Forgot Password?</a>
            </div>
            
            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary btn-block">Submit</button>
        </form>
    </div>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    
    
    
