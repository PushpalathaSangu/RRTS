package rrts.Mayor.controller;

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
import rrts.Mayor.model.Mayor_details;
@SuppressWarnings("serial")
@WebServlet("/MayorProfile")
public class MayorServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username=null;
		String usertype=null;
		String password=null;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet  rs;
		Mayor_details md = new Mayor_details();
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
				md = new Mayor_details();

				if(rs.next()) {
					String location = rs.getString("location");
					String email=rs.getString("email");
					Long phnum=rs.getLong("phoneNumber");
					int id=rs.getInt("id");
					md.setName(username);
					md.setEmail(email);
					md.setPhoneNumber(phnum);
					md.setLocation(location);
					md.setId(id);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String checkSQL = "SELECT COUNT(*) FROM mayor WHERE email = ?";
			PreparedStatement checkStmt;
			ResultSet r;
			try {
				checkStmt = conn.prepareStatement(checkSQL);

				checkStmt.setString(1, md.getEmail());
				r = checkStmt.executeQuery();
				r.next();
				int count = r.getInt(1);
				if(count==0) {
					String resident_query ="INSERT INTO mayor (name,email,phoneNumber,location) values(?,?,?,?) ";
					PreparedStatement ps1=conn.prepareStatement(resident_query);
					ps1.setString(1, md.getName());
					ps1.setString(2,md.getEmail());
					ps1.setLong(3, md.getPhoneNumber());
					ps1.setString(4 , md.getLocation());
					ps1.executeUpdate();

					resp.sendRedirect(req.getContextPath() + "/myse/MayorProfile.jsp");
				}else {
					System.out.println("Record with ID " +md.getEmail() + " already exists.");
					resp.sendRedirect(req.getContextPath() + "/myse/MayorProfile.jsp");
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
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
}
