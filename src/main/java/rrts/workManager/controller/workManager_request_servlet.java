package rrts.workManager.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import rrts.Administrator.model.Administrator_details;

@SuppressWarnings("serial")
@WebServlet("/request_administrator")
public class workManager_request_servlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("came to this page");
		int requestedMachinery = Integer.parseInt(req.getParameter("requestedMachinery"));
		int requestedManpower = Integer.parseInt(req.getParameter("requestedManpower"));
		String location = req.getParameter("location");
		String name=req.getParameter("username");
		System.out.println(name);
		// Store data in session
		HttpSession session = req.getSession();
		session.setAttribute("requestedMachinery", requestedMachinery);
		session.setAttribute("requestedManpower", requestedManpower);
		session.setAttribute("location", location);
		session.setAttribute("name",name);
		session.setAttribute("fromWorkmanager", "true");

		Administrator_details ad = new Administrator_details();
		ad.setLocation(location);

		resp.sendRedirect(req.getContextPath() + "/myse/AdministratorAssigned.jsp");
	}
}
