package sonshine.beans;

public class ChildComments {
	private int comment_pk; 
	private int child_fk; 
	private String comment; 
	private int active_fk; 
	private int fiscal_year_fk;
	private int last_modified_by_fk;
	
	public int getComment_pk() {
		return comment_pk;
	}
	public void setComment_pk(int comment_pk) {
		this.comment_pk = comment_pk;
	}
	public int getChild_fk() {
		return child_fk;
	}
	public void setChild_fk(int child_fk) {
		this.child_fk = child_fk;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getActive_fk() {
		return active_fk;
	}
	public void setActive_fk(int active_fk) {
		this.active_fk = active_fk;
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
	
}
