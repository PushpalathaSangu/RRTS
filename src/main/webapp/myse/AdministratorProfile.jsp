<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="rrts.Administrator.model.Administrator_details" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administarter Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS-->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="user.css">
    <style>
        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .profile-title {
            font-weight: bold;
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
        }

        .btn-edit-profile {
            width: 100%;
            font-weight: bold;
        }
    </style>
</head>

<body>
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
                    <a class="nav-link" href="index.html"><i class="fas fa-home"></i> Home</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#footer"><i class="fas fa-envelope"></i> Contact Us</a>
                </li>

            </ul>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container-fluid main">
        <div class="row">
        <!-- sidebar -->
        <div class="col-md-3 col-lg-2 sidebar">
            <h4 class="sidebar-title">Menu</h4>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="AdministratorProfile.jsp">
                        <i class="fas fa-user"></i> Profile
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="AdministratorComplaints.jsp">
                        <i class="fas fa-file-alt"></i> List of Complaints
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="AdministratorAssigned.jsp">
                        <i class="fas fa-calculator"></i>Machinary
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="AdministratorSettings.jsp">
                        <i class="fas fa-cog"></i> Settings
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="AdministratorLogout.jsp">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
			<% Administrator_details ad=new  Administrator_details();%>
            <!-- Profile Content -->
            <div class="col-md-9 col-lg-10 p-4">
                <div class="card">
                    <div class="card-header bg-dark text-white">
                        <h2>Administarter Profile</h2>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 text-center">
                                <img src="mayor.png" alt="Admin Photo" class="rounded-circle img-fluid"
                                    style="width: 150px; height: 150px;">
                                <h4 class="mt-3"><%=ad.getName() %></h4>
                                <p>Administarter</p>
                            </div>
                            <div class="col-md-8">
                                <h5>Personal Information</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <th>Name:</th>
                                        <td><%=ad.getName() %></td>
                                    </tr>
                                    <tr>
                                        <th>Email:</th>
                                        <td><%=ad.getEmail() %></td>
                                    </tr>
                                    <tr>
                                        <th>Phone:</th>
                                        <td><%=ad.getPhoneNumber() %></td>
                                    </tr>
                                    <tr>
                                        <th>Address:</th>
                                        <td><%=ad.getLocation()%></td>
                                    </tr>
                                </table>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer -->
    <footer class="bg-dark text-white pt-4 pb-3" id="footer">
        <div class="container text-center text-md-left">
            <div class="row">
                <!-- Contact Information -->
                <div class="col-md-4 mb-3">
                    <h5>Contact Us</h5>
                    <p>Email: rrts@gmail.com</p>
                    <p>Phone: +1 234 567 890</p>
                    <p>Address: Public Works Department, City Name</p>
                </div>

                <!-- About RRTS -->
                <div class="col-md-4 mb-3">
                    <h5>About RRTS</h5>
                    <p>The Road Repair and Tracking System (RRTS) is dedicated to efficient, transparent, and timely
                        management of road repairs and maintenance for our city's infrastructure.</p>
                </div>

                <!-- Social Media Links -->
                <div class="col-md-4 mb-3 text-center text-md-left">
                    <h5>Follow Us</h5>
                    <a href="#" class="text-white mr-3"><i class="fab fa-facebook fa-2x"></i></a>
                    <a href="#" class="text-white mr-3"><i class="fab fa-instagram fa-2x"></i></a>
                    <a href="#" class="text-white mr-3"><i class="fab fa-twitter fa-2x"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-linkedin fa-2x"></i></a>
                </div>
            </div>
        </div>
        <div class="text-center py-3 mt-3">
            &copy; 2024 Road Repair and Tracking System (RRTS). All rights reserved.
        </div>
    </footer>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>


</html>