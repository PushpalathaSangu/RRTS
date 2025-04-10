 
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Signin Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        /* Center the form container */
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .background {
            background-image: url('signbg.jpg');
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
        }
        /* Success modal styling */
        .success-modal .modal-content {
            border: none;
            text-align: center;
        }
        .success-icon {
            font-size: 3rem;
            color: green;
        }
        /* Failure modal styling */
        .failure-modal .modal-content {
            border: none;
            text-align: center;
        }
        .failure-icon {
            font-size: 3rem;
            color: red;
        }
    </style>
</head>
<body class="background">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">
            <img src="logo.jpg" alt="Logo" style="width: 40px; height: 40px; margin-right: 10px;">
            <span id="page_heading">Road Repair and Tracking System</span>
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
        <h3 class="text-center mb-4">User Signup Form</h3>
        <form action="${pageContext.request.contextPath}/signup" method="post">
            <!-- Username Field -->
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" name="name" class="form-control" id="username" placeholder="Enter your username" required>
            </div>

            <!-- Email Field -->
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" name="email" class="form-control" id="email" placeholder="Enter your email" required>
            </div>

            <!-- Password Field -->
            <div class="form-group">
                <label for="password">Set Password</label>
                <input type="password" name="password" class="form-control" id="password" placeholder="Enter your password" required>
            </div>

            <!-- Select Field with 6 Options -->
            <div class="form-group">
                <label for="selectField">Select</label>
                <select name="userType" class="form-control" id="selectField" required>
                    <option>Choose</option>
                    <option>Resident</option>
                    <option>Clerk</option>
                    <option>Supervisor</option>
                    <option>Administrator</option>
                    <option>WorkManager</option>
                    <option>Mayor</option>
                </select>
            </div>

            <!-- City Field -->
            <div class="form-group">
                <label for="city">City</label>
                <input type="text" name="location" class="form-control" id="location" placeholder="Enter your city" required>
            </div>

            <!-- Phone Number Field -->
            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="tel" name="phoneNumber" class="form-control" id="phoneNumber" placeholder="Enter your phone number" pattern="[0-9]{10}" required>
                <small class="form-text text-muted">Please enter a 10-digit phone number.</small>
            </div>

            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary btn-block">Signup</button>
        </form>
    </div>

    <!-- Success Modal -->
    <div class="modal fade success-modal" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <i class="fas fa-check-circle success-icon"></i>
                    <h5 class="mt-3">${message}</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-dismiss="modal" onclick="redirectToHomePage()">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Failure Modal -->
    <div class="modal fade failure-modal" id="failureModal" tabindex="-1" aria-labelledby="failureModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <i class="fas fa-times-circle failure-icon"></i>
                    <h5 class="mt-3">${message}</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        $(document).ready(function() {
            var success = ${success};
            if (success === true) {
                $('#successModal').modal('show');
            } else if (success === false) {
                $('#failureModal').modal('show');
            }
        });

        function redirectToHomePage() {
            window.location.href = '<%= request.getContextPath() %>/myse/index.html';
        }
    </script>
</body>
</html>
    