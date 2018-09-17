package sonshine.beans;

public class ChildIdentifyMarks {
	private int identify_marks_pk; 
	private int child_fk;
	private String mark;
	private int last_modified_by_fk;
	
	public int getIdentify_marks_pk() {
		return identify_marks_pk;
	}
	public void setIdentify_marks_pk(int identify_marks_pk) {
		this.identify_marks_pk = identify_marks_pk;
	}
	public int getChild_fk() {
		return child_fk;
	}
	public void setChild_fk(int child_fk) {
		this.child_fk = child_fk;
	}
	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}
	public int getLast_modified_by_fk() {
		return last_modified_by_fk;
	}
	public void setLast_modified_by_fk(int last_modified_by_fk) {
		this.last_modified_by_fk = last_modified_by_fk;
	}
	
	
}
