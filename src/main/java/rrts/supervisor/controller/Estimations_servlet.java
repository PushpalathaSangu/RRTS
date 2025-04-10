package rrts.supervisor.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import rrts.supervisor.model.com;
@SuppressWarnings("serial")
@WebServlet("/supervisor_assign")
public class Estimations_servlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String updateIsAssigned = "UPDATE complaint SET isAssigned = ? WHERE c_id = ?";
		String status=req.getParameter("status");
		String manpowerStr = req.getParameter("manpower");
		String machineryStr = req.getParameter("machinery");
		String severityStr = req.getParameter("severity");
		String daysStr = req.getParameter("days");
		String idstr=req.getParameter("id");
		System.out.println("id:"+idstr);
		int manpower =Integer.parseInt(req.getParameter("manpower"));
		int machinery =Integer.parseInt(req.getParameter("machinery"));
		int severity =Integer.parseInt(req.getParameter("severity"));
		int days = Integer.parseInt(req.getParameter("days"));
		int id=Integer.parseInt(req.getParameter("id"));
		com c=new com();
		try {

			String query = "UPDATE complaint set status = ? ,manpower=?,machinary=?,severity=?,days=? where c_id=?";
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db","root","Sreeja@23/08");
			PreparedStatement ps= conn.prepareStatement(query);
			PreparedStatement ps4 = conn.prepareStatement(updateIsAssigned);
			ps4.setBoolean(1, true);
			ps4.setInt(2, id);
			ps4.executeUpdate();
			ps.setString(1, status);
			ps.setInt(2, manpower);
			ps.setInt(3, machinery);
			ps.setInt(4, severity);
			ps.setInt(5, days);
			ps.setInt(6, id);
			ps.executeUpdate();
			resp.sendRedirect(req.getContextPath() + "/myse/supervisorEstimations.jsp");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
