package rrts.signup.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import rrts.signup.model.Details;
public class signUpDao {
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/rrts_db";
	private static final String JDBC_USERNAME = "root";
	private static final String JDBC_PASSWORD = "Sreeja@23/08";

	public Connection getConnection() throws SQLException {
		return DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
	}

	public boolean isUserExists(String email) {
		String query = "SELECT * FROM signin WHERE email = ?";
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, email);
			ResultSet rs = statement.executeQuery();
			return rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public void insertUser(Details su) {
		String query = "INSERT INTO signin (name, email, password, userType,location,phoneNumber) VALUES (?, ?, ?, ?, ?, ? )";
		try (Connection connection = getConnection();
				PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, su.getName());
			statement.setString(2, su.getEmail());
			statement.setString(3, su.getPassword());
			statement.setString(4, su.getUserType());
			statement.setString(5, su.getLocation());
			statement.setLong(6, su.getPhoneNumber());

			statement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

