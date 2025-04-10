package rrts.workManager.model;

public class workManager_details {
	private static int id;
	private static String name;
	private static String email;
	private static String location;
	private static Long phoneNumber;
	public  int getId() {
		return id;
	}
	public  void setId(int id) {
		workManager_details.id = id;
	}
	public  String getName() {
		return name;
	}
	public  void setName(String name) {
		workManager_details.name = name;
	}
	public  String getEmail() {
		return email;
	}
	public  void setEmail(String email) {
		workManager_details.email = email;
	}
	public  String getLocation() {
		return location;
	}
	public  void setLocation(String location) {
		workManager_details.location = location;
	}
	public  Long getPhoneNumber() {
		return phoneNumber;
	}
	public  void setPhoneNumber(Long phoneNumber) {
		workManager_details.phoneNumber = phoneNumber;
	}
}
