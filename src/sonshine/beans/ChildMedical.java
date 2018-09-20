package sonshine.beans;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class ChildMedical {
	private int medical_pk;
	private int child_fk;
	private String checkup_date;
	private String treatment;
	private String details;
	private int fiscal_year_fk;
	private int last_modified_by_fk;

	public int getFiscal_year_fk() {
		return fiscal_year_fk;
	}

	public void setFiscal_year_fk(int fiscal_year_fk) {
		this.fiscal_year_fk = fiscal_year_fk;
	}

	public int getMedical_pk() {
		return medical_pk;
	}

	public void setMedical_pk(int medical_pk) {
		this.medical_pk = medical_pk;
	}

	public int getChild_fk() {
		return child_fk;
	}

	public void setChild_fk(int child_fk) {
		this.child_fk = child_fk;
	}

	public String getCheckup_date() {
		return checkup_date;
	}

	public void setCheckup_date(String checkup_date) {
		this.checkup_date = checkup_date;
	}

	public String getTreatment() {
		return treatment;
	}

	public void setTreatment(String treatment) {
		this.treatment = treatment;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public int getLast_modified_by_fk() {
		return last_modified_by_fk;
	}

	public void setLast_modified_by_fk(int last_modified_by_fk) {
		this.last_modified_by_fk = last_modified_by_fk;
	}

}
