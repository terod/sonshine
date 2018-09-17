package sonshine.beans;

public class VFinanceExpenseAmount {
	private int expense_amount_pk;
	private String expense_type;
	private float amount;
	private String date;
	private int child_fk;
	private String fiscal_year;
	private String month;

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

	public String getFiscal_year() {
		return fiscal_year;
	}

	public void setFiscal_year(String fiscal_year) {
		this.fiscal_year = fiscal_year;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

}
