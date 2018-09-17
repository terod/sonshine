package sonshine.beans;

public class ChildAcademics {
	private int academic_pk;
	private int child_fk;
	private int fiscal_year_fk;
	private int active_fk;
	private String year;
	private String classno;
	private String final_grade;
	private String comments;
	private int last_modified_by_fk;

	public int getAcademic_pk() {
		return academic_pk;
	}

	public void setAcademic_pk(int academic_pk) {
		this.academic_pk = academic_pk;
	}

	public int getFiscal_year_fk() {
		return fiscal_year_fk;
	}

	public void setFiscal_year_fk(int fiscal_year_fk) {
		this.fiscal_year_fk = fiscal_year_fk;
	}

	public int getActive_fk() {
		return active_fk;
	}

	public void setActive_fk(int active_fk) {
		this.active_fk = active_fk;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getClassno() {
		return classno;
	}

	public void setClassno(String classno) {
		this.classno = classno;
	}

	public String getFinal_grade() {
		return final_grade;
	}

	public void setFinal_grade(String final_grade) {
		this.final_grade = final_grade;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
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
