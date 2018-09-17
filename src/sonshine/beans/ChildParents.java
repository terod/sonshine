package sonshine.beans;

public class ChildParents {
	private int parent_pk;
	private int child_fk;
	private String name;
	private int status_fk;
	private String occupation;
	private String type;
	private int fiscal_year_fk;
	private int last_modified_by_fk;
	private int active;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getParent_pk() {
		return parent_pk;
	}

	public void setParent_pk(int parent_pk) {
		this.parent_pk = parent_pk;
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

	public int getStatus_fk() {
		return status_fk;
	}

	public void setStatus_fk(int status_fk) {
		this.status_fk = status_fk;
	}

	public String getOccupation() {
		return occupation;
	}

	public void setOccupation(String occupation) {
		this.occupation = occupation;
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

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

}
