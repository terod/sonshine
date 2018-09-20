package sonshine.beans;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class VFinanceSponsorAmount {
	private int sponsor_amount_pk;
	private String sponsor_person;
	private float sponsor_amount;
	private String fiscal_year;
	private String month;
	private String child_fk;
	private String date;
	
	public int getSponsor_amount_pk() {
		return sponsor_amount_pk;
	}
	public void setSponsor_amount_pk(int sponsor_amount_pk) {
		this.sponsor_amount_pk = sponsor_amount_pk;
	}
	public String getSponsor_person() {
		return sponsor_person;
	}
	public void setSponsor_person(String sponsor_person) {
		this.sponsor_person = sponsor_person;
	}
	public float getSponsor_amount() {
		return sponsor_amount;
	}
	public void setSponsor_amount(float sponsor_amount) {
		this.sponsor_amount = sponsor_amount;
	}
	public String getFiscal_year() {
		return fiscal_year;
	}
	public void setFiscal_year(String fiscal_year) {
		this.fiscal_year = fiscal_year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getChild_fk() {
		return child_fk;
	}
	public void setChild_fk(String child_fk) {
		this.child_fk = child_fk;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

}
