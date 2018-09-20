package sonshine.beans;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class VChildAcademics {
	private int academic_pk;
	private int child_fk;
	private String fiscal_year;
	private String active;
	private String year;
	private String classno;
	private String final_grade;
	private String comments;

	public int getAcademic_pk() {
		return academic_pk;
	}

	public void setAcademic_pk(int academic_pk) {
		this.academic_pk = academic_pk;
	}

	public String getFiscal_year() {
		return fiscal_year;
	}

	public void setFiscal_year(String fiscal_year) {
		this.fiscal_year = fiscal_year;
	}

	public String getActive() {
		return active;
	}

	public void setActive(String active) {
		this.active = active;
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

}
