package rrts.workManager.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@SuppressWarnings("serial")
@WebServlet("/update_status")
public class workManager_Status_update extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req,resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String status = req.getParameter("updateStatus");
		int id=Integer.parseInt(req.getParameter("id"));
		String query = "UPDATE complaint set status=? where c_id=?";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db" , "root" , "Sreeja@23/08");
			PreparedStatement ps=con.prepareStatement(query);
			ps.setString(1, status);
			ps.setInt(2, id);
			ps.executeUpdate();
			System.out.println("sucessfully updated status");
			resp.sendRedirect(req.getContextPath() + "/myse/workmanagerStatusUpdate.jsp");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
