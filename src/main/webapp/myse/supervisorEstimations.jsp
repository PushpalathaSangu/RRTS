<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="rrts.supervisor.model.supervisor_details" %>
<%@ page import ="rrts.supervisor.model.com" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="jakarta.servlet.http.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>List of Complaints</title>
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
                    <a class="nav-link" href="supervisorProfile.jsp">
                        <i class="fas fa-user"></i> Profile
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="supervisorComplaint.jsp">
                        <i class="fas fa-file-alt"></i> List of Complaints
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="supervisorEstimations.jsp">
                        <i class="fas fa-calculator"></i> Estimations
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="supervisorSettings.jsp">
                        <i class="fas fa-cog"></i> Settings
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="supervisorLogout.jsp">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
       
        <%  
        	
            com c = new com();
            supervisor_details sd = new supervisor_details();
            String query = "SELECT name, complaintType, location, id, c_id, status, manpower, machinary, severity, days,isAssigned FROM complaint WHERE location=? and clerkAssigned=? ";
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db", "root", "Sreeja@23/08");
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, sd.getLocation());
            ps.setString(2 , "Assigned");
            ResultSet rs = ps.executeQuery();
        %>
        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 main-content" id="main">
            <div class="container">
                <h1>List of Complaints</h1>
                <div class="card mt-3">
                    <div class="card-header">
                        Complaints Overview
                    </div>
                    <div class="card-body">
                    
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">Name</th>
                                    <th scope="col">Complaint</th>
                                    <th scope="col">Address</th>
                                    <th scope="col">Status</th>
                                    <th scope="col">Manpower</th>
                                    <th scope="col">Machinery</th>
                                    <th scope="col">Severity</th>
                                    <th scope="col">No. of Days</th>
                                    <th scope="col">Action</th>
                                </tr>
                            </thead>
                           <%
								    if (!rs.isBeforeFirst()) {
								        out.println("<tr><td colspan='8'>No data available.</td></tr>");
								    } else {
								        while (rs.next()) { 
								            boolean isAssigned = rs.getBoolean("isAssigned"); // or use rs.getInt("isAssigned") == 1 if stored as int
									%>
                           <form action="${pageContext.request.contextPath}/supervisor_assign?id=<%= rs.getInt("c_id") %>" method="post">
                            <tbody>
		                            
                                <tr>
                                    <td><%= rs.getString("name") %></td>
                                    <td><%= rs.getString("complaintType") %></td>
                                    <td><%= rs.getString("location") %></td>
                                    <td>
					                    <input type="text" class="form-control" name="status"
					                        value="<%= rs.getString("status").equalsIgnoreCase("Not Scheduled")
 ? "" : rs.getString("status") %>"
					                        placeholder="Enter Status">
					                </td>
                                    <td>
                                        <input type="number" class="form-control" name="manpower" 
                                               value="<%= rs.getInt("manpower") > 0 ? rs.getInt("manpower") : "" %>" 
                                               placeholder="Enter manpower">
                                    </td>
                                    <td>
                                        <input type="number" class="form-control" name="machinery" 
                                               value="<%= rs.getInt("machinary") > 0 ? rs.getInt("machinary") : "" %>" 
                                               placeholder="Enter machinery">
                                    </td>
                                    <td>
                                        <input type="number" class="form-control" name="severity" 
                                               value="<%= rs.getInt("severity") > 0 ? rs.getInt("severity") : "" %>" 
                                               placeholder="Enter severity">
                                    </td>
                                    <td>
                                        <input type="number" class="form-control" name="days" 
                                               value="<%= rs.getInt("days") > 0 ? rs.getInt("days") : "" %>" 
                                               placeholder="Enter no. of days">
                                    </td>
									<td>
								        <% if (isAssigned) { %>
								            <span class="text-success">&#10003;</span>
								        <% } else { %>
								            <button class="btn btn-primary" type="submit">Submit</button>
								        <% } %>
								        </form>
								    </td>                                    
                                </tr>
                            </tbody>
                            </form>
                            <% } 
								}%>
                        </table>
                        
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
                <p>The Road Repair and Tracking System (RRTS) is dedicated to efficient, transparent, and timely management of road repairs and maintenance for our city's infrastructure.</p>
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

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
