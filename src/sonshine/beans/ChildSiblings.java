package sonshine.beans;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class ChildSiblings {
	private int siblingks_pk;
	private int child_fk;
	private String name;
	private String dob;
	private int current_program_fk;
	private String details;
	private int fiscal_year_fk;
	private int last_modified_by_fk;
	private String ref_child_id;
	private int ref_child_key;

	public int getSiblingks_pk() {
		return siblingks_pk;
	}

	public void setSiblingks_pk(int siblingks_pk) {
		this.siblingks_pk = siblingks_pk;
	}

	public int getChild_fk() {
		return child_fk;
	}

	public void setChild_fk(int child_fk) {
		this.child_fk = child_fk;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCurrent_program_fk() {
		return current_program_fk;
	}

	public void setCurrent_program_fk(int current_program_fk) {
		this.current_program_fk = current_program_fk;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public int getFiscal_year_fk() {
		return fiscal_year_fk;
	}

	public void setFiscal_year_fk(int fiscal_year_fk) {
		this.fiscal_year_fk = fiscal_year_fk;
	}

	public int getLast_modified_by_fk() {
		return last_modified_by_fk;
	}

	public void setLast_modified_by_fk(int last_modified_by_fk) {
		this.last_modified_by_fk = last_modified_by_fk;
	}

	public String getRef_child_id() {
		return ref_child_id;
	}

	public void setRef_child_id(String ref_child_id) {
		this.ref_child_id = ref_child_id;
	}

	public int getRef_child_key() {
		return ref_child_key;
	}

	public void setRef_child_key(int ref_child_key) {
		this.ref_child_key = ref_child_key;
	}

	public String getDob() {
		return dob;
	}

	public void setDob(String dob) {
		this.dob = dob;
	}

}
