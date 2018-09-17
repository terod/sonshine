package sonshine.beans;

public class FinanceExpenseAmount {
	private int expense_amount_pk;
	private String expense_type;
	private float amount;
	private String date;
	private int child_fk;
	private int fiscal_year_fk;
	private int month_fk;
	private int last_modified_by_fk;

	public int getExpense_amount_pk() {
		return expense_amount_pk;
	}

	public void setExpense_amount_pk(int expense_amount_pk) {
		this.expense_amount_pk = expense_amount_pk;
	}

	public String getExpense_name() {
		return expense_type;
	}

	public void setExpense_name(String expense_name) {
		this.expense_type = expense_name;
	}

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getChild_fk() {
		return child_fk;
	}

	public void setChild_fk(int child_fk) {
		this.child_fk = child_fk;
	}

	public int getFiscal_year_fk() {
		return fiscal_year_fk;
	}

	public void setFiscal_year_fk(int fiscal_year_fk) {
		this.fiscal_year_fk = fiscal_year_fk;
	}

	public int getMonth_fk() {
		return month_fk;
	}

	public void setMonth_fk(int month_fk) {
		this.month_fk = month_fk;
	}

	public int getLast_modified_by_fk() {
		return last_modified_by_fk;
	}

	public void setLast_modified_by_fk(int last_modified_by_fk) {
		this.last_modified_by_fk = last_modified_by_fk;
	}

}
