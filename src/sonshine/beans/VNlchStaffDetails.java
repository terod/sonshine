package sonshine.beans;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class VNlchStaffDetails {
	private int staff_pk;
	private String name;
	private String user_name;
	
	public int getStaff_pk() {
		return staff_pk;
	}
	public void setStaff_pk(int staff_pk) {
		this.staff_pk = staff_pk;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
}
