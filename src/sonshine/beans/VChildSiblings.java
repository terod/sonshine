package sonshine.beans;

public class VChildSiblings {
	private String name;
	private String current_program;
	private String details;
	private String ref_child_key;
	private String dob;
	private int child_key;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getCurrent_program_fk() {
		return current_program;
	}
	public void setCurrent_program_fk(String current_program_fk) {
		this.current_program = current_program_fk;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	public String getRef_child_key() {
		return ref_child_key;
	}
	public void setRef_child_key(String ref_child_key) {
		this.ref_child_key = ref_child_key;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public int getChild_key() {
		return child_key;
	}
	public void setChild_key(int child_key) {
		this.child_key = child_key;
	}

	
}
