<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="rrts.Administrator.model.Administrator_details" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Administrator Assigned</title>
<!-- Bootstrap CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- Custom CSS -->
<link rel="stylesheet" href="user.css">
<style>
    .btn-green {
        background-color: green;
        border-color: green;
        color: white;
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

<%
    HttpSession session1 = request.getSession();
    Integer requestedMachinery = (Integer) session1.getAttribute("requestedMachinery");
    Integer requestedManpower = (Integer) session1.getAttribute("requestedManpower");
    String location = (String) session1.getAttribute("location");
    String name= (String) session1.getAttribute("name");
    String fromWorkmanager = (String) session1.getAttribute("fromWorkmanager");
%>

<!-- Main Content -->
<div class="container-fluid main">
    <div class="row">
        <!-- Sidebar -->
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
                        <i class="fas fa-calculator"></i>Machinery
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
        
        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 main-content" id="main">
            <div class="container">
                <h2>Machinery, Manpower assignment</h2>

                <!-- Table for Complaints Management -->
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Name</th>
                                <th scope="col">Complaint</th>
                                <th scope="col">Status</th>
                                <th scope="col">Estimated Machinery</th>
                                <th scope="col">Estimated Manpower</th>
                                <th scope="col">Assigned Machinery</th>
                                <th scope="col">Assigned Manpower</th>
                                <th scope="col">Submit</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Administrator_details ad = new Administrator_details();
                                String query = "SELECT name, complaintType, status, manpower, machinary, id, c_id, manpowerAssign, machinaryAssign FROM complaint WHERE location=? AND supervisor_verified=? AND status IN(?,?)";
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db", "root", "Sreeja@23/08");
                                PreparedStatement ps = conn.prepareStatement(query);
                                String adLocation = ad.getLocation();
                                ps.setString(1, adLocation);
                                ps.setString(2, "verified");
                                ps.setString(3, "scheduled");
                                ps.setString(4,"ongoing");
                                ResultSet rs = ps.executeQuery();
                                
                                while (rs.next()) {
                            %>
                            <tr>
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getString("complaintType") %></td>
                                <td><%= rs.getString("status") %></td>
                                <td><%= rs.getInt("machinary") %></td>
                                <td><%= rs.getInt("manpower") %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/administrator_assign?id=<%= rs.getInt("c_id") %>" method="post">
                                        <input type="number" class="form-control" name="manpower_assigned" 
                                               value="<%= rs.getInt("manpowerAssign") > 0 ? rs.getInt("manpowerAssign") : "" %>" 
                                               placeholder="Enter manpower">
                                </td>
                                <td>
                                        <input type="number" class="form-control" name="machinery_assigned" 
                                               value="<%= rs.getInt("machinaryAssign") > 0 ? rs.getInt("machinaryAssign") : "" %>" 
                                               placeholder="Enter machinery">
                                </td>
                                <td>
                                        <button id="submitButton" class="btn btn-primary" type="submit">Submit</button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Popup Modal -->
<%
    if ("true".equals(fromWorkmanager)) {
        session1.removeAttribute("fromWorkmanager"); // Clear the attribute after use
%>
<div class="modal fade" id="requestModal" tabindex="-1" role="dialog" aria-labelledby="requestModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="requestModalLabel">Requested Resources</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Resident Name: <%= name %></p>
        <p>Requested Machinery: <%= requestedMachinery %></p>
        <p>Requested Manpower: <%= requestedManpower %></p>
        <p>Location: <%= location %></p>
      </div>
      <div class="modal-footer">
        <button id="closeModalButton" class="btn btn-primary" type="button" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<%
    }
%>

<!-- Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    $(document).ready(function() {
        <% if ("true".equals(fromWorkmanager)) { %>
            $('#requestModal').modal('show');
        <% } %>
    });

    $('#closeModalButton').click(function() {
        $('#requestModal').modal('hide');
    });
</script>
</body>
</html>
