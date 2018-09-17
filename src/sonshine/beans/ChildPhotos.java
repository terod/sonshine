package sonshine.beans;

public class ChildPhotos {
	private int photos_pk;
	private int child_fk;
	private int active;
	private String last_modified_on;
	private String photo_path;
	private String meta;
	private int fiscal_year_fk;
	private int last_modified_by_fk;

	public int getPhotos_pk() {
		return photos_pk;
	}

	public void setPhotos_pk(int photos_pk) {
		this.photos_pk = photos_pk;
	}

	public int getChild_fk() {
		return child_fk;
	}

	public void setChild_fk(int child_fk) {
		this.child_fk = child_fk;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public String getPhoto_path() {
		return photo_path;
	}

	public void setPhoto_path(String photo_path) {
		this.photo_path = photo_path;
	}

	public String getMeta() {
		return meta;
	}

	public void setMeta(String meta) {
		this.meta = meta;
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

	public String getLast_modified_on() {
		return last_modified_on;
	}

	public void setLast_modified_on(String last_modified_on) {
		this.last_modified_on = last_modified_on;
	}

}
