package sonshine.beans;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class VChildDocuments {
	private String last_modified_on;
	private String name;
	private String path;
	private String type;
	private String active;
	
	
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	public String getLast_modified_on() {
		return last_modified_on;
	}
	public void setLast_modified_on(String last_modified_on) {
		this.last_modified_on = last_modified_on;
	}
}
