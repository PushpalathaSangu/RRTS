package rrts.supervisor.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import rrts.supervisor.model.supervisor_details;

@SuppressWarnings("serial")
@WebServlet("/insert_into_table")
public class supervisor_insertTable extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username=null;
		String usertype=null;
		String password=null;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet  rs;
		supervisor_details sd = new supervisor_details();
		Cookie[] cookies =req.getCookies();
		if(cookies != null) {
			for (Cookie cookie : cookies) {
				if(cookie.getName().equals("username")) {
					username = cookie.getValue();
				}
				if(cookie.getName().equals("usertype")) {
					usertype= cookie.getValue();
				}
				if(cookie.getName().equals("userpassword")) {
					password = cookie.getValue();
				}
			}

			if(username == null || usertype == null || password==null) {
				resp.getWriter().println("nooo");

				return ;
			}

			System.out.println("cookie retrieved "+username);
			System.out.println("cookie retrived"+usertype);
			String query = "SELECT * FROM signin where name=? and usertype=? and password = ?";
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
			} catch (ClassNotFoundException e) {

				e.printStackTrace();
			}
			try {
				conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db","root","Sreeja@23/08");
				ps = conn.prepareStatement(query);
				ps.setString(1, username);
				ps.setString(2, usertype);
				ps.setString(3, password);
				rs = ps.executeQuery();
				sd = new supervisor_details ();

				if(rs.next()) {
					String location = rs.getString("location");
					String email=rs.getString("email");
					Long phnum=rs.getLong("phoneNumber");
					sd.setName(username);
					sd.setEmail(email);
					sd.setPhoneNumber(phnum);
					sd.setPassword(password);
					sd.setLocation(location);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String checkSQL = "SELECT COUNT(*) FROM supervisor WHERE email = ?";
			PreparedStatement checkStmt;
			ResultSet r;
			try {
				checkStmt = conn.prepareStatement(checkSQL);

				checkStmt.setString(1, sd.getEmail());
				r = checkStmt.executeQuery();
				r.next();
				int count = r.getInt(1);
				if(count==0) {
					String resident_query ="INSERT INTO supervisor (name,email,phoneNumber,location) values(?,?,?,?) ";
					PreparedStatement ps1=conn.prepareStatement(resident_query);
					ps1.setString(1, sd.getName());
					ps1.setString(2,sd.getEmail());
					ps1.setLong(3, sd.getPhoneNumber());
					ps1.setString(4 , sd.getLocation());
					ps1.executeUpdate();

					resp.sendRedirect(req.getContextPath() + "/myse/supervisorProfile.jsp");
				}else {
					System.out.println("Record with ID " + sd.getEmail() + " already exists.");
					resp.sendRedirect(req.getContextPath() + "/myse/supervisorProfile.jsp");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();

			}
		}else {

			resp.sendRedirect("login.jsp");
		}
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req,resp);
	}

}
