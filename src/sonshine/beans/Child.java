package sonshine.beans;
/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class Child {
	private int child_key;
	private String child_id;
	private String name;
	private String dob;
	private String application_date;
	private String enrollment_date;
	private int age;
	private String place_of_birth;
	private int gender;
	private int mother_tongue_fk;
	private int religion_fk;
	private int address_fk;
	private String physical_defects;
	private String reason;
	private String program;
	private Address address;
	private int last_modified_by_fk;

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

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getPlace_of_birth() {
		return place_of_birth;
	}

	public void setPlace_of_birth(String place_of_birth) {
		this.place_of_birth = place_of_birth;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public int getMother_tongue_fk() {
		return mother_tongue_fk;
	}

	public void setMother_tongue_fk(int mother_tongue_fk) {
		this.mother_tongue_fk = mother_tongue_fk;
	}

	public int getReligion_fk() {
		return religion_fk;
	}

	public void setReligion_fk(int religion_fk) {
		this.religion_fk = religion_fk;
	}

	public int getAddress_fk() {
		return address_fk;
	}

	public void setAddress_fk(int address_fk) {
		this.address_fk = address_fk;
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

	public String getProgram() {
		return program;
	}

	public void setProgram(String program) {
		this.program = program;
	}

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public int getLast_modified_by_fk() {
		return last_modified_by_fk;
	}

	public void setLast_modified_by_fk(int last_modified_by_fk) {
		this.last_modified_by_fk = last_modified_by_fk;
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
