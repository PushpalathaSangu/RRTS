package rrts.resident.controller;
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
import rrts.resident.model.Resident_details;

@SuppressWarnings("serial")
@WebServlet("/com_resgister")
public class resident_complaint_servlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String complaintType=req.getParameter("complaintType");
		String location=req.getParameter("location");
		String description=req.getParameter("description");
		Resident_details details =new Resident_details();
		int id=details.getId();
		System.out.println(id);
		String query="SELECT name ,email , phoneNumber FROM signin where id=?";
		String check="SELECT complaintType,location,Description FROM complaint where id=?";
		String resident_query ="UPDATE resident SET complaintType = ?, location = ?, Description = ? WHERE id = ?";
		String complaint_query ="UPDATE complaint SET complaintType = ?, location = ?, Description = ? ,status = ? WHERE id = ?";
		String new_complaint="INSERT INTO complaint (id, name ,email,phoneNumber,complaintType,location,Description,status) VALUES(?,?,?,?,?,?,?,?)";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/rrts_db","root","Sreeja@23/08");
			PreparedStatement getName= conn.prepareStatement(query);
			getName.setInt(1, id);
			ResultSet rs =getName.executeQuery();
			String name=null;
			String email=null;
			long phoneNumber =-1;
			if(rs.next()) {
				name=rs.getString(1);
				email=rs.getString(2);
				phoneNumber=rs.getLong(3);
			}
			PreparedStatement cc= conn.prepareStatement(check);
			cc.setInt(1, id);
			ResultSet s=cc.executeQuery();
			System.out.println("came up to here");
			if(s.next()) {
				if(s.getString(1) == null && s.getString(2) == null && s.getString(3) == null) {
					PreparedStatement ps= conn.prepareStatement(resident_query);
					ps.setString(1, complaintType);
					ps.setString(2, location);
					ps.setString(3, description);
					ps.setInt(4, id);
					ps.executeUpdate();
					PreparedStatement ps2= conn.prepareStatement(complaint_query);
					ps2.setString(1, complaintType);
					ps2.setString(2, location);
					ps2.setString(3, description);
					ps2.setString(4, "Not Scheduled");
					ps2.setInt(5, id);
					ps2.executeUpdate();
					System.out.println("if");
				}
				else {
					PreparedStatement ps= conn.prepareStatement(new_complaint);
					ps.setInt(1,id);
					ps.setString(2,name);
					ps.setString(3, email);
					ps.setLong(4,phoneNumber);
					ps.setString(5,complaintType);
					ps.setString(6, location);
					ps.setString(7,description );
					ps.setString(8, "Not Scheduled");
					ps.executeUpdate();
					System.out.println("else");
				}
			}
			else {
				PreparedStatement ps= conn.prepareStatement(new_complaint);
				ps.setInt(1,id);
				ps.setString(2,name);
				ps.setString(3, email);
				ps.setLong(4,phoneNumber);
				ps.setString(5,complaintType);
				ps.setString(6, location);
				ps.setString(7,description );
				ps.setString(8, "Not Scheduled");
				ps.executeUpdate();
			}
			System.out.println("success");
			resp.sendRedirect(req.getContextPath() + "/myse/complaintStatus.jsp");
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
