package sonshine.beans;

public class FinanceSponsorAmount {
	private int sponsor_amount_pk;
	private int sponsor_person_fk;
	private float sponsor_amount;
	private int fiscal_year_fk;
	private int month_fk;
	private int child_fk;
	private String date;
	private int last_modified_by_fk;

	public int getSponsor_amount_pk() {
		return sponsor_amount_pk;
	}

	public void setSponsor_amount_pk(int sponsor_amount_pk) {
		this.sponsor_amount_pk = sponsor_amount_pk;
	}

	public int getSponsor_person_fk() {
		return sponsor_person_fk;
	}

	public void setSponsor_person_fk(int sponsor_person_fk) {
		this.sponsor_person_fk = sponsor_person_fk;
	}

	public int getFiscal_year_fk() {
		return fiscal_year_fk;
	}

	public void setFiscal_year_fk(int fiscal_year_fk) {
		this.fiscal_year_fk = fiscal_year_fk;
	}

	public float getSponsor_amount() {
		return sponsor_amount;
	}

	public void setSponsor_amount(float sponsor_amount) {
		this.sponsor_amount = sponsor_amount;
	}

	public int getMonth_fk() {
		return month_fk;
	}

	public void setMonth_fk(int month_fk) {
		this.month_fk = month_fk;
	}

	public int getChild_fk() {
		return child_fk;
	}

	public void setChild_fk(int child_fk) {
		this.child_fk = child_fk;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getLast_modified_by_fk() {
		return last_modified_by_fk;
	}

	public void setLast_modified_by_fk(int last_modified_by_fk) {
		this.last_modified_by_fk = last_modified_by_fk;
	}

}
