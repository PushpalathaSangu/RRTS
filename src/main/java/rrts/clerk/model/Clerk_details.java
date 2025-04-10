package rrts.clerk.model;

public class Clerk_details {
	private static int id;
	private static String name;
	private static String email;
	private static long phoneNo;
	private String password;
	private static String location;
	public void setId(int id) {
		this.id=id;
	}
	public int getId() {
		return id;
	}
	public void setLocation(String location) {
		this.location=location;
	}
	public String getLocation() {
		return location;
	}
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
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

	public long getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(long phoneNo) {
		this.phoneNo = phoneNo;
	}
}
