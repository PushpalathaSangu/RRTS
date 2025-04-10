<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import ="java.sql.*" %>
 <%@ page import ="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Budget and Resources</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <!-- Chart.js for charts -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Custom CSS -->
    <link rel="stylesheet" href="user.css">
    <style>
        .sidebar {
            margin-top:5.3px; /* Space between navbar and sidebar */
        }
        footer {
            margin-top:5.3px; /* Space between sidebar and footer */
        }
        .chart-heading {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
   
 
   
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="#">
        <img src="logo.jpg" alt="Logo" style="width: 40px; height: 40px; margin-right: 10px;">
        <span>Road Repair and Tracking System</span>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="MayorDashboard.html">
                    <i class="fas fa-home"></i>Home
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
    Connection conn = null;
    PreparedStatement ps = null;
    PreparedStatement ps1 = null;
    PreparedStatement ps2 = null;
    PreparedStatement ps3 = null;
    PreparedStatement ps4 = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;
    ResultSet rs4 = null;
    int machinery = 0;
    int manpower = 0;
    //type of complaints
	int pothole = 0;
	int erosion = 0;
	int drainage = 0;
	int crack = 0;
    try {
        String query = "SELECT * FROM mac_man";
        String c1="SELECT count(*) FROM complaint where complaintType='Potholes formation' ";
        String c2="SELECT count(*) FROM complaint where complaintType='Surface erosion' ";
        String c3="SELECT count(*) FROM complaint where complaintType='Drainage Issue' ";
        String c4="SELECT count(*) FROM complaint where complaintType='Crack sealing' ";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db", "root", "Sreeja@23/08");
        ps = conn.prepareStatement(query);
        //prepareStatements
         ps1 = conn.prepareStatement(c1);
         ps2 = conn.prepareStatement(c2);
         ps3 = conn.prepareStatement(c3);
         ps4 = conn.prepareStatement(c4);
        rs = ps.executeQuery();
        rs1 = ps1.executeQuery();
        rs2 = ps2.executeQuery();
        rs3 = ps3.executeQuery();
        rs4 = ps4.executeQuery();
        if (rs.next() && rs1.next() && rs2.next() && rs3.next() && rs4.next()) {
            machinery = rs.getInt("machinery");
            manpower = rs.getInt("manpower");
            pothole = rs1.getInt(1);
            erosion = rs2.getInt(1);
            drainage = rs3.getInt(1);
            crack = rs4.getInt(1);
        }
    } catch (Exception e) {
        System.out.println(e);
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
<div class="container-fluid">
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

        <!-- Main Content -->
        <main class="col-md-9 col-lg-10 ml-sm-auto px-md-4">
            <div class="pt-4">
                <h1 class="text-center">Statistics</h1>

                <!-- Complaints Statistics -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h5 class="chart-heading">Total Complaints Overview</h5>
                        <canvas id="complaintsChart"></canvas>
                    </div>
                    <div class="col-md-6">
                        <h5 class="chart-heading">Types of Complaints</h5>
                        <canvas id="complaintTypesChart"></canvas>
                    </div>
                </div>

                <!-- Resource Utilization -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h5 class="chart-heading">Machinery Utilization</h5>
                        <canvas id="machineryUtilizationChart"></canvas>
                    </div>
                    <div class="col-md-6">
                        <h5 class="chart-heading">Manpower Utilization</h5>
                        <canvas id="manpowerUtilizationChart"></canvas>
                    </div>
                </div>

                <!-- Budget Allocation -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h5 class="chart-heading">Budget Allocation by Department</h5>
                        <canvas id="budgetAllocationChart"></canvas>
                    </div>
                    <div class="col-md-6">
                        <h5 class="chart-heading">Monthly Budget Spending</h5>
                        <canvas id="monthlyBudgetChart"></canvas>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white pt-4 pb-3" id="footer">
    <div class="container text-center text-md-left">
        <div class="row">
            <div class="col-md-4 mb-3">
                <h5>Contact Us</h5>
                <p>Email: rrts@gmail.com</p>
                <p>Phone: +1 234 567 890</p>
                <p>Address: Public Works Department, City Name</p>
            </div>
            <div class="col-md-4 mb-3">
                <h5>About RRTS</h5>
                <p>The Road Repair and Tracking System (RRTS) ensures efficient management of road repairs and maintenance.</p>
            </div>
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
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- Chart.js Script -->
<script>
    // Complaints Statistics Chart
       var manpower = <%=manpower%>;
       var machinery = <%=machinery%>;
       var pothole = <%=pothole%>;
       var erosion = <%=erosion%>;
       var drainage = <%=drainage%>;
       var crack = <%=crack%>;
    var ctxComplaints = document.getElementById('complaintsChart').getContext('2d');
    var complaintsChart = new Chart(ctxComplaints, {
        type: 'pie',
        data: {
            labels: ['Completed', 'Ongoing', 'Not Completed'],
            datasets: [{
                data: [120, 45, 25],
                backgroundColor: ['#28a745', '#ffc107', '#dc3545']
            }]
        }
    });
  // Complaint Types Chart
var ctxComplaintTypes = document.getElementById('complaintTypesChart').getContext('2d');
var complaintTypesChart = new Chart(ctxComplaintTypes, {
    type: 'bar',
    data: {
        labels: ['Potholes', 'Surface Erosion', 'Drainage', 'Crack Sealing'], // Shared labels for the x-axis
        datasets: [
            {
                label: 'No. of Pothole Complaints',
                data: [pothole, 0, 0, 0], // Only data for Potholes
                backgroundColor: '#007bff'
            },
            {
                label: 'No. of Soil Erosion Complaints',
                data: [0, erosion, 0, 0], // Only data for Soil Erosion
                backgroundColor:"#dc3545"
            },
            {
                label: 'No. of Drainage Complaints',
                data: [0, 0, drainage, 0], // Only data for Drainage
                backgroundColor: '#ffc107'
            },
            {
                label: 'No. of Crack sealing Complaints',
                data: [0, 0, 0, crack], // Only data for Others
                backgroundColor: '#6c757d'
            }
        ]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                position: 'top', // Display the legend at the top
            }
        },
        scales: {
            x: {
                stacked: true // Keep the bars stacked for better display if needed
            },
            y: {
                beginAtZero: true // Start y-axis at 0
            }
        },
        // Customize bar thickness
        datasets: {
            bar: {
                barThickness: 40, // Set the exact thickness of bars
                maxBarThickness: 50, // Prevent bars from getting too thick
                minBarLength: 5 // Set a minimum bar length for visibility
            }
        }
    }
});


    // Machinery Utilization Chart
    var ctxMachinery = document.getElementById('machineryUtilizationChart').getContext('2d');
    var machineryUtilizationChart = new Chart(ctxMachinery, {
        type: 'doughnut',
        data: {
            labels: ['In Use', 'Idle'],
            datasets: [{
                data: [70, machinery],
                backgroundColor: ['#28a745', '#6c757d']
            }]
        }
    });

    // Manpower Utilization Chart
    var ctxManpower = document.getElementById('manpowerUtilizationChart').getContext('2d');
    var manpowerUtilizationChart = new Chart(ctxManpower, {
        type: 'doughnut',
        data: {
            labels: ['Dep', 'Available'],
            datasets: [{
                data: [20, manpower],
                backgroundColor: ['#ffc107', '#6c757d']
            }]
        }
    });

    
</script>
</body>
</html>
