package rrts.resident.controller;

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
import rrts.resident.model.Resident_details;
@SuppressWarnings("serial")
@WebServlet("/click")
public class resident_servlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username=null;
		String usertype=null;
		String password=null;
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet  rs;
		Resident_details rd = new Resident_details();
		Cookie[] cookies =request.getCookies();
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
				response.getWriter().println("nooo");

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
				rd = new Resident_details();
				int id=0;
				if(rs.next()) {
					id=rs.getInt("id");
					String email=rs.getString("email");
					Long phnum=rs.getLong("phoneNumber");
					rd=new Resident_details();
					rd.setId(id);
					rd.setName(username);
					rd.setEmail(email);
					rd.setPhoneNo(phnum);
					rd.setPassword(password);
					System.out.println(id);
					System.out.println(email);
					System.out.println(phnum);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String checkSQL = "SELECT COUNT(*) FROM resident WHERE id = ?";
			PreparedStatement checkStmt;
			ResultSet r;
			try {
				checkStmt = conn.prepareStatement(checkSQL);

				checkStmt.setInt(1, rd.getId());
				r = checkStmt.executeQuery();
				r.next();
				int count = r.getInt(1);
				if(count==0) {
					String resident_query ="INSERT INTO resident (id,name,email,phoneNumber) values(?,?,?,?) ";
					PreparedStatement ps1=conn.prepareStatement(resident_query);
					ps1.setInt(1, rd.getId());
					ps1.setString(2, rd.getName());
					ps1.setString(3,rd.getEmail());
					ps1.setLong(4, rd.getPhoneNo());
					ps1.executeUpdate();
					System.out.println("Resident successfully inserted");
					String complaint_query ="INSERT INTO complaint (id,name,email,phoneNumber) values(?,?,?,?) ";
					PreparedStatement ps2=conn.prepareStatement(complaint_query);
					ps2.setInt(1, rd.getId());
					ps2.setString(2, rd.getName());
					ps2.setString(3,rd.getEmail());
					ps2.setLong(4, rd.getPhoneNo());
					ps2.executeUpdate();
					System.out.println("complaint successfully inserted ");
					response.sendRedirect(request.getContextPath() + "/myse/profile.jsp");
				}else {
					System.out.println("Record with ID " + rd.getId() + " already exists.");
					response.sendRedirect(request.getContextPath() + "/myse/profile.jsp");
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();

			}
		}else {

			response.sendRedirect("login.jsp");
		}
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
}

