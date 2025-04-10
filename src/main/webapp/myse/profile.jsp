<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="rrts.resident.model.Resident_details" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="rrts.resident.controller.resident_servlet" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Status of Complaints</title>
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
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar">
                <h4 class="sidebar-title">Menu</h4>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="profile.jsp"><i class="fas fa-user"></i> Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="raiseComplaint.jsp"><i class="fas fa-file-alt"></i> Raise Complaint</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="complaintStatus.jsp"><i class="fas fa-tasks"></i> Status of Complaints</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="settings.jsp"><i class="fas fa-cog"></i> Settings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="rating.jsp"><i class="fas fa-star"></i> Rating</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </li>
                </ul>
            </div>

            <!-- Profile Content -->
            <div class="col-md-9 col-lg-10 p-4">
                <div class="card">
                    <div class="card-header bg-dark text-white">
                        <h2>Resident Profile</h2>
                    </div>
                    <%
                        Resident_details sd = null;
                        ResultSet rs = null;
                        String username = null;
                        String usertype = null;
                        String password = null;
                        Cookie[] cookies = request.getCookies();
                        if (cookies != null) {
                            for (Cookie cookie : cookies) {
                                if (cookie.getName().equals("username")) {
                                    username = cookie.getValue();
                                }
                                if (cookie.getName().equals("usertype")) {
                                    usertype = cookie.getValue();
                                }
                                if (cookie.getName().equals("userpassword")) {
                                    password = cookie.getValue();
                                }
                            }

                            if (username == null || usertype == null || password == null) {
                                response.getWriter().println("nooo");
                                return;
                            }
                            System.out.println("cookie retrieved " + username);
                            System.out.println("cookie retrieved " + usertype);
                        }
                        try {
                            String query = "SELECT * FROM signin WHERE name = ? AND userType = ? AND password = ?";
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db", "root", "Sreeja@23/08");
                            PreparedStatement ps = conn.prepareStatement(query);
                            ps.setString(1, username);
                            ps.setString(2, usertype);
                            ps.setString(3, password);
                            rs = ps.executeQuery();
                            sd = new Resident_details();
                            if (rs.next()) {
                                int id = rs.getInt("id");
                                String email = rs.getString("email");
                                Long phnum = rs.getLong("phoneNumber");
                                String location = rs.getString("location");
                                sd.setId(id);
                                sd.setName(username);
                                sd.setEmail(email);
                                sd.setPhoneNo(phnum);
                                sd.setLocation(location);
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 text-center">
                                <img src="mayor.png" alt="Admin Photo" class="rounded-circle img-fluid"
                                    style="width: 150px; height: 150px;">
                                <h4 class="mt-3"><%= sd.getName() %></h4>
                                <p>Resident</p>
                            </div>
                            <div class="col-md-8">
                                <h5>Personal Information</h5>
                                <table class="table table-borderless">
                                    <tr>
                                        <th>Name:</th>
                                        <td><%= sd.getName() %></td>
                                    </tr>
                                    <tr>
                                        <th>Email:</th>
                                        <td><%= sd.getEmail() %></td>
                                    </tr>
                                    <tr>
                                        <th>Phone:</th>
                                        <td><%= sd.getPhoneNo() %></td>
                                    </tr>
                                    <tr>
                                        <th>Address:</th>
                                        <td><%= sd.getLocation() %></td>
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
