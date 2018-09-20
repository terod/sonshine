package sonshine.beans;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class Address {
	private String street;
	private String area;
	private String taluk;
	private String city_town;
	private String state;
	private String country;
	private String zip;
	private int last_modified_by_fk;

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getTaluk() {
		return taluk;
	}

	public void setTaluk(String taluk) {
		this.taluk = taluk;
	}

	public String getCity_town() {
		return city_town;
	}

	public void setCity_town(String city_town) {
		this.city_town = city_town;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public int getLast_modified_by_fk() {
		return last_modified_by_fk;
	}

	public void setLast_modified_by_fk(int last_modified_by_fk) {
		this.last_modified_by_fk = last_modified_by_fk;
	}
}
