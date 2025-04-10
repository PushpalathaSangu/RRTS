<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import ="java.sql.*" %>
 <%@ page import ="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mayor</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="user.css">
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
                    <a class="nav-link" href="index.html">
                        <i class="fas fa-home"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#footer">
                        <i class="fas fa-envelope"></i> Contact Us
                    </a>
                </li>
            </ul>
        </div>
    </nav>
    <div class="container-fluid main">
        <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 sidebar">
            <h4 class="sidebar-title">Menu</h4>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="MayorProfile.jsp">
                        <i class="fas fa-user"></i> Profile
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="MayorOverview.jsp">
                        <i class="fas fa-list-alt"></i> Overview of Complaints
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="MayorStatistics.jsp">
                        <i class="fas fa-chart-pie"></i> Statistics Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="MayorSettings.jsp">
                        <i class="fas fa-cog"></i> Settings
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="MayorLogout.jsp">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
        	<%
        		String query = "SELECT count(status) FROM complaint where status='Not Scheduled' " ;
        		String count_all="SELECT count(*) FROM complaint";
        		String resolved="SELECT count(status) FROM complaint where status='completed'";
        		try{
        			Class.forName("com.mysql.cj.jdbc.Driver");
        			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db","root","Sreeja@23/08");
        			PreparedStatement ps = conn.prepareStatement(query);
        			PreparedStatement ps1=conn.prepareStatement(count_all);
        			PreparedStatement ps2=conn.prepareStatement(resolved);
        			ResultSet rs = ps.executeQuery();
        			ResultSet rs1=ps1.executeQuery();
        			ResultSet rs2=ps2.executeQuery();
        			if(rs.next() && rs1.next() && rs2.next()){
        		
        	
        	%>
            <!-- main content -->
            <main class="col-md-9 col-lg-10 ml-sm-auto px-md-4">
                <div class="pt-4">
                    <h1 class="display-4 text-center">Complaints Overview</h1>
                    <p class="lead text-center">An overview of the complaints received, resolved, and pending across the city.</p>
                    
                    <!-- Statistics Section -->
                    <div class="row text-center mb-4">
                        <div class="col-md-4">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <i class="fas fa-folder-open fa-3x text-primary mb-3"></i>
                                    <h5 class="card-title">Total Complaints</h5>
                                    <p class="card-text display-4" id="totalComplaints"><%= rs1.getInt(1) %></p>
                                    <p>Complaints received from residents</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <i class="fas fa-hourglass-half fa-3x text-warning mb-3"></i>
                                    <h5 class="card-title">Pending Complaints</h5>
                                    <p class="card-text display-4" id="pendingComplaints"><%= rs.getInt(1) %></p>
                                    <p>Complaints under review or action</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card shadow-sm">
                                <div class="card-body">
                                    <i class="fas fa-check-circle fa-3x text-success mb-3"></i>
                                    <h5 class="card-title">Resolved Complaints</h5>
                                    <p class="card-text display-4" id="resolvedComplaints"><%=rs2.getInt(1) %></p>
                                    <p>Complaints resolved and closed</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            	<%
        			}
        			
        			}catch(Exception e){
        			System.out.println(e);
        		} %>
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