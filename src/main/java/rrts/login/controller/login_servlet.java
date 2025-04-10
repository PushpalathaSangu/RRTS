package rrts.login.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import rrts.login.model.Login_details;
@SuppressWarnings("serial")
@WebServlet("/login")
public class login_servlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String usertype = req.getParameter("userType");
		Login_details login = new Login_details();
		login.setUsername(username);
		login.setPassword(password);
		login.setUsertype(usertype);


		String query = "SELECT * FROM signin WHERE name=? and password=? and userType=?" ;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db" , "root" , "Sreeja@23/08");
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1,username);
			ps.setString(2, password);
			ps.setString(3, usertype);
			ResultSet  rs = ps.executeQuery();

			if (rs.next()) {
				Cookie usernameCookie =new Cookie("username" , username);
				usernameCookie.setPath("/");
				Cookie usertypeCookie =new Cookie("usertype" , usertype);
				usernameCookie.setPath("/");
				Cookie userpasswordCookie =new Cookie("userpassword" , password);
				usernameCookie.setPath("/");
				resp.addCookie(usernameCookie);
				resp.addCookie(usertypeCookie);
				resp.addCookie(userpasswordCookie);
				System.out.println("Cookie username set: " + username);
				System.out.println("Cookie usertype set: " + usertype);
				System.out.println("cookie password set:"+password);
				switch (usertype.toLowerCase()) {
				case "resident":
					resp.sendRedirect(req.getContextPath() + "/myse/resident1.jsp");
					break;
				case "clerk":
					resp.sendRedirect(req.getContextPath() + "/myse/clerk.jsp");
					break;
				case "supervisor":
					resp.sendRedirect(req.getContextPath() + "/myse/supervisor.jsp");
					break;
				case "administrator":
					resp.sendRedirect(req.getContextPath() + "/myse/Administrater.jsp");
					break;
				case "workmanager":
					resp.sendRedirect(req.getContextPath()+"/myse/workmanager.jsp");
					break;
				case "mayor":
					resp.sendRedirect(req.getContextPath()+"/myse/Mayor.jsp");
					break;
				default:
					resp.getWriter().println("Unknown user type: " + usertype);
				}
			}
			else {
				resp.getWriter().println(usertype);
				resp.sendRedirect(req.getContextPath() + "/myse/signup.jsp");
			}

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
