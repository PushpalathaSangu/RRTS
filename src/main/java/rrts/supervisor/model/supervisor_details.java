package rrts.supervisor.model;

public class supervisor_details {
	private static int id;
	private static String name;
	private static String email;
	private static String location;
	private static long phoneNumber;
	private static String password;
	public static String usertype="Supervisor";
	public String getName() {
		return name;
	}
	public void setId(int id) {
		supervisor_details.id=id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		supervisor_details.password=password;
	}
	public  int getId() {
		return id;
	}
	public  void setName(String name) {
		supervisor_details.name = name;
	}
	public String getEmail() {
		return email;
	}
	public  void setEmail(String email) {
		supervisor_details.email = email;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		supervisor_details.location = location;
	}
	public  long getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(long phoneNumber) {
		supervisor_details.phoneNumber = phoneNumber;
	}


}
