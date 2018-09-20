package sonshine.beans;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class ChildDocuments {
	private int documents_id;
	private int child_fk;
	private String last_modified_on;
	private String name;
	private String path;
	private int type_fk;
	private int active_fk;
	private int fiscal_year_fk;
	private int last_modified_by_fk;
	
	public int getFiscal_year_fk() {
		return fiscal_year_fk;
	}

	public void setFiscal_year_fk(int fiscal_year_fk) {
		this.fiscal_year_fk = fiscal_year_fk;
	}

	public int getDocuments_id() {
		return documents_id;
	}

	public void setDocuments_id(int documents_id) {
		this.documents_id = documents_id;
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

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public int getType_fk() {
		return type_fk;
	}

	public void setType_fk(int type_fk) {
		this.type_fk = type_fk;
	}

	public int getActive_fk() {
		return active_fk;
	}

	public void setActive_fk(int active_fk) {
		this.active_fk = active_fk;
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
