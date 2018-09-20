package sonshine.beans;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class VChildParents {
	private int parent_pk;
	private String name;
	private String status;
	private String occupation;
	private String type;
	private int status_fk;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOccupation() {
		return occupation;
	}
	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}
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
	public int getStatus_fk() {
		return status_fk;
	}
	public void setStatus_fk(int status_fk) {
		this.status_fk = status_fk;
	}
}
