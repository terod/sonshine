package sonshine.beans;

public class ChildSponsorDetails {
	private int sponsor_details_pk;
	private int active_fk;
	private String name;
	private int country_fk; 
	private String entry_date; 
	private String exit_date;
	private int fiscal_year_fk;
	private int child_fk;
	private int last_modified_by_fk;
	
	public int getSponsor_details_pk() {
		return sponsor_details_pk;
	}
	public void setSponsor_details_pk(int sponsor_details_pk) {
		this.sponsor_details_pk = sponsor_details_pk;
	}
	public int getActive_fk() {
		return active_fk;
	}
	public void setActive_fk(int active_fk) {
		this.active_fk = active_fk;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCountry_fk() {
		return country_fk;
	}
	public void setCountry_fk(int country_fk) {
		this.country_fk = country_fk;
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
	public int getFiscal_year_fk() {
		return fiscal_year_fk;
	}
	public void setFiscal_year_fk(int fiscal_year_fk) {
		this.fiscal_year_fk = fiscal_year_fk;
	}
	public int getChild_fk() {
		return child_fk;
	}
	public void setChild_fk(int child_fk) {
		this.child_fk = child_fk;
	}
	public int getLast_modified_by_fk() {
		return last_modified_by_fk;
	}
	public void setLast_modified_by_fk(int last_modified_by_fk) {
		this.last_modified_by_fk = last_modified_by_fk;
	}

}
