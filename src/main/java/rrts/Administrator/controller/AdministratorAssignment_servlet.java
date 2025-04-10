package rrts.Administrator.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import rrts.Administrator.model.Administrator_details;
@SuppressWarnings("serial")
@WebServlet("/administrator_assign")
public class AdministratorAssignment_servlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("manpower:"+req.getParameter("manpower_assigned"));
		int manpower=Integer.parseInt(req.getParameter("manpower_assigned"));
		int machinery =Integer.parseInt(req.getParameter("machinery_assigned"));
		int id=Integer.parseInt(req.getParameter("id"));
		System.out.println(manpower);
		System.out.println(machinery);
		System.out.println(id);
		Administrator_details ad=new Administrator_details();
		String query="UPDATE complaint set manpowerAssign=? ,machinaryAssign=? where c_id=?";
		String macman_query ="SELECT * FROM mac_man";
		String complaint_query = "SELECT * FROM complaint where c_id=?";
		String update_macman ="UPDATE mac_man set machinery =? ,manpower=?";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db","root","Sreeja@23/08");
			PreparedStatement ps =conn.prepareStatement(query);
			PreparedStatement ps1=conn.prepareStatement(macman_query);
			PreparedStatement ps2=conn.prepareStatement(update_macman);
			PreparedStatement ps3=conn.prepareStatement(complaint_query);
			
			
			ps3.setInt(1,id);
			ResultSet comtable = ps3.executeQuery();
			int table_man=0;
			int table_mac=0;
			if(comtable.next()) {
				table_man=comtable.getInt("manpowerAssign");
				table_mac=comtable.getInt("machinaryAssign");

			}
			ResultSet rs = ps1.executeQuery();
			if(rs.next()) {
				int Available_machinery =rs.getInt("machinery");
				int Available_manpower = rs.getInt("manpower");
				if(Available_machinery > machinery   &&  Available_manpower>manpower) {
					Available_machinery=Available_machinery-machinery;
					Available_manpower=Available_manpower-manpower;
					ps.setInt(1,manpower+table_man);
					ps.setInt(2, machinery+table_mac);
					ps.setInt(3, id);
					ps.executeUpdate();
					ps2.setInt(2, Available_manpower);
					ps2.setInt(1, Available_machinery);
					ps2.executeUpdate();
				}
				System.out.println("Successfully inserted");
				resp.sendRedirect(req.getContextPath() + "/myse/AdministratorAssigned.jsp");
			}
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
