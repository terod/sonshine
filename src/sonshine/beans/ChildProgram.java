package sonshine.beans;

public class ChildProgram {
	private int program_pk;
	private int active;
	private int child_fk;
	private int type_fk;
	private int location_fk;
	private int pc_fk;
	private int tl_fk;
	private int status_fk;
	private int fiscal_year_fk;
	private int last_modified_by_fk;

	public int getProgram_pk() {
		return program_pk;
	}

	public void setProgram_pk(int program_pk) {
		this.program_pk = program_pk;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public int getChild_fk() {
		return child_fk;
	}

	public void setChild_fk(int child_fk) {
		this.child_fk = child_fk;
	}

	public int getType_fk() {
		return type_fk;
	}

	public void setType_fk(int type_fk) {
		this.type_fk = type_fk;
	}

	public int getLocation_fk() {
		return location_fk;
	}

	public void setLocation_fk(int location_fk) {
		this.location_fk = location_fk;
	}

	public int getPc_fk() {
		return pc_fk;
	}

	public void setPc_fk(int pc_fk) {
		this.pc_fk = pc_fk;
	}

	public int getTl_fk() {
		return tl_fk;
	}

	public void setTl_fk(int tl_fk) {
		this.tl_fk = tl_fk;
	}

	public int getStatus_fk() {
		return status_fk;
	}

	public void setStatus_fk(int status_fk) {
		this.status_fk = status_fk;
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

}
