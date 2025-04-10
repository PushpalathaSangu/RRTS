package rrts.signup.model;

public class Details {
	private String name;
	private String email;
	private String password;
	private String userType;
	private String location;
	private long phoneNumber;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public void setLocationType(String location) {
		this.location = location;
	}
	public String getLocation() {
		return location;
	}
	public void setPhoneNumber(long phoneNumber) {
		this.phoneNumber=phoneNumber;
	}
	public long getPhoneNumber() {
		return phoneNumber;
	}

}
