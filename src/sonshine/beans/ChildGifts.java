package sonshine.beans;

public class ChildGifts {
	private int gifts_pk;
	private int child_fk;
	private String gift;
	private String details;
	private String date;
	private int last_modified_by_fk;

	public int getGifts_pk() {
		return gifts_pk;
	}

	public void setGifts_pk(int gifts_pk) {
		this.gifts_pk = gifts_pk;
	}

	public int getChild_fk() {
		return child_fk;
	}

	public void setChild_fk(int child_fk) {
		this.child_fk = child_fk;
	}

	public String getGift() {
		return gift;
	}

	public void setGift(String gift) {
		this.gift = gift;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getLast_modified_by_fk() {
		return last_modified_by_fk;
	}

	public void setLast_modified_by_fk(int last_modified_by_fk) {
		this.last_modified_by_fk = last_modified_by_fk;
	}

}
