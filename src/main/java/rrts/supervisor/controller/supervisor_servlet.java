package rrts.supervisor.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import rrts.supervisor.model.supervisor_details;

@SuppressWarnings("serial")
@WebServlet("/supervisor_verify")
public class supervisor_servlet  extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req,resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println(req.getParameter("id"));
		int id=Integer.parseInt(req.getParameter("id"));
		String query ="UPDATE complaint set supervisor_verified=? where c_id=?";
		supervisor_details sd=new supervisor_details();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db" , "root" , "Sreeja@23/08");
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, "verified");
			ps.setInt(2, id);
			ps.executeUpdate();
			System.out.println("sucessfully inserted");
			resp.sendRedirect(req.getContextPath() + "/myse/supervisorComplaint.jsp");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
