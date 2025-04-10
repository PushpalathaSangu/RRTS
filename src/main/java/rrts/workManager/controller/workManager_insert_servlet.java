package rrts.workManager.controller;

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
import rrts.workManager.model.workManager_details;
@SuppressWarnings("serial")
@WebServlet("/insert_WorkManager")
public class workManager_insert_servlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username=null;
		String password=null;
		String usertype=null;
		Connection conn=null;
		ResultSet rs=null;
		PreparedStatement ps=null;
		workManager_details wd=new workManager_details();
		Cookie[] cookie = req.getCookies();
		if(cookie != null) {
			for (Cookie cookies:cookie) {
				if(cookies.getName().equals("username")) {
					username=cookies.getValue();
				}
				if(cookies.getName().equals("usertype")) {
					usertype=cookies.getValue();
				}
				if(cookies .getName().equals("userpassword")) {
					password=cookies.getValue();
				}
			}
			System.out.println("cookie retrieved:"+username);
			System.out.println("cookie retrieved:"+usertype);
			System.out.println("cookie retrieved:"+password);

			if(username ==null || password==null || usertype==null) {
				resp.sendRedirect("noo");
			}
		}
		String query = "SELECT * FROM signin where name=? and userType=? and password=?";
		try {

			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		}
		try {

			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db" , "root" , "Sreeja@23/08");

			ps=conn.prepareStatement(query);
			ps.setString(1, username);
			ps.setString(2, usertype);
			ps.setString(3, password);

			rs=ps.executeQuery();

			int id=0;

			if(rs.next()) {

				id=rs.getInt("id");

				String email=rs.getString("email");

				Long phnum=rs.getLong("phoneNumber");

				String location =rs.getString("location");

				wd.setId(id);
				wd.setEmail(email);
				System.out.println(wd.getEmail());
				wd.setPhoneNumber(phnum);
				wd.setName(username);
				wd.setLocation(location);

				System.out.println("vgdjgvdbv smnhbxsh"+wd.getPhoneNumber());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		String checkSQL = "SELECT COUNT(*) FROM workmanager WHERE email = ?";
		PreparedStatement checkStmt;
		ResultSet r;
		try {
			checkStmt = conn.prepareStatement(checkSQL);

			checkStmt.setString(1, wd.getEmail());
			r = checkStmt.executeQuery();
			int count=0;
			if(r.next()) {
				count = r.getInt(1);
			}
			if(count==0) {
				String workManager_query ="INSERT INTO workmanager (name,email,phoneNumber,location) values(?,?,?,?) ";
				PreparedStatement ps1=conn.prepareStatement(workManager_query);
				ps1.setString(1, wd.getName());
				ps1.setString(2,wd.getEmail());
				ps1.setLong(3, wd.getPhoneNumber());
				ps1.setString(4, wd.getLocation());

				ps1.executeUpdate();
				System.out.println("WorkManager successfully inserted");

				resp.sendRedirect(req.getContextPath() + "/myse/workmanagerProfile.jsp");
			}else {
				System.out.println("Record with ID " + wd.getEmail() + " already exists.");
				resp.sendRedirect(req.getContextPath() + "/myse/workmanagerProfile.jsp");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		}
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req,resp);
	}
}
