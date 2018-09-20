package sonshine.beans;

import java.util.HashMap;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class VSearchOutcomeChild {
	private int child_key;
	private String child_id;
	private String name;
	private String dob;
	private int age;
    private String program;
	private HashMap<Integer, String[]> fiscal_years_map;
	
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

	public HashMap<Integer, String[]> getFiscal_years_map() {
		return fiscal_years_map;
	}

	public void setFiscal_years_map(HashMap<Integer, String[]> fiscal_years_map) {
		this.fiscal_years_map = fiscal_years_map;
	}

	
}
