package sonshine.beans;

public class VChildSponsorDetails {
	private int sponsor_details_pk;
	private String active_fk;
	private String name;
	private String country; 
	private String entry_date; 
	private String exit_date;
	private String fiscal_year;
	private int child_fk;
	
	public int getSponsor_details_pk() {
		return sponsor_details_pk;
	}
	public void setSponsor_details_pk(int sponsor_details_pk) {
		this.sponsor_details_pk = sponsor_details_pk;
	}
	public String getActive_fk() {
		return active_fk;
	}
	public void setActive_fk(String active_fk) {
		this.active_fk = active_fk;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getEntry_date() {
		return entry_date;
	}
	public void setEntry_date(String entry_date) {
		this.entry_date = entry_date;
	}
	public String getExit_date() {
		return exit_date;
	}
	public void setExit_date(String exit_date) {
		this.exit_date = exit_date;
	}
	public String getFiscal_year() {
		return fiscal_year;
	}
	public void setFiscal_year(String fiscal_year) {
		this.fiscal_year = fiscal_year;
	}
	public int getChild_fk() {
		return child_fk;
	}
	public void setChild_fk(int child_fk) {
		this.child_fk = child_fk;
	}
}
