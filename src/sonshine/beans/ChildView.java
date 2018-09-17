package sonshine.beans;

public class ChildView {
	private int child_key;
	private String child_id;
	private String name;
	private String dob;
	private String application_date;
	private String enrollment_date;
	private String place_of_birth;
	private String gender;
	private String mother_tongue;
	private String religion;
	private String physical_defects;
	private String reason;
	private String created_date;
	private Address address;
	private int age;

	public String getChild_id() {
		return child_id;
	}

	public void setChild_id(String child_id) {
		this.child_id = child_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

	public String getPlace_of_birth() {
		return place_of_birth;
	}

	public void setPlace_of_birth(String place_of_birth) {
		this.place_of_birth = place_of_birth;
	}

	public String getPhysical_defects() {
		return physical_defects;
	}

	public void setPhysical_defects(String physical_defects) {
		this.physical_defects = physical_defects;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public int getChild_key() {
		return child_key;
	}

	public void setChild_key(int child_key) {
		this.child_key = child_key;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getMother_tongue() {
		return mother_tongue;
	}

	public void setMother_tongue(String mother_tongue) {
		this.mother_tongue = mother_tongue;
	}

	public String getReligion() {
		return religion;
	}

	public void setReligion(String religion) {
		this.religion = religion;
	}

	public String getCreated_date() {
		return created_date;
	}

	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getApplication_date() {
		return application_date;
	}

	public void setApplication_date(String application_date) {
		this.application_date = application_date;
	}

	public String getEnrollment_date() {
		return enrollment_date;
	}

	public void setEnrollment_date(String enrollment_date) {
		this.enrollment_date = enrollment_date;
	}
}
