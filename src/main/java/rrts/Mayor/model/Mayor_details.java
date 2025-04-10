package rrts.Mayor.model;

public class Mayor_details {
	private static int id;
	private static String name;
	private static String email;
	private static String location;
	private static Long phoneNumber;
	public  int getId() {
		return id;
	}
	public  void setId(int id) {
		Mayor_details.id = id;
	}
	public  String getName() {
		return name;
	}
	public  void setName(String name) {
		Mayor_details.name = name;
	}
	public  String getEmail() {
		return email;
	}
	public  void setEmail(String email) {
		Mayor_details.email = email;
	}
	public  String getLocation() {
		return location;
	}
	public  void setLocation(String location) {
		Mayor_details.location = location;
	}
	public  Long getPhoneNumber() {
		return phoneNumber;
	}
	public  void setPhoneNumber(Long phoneNumber) {
		Mayor_details.phoneNumber = phoneNumber;
	}
}
