package rrts.signup.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import rrts.signup.dao.signUpDao;
import rrts.signup.model.Details;

@WebServlet("/signup")
public class signup_servlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String userType = request.getParameter("userType");
		String location = request.getParameter("location");
		long phoneNumber = Long.parseLong(request.getParameter("phoneNumber"));

		Details details = new Details();
		details.setName(name);
		details.setEmail(email);
		details.setPassword(password);
		details.setUserType(userType);
		details.setLocationType(location);
		details.setPhoneNumber(phoneNumber);

		signUpDao DAO = new signUpDao();

		String message;
		if (DAO.isUserExists(email)) {
			message = "User already signed up with this email!";
			request.setAttribute("success", false);
		} else {
			DAO.insertUser(details);
			message = "User signed up successfully!";
			request.setAttribute("success", true);
		}

		request.setAttribute("message", message);
		request.getRequestDispatcher("/myse/signup.jsp").forward(request, response);

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
}
