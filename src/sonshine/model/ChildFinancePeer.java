package sonshine.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

import sonshine.beans.Address;
import sonshine.beans.Child;
import sonshine.beans.ChildAcademics;
import sonshine.beans.ChildComments;
import sonshine.beans.ChildIdentifyMarks;
import sonshine.beans.ChildMedical;
import sonshine.beans.ChildParents;
import sonshine.beans.ChildProgram;
import sonshine.beans.ChildSiblings;
import sonshine.beans.ChildSponsorDetails;
import sonshine.beans.FinanceExpenseAmount;
import sonshine.beans.FinanceSponsorAmount;

public class ChildFinancePeer {
	public static boolean insertChildSponsorDetails(Connection conn,
			ChildSponsorDetails childSponsorDetails) throws SQLException {
		String sql;
		boolean successFullInsert = false;
		// date formatiing
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		String entryDateInString = childSponsorDetails.getEntry_date();
		String exitDateInString = childSponsorDetails.getExit_date();
		java.sql.Date entryDate = null;
		java.sql.Date exitDate = null;
		try {

			java.util.Date tempDate1 = formatter.parse(entryDateInString);
			java.util.Date tempDate2 = formatter.parse(exitDateInString);
			entryDate = new java.sql.Date(tempDate1.getTime());
			exitDate = new java.sql.Date(tempDate2.getTime());

		} catch (ParseException e) {
			e.printStackTrace();
		}

		sql = "INSERT INTO child_sponsor_details (active_fk,name,country_fk,entry_date,exit_date,fiscal_year_fk,child_fk) "
				+ "VALUES (?,?,?,?,?,?,?)";

		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, 1);
			stmt.setString(2, childSponsorDetails.getName());
			stmt.setInt(3, childSponsorDetails.getCountry_fk());
			stmt.setDate(4, entryDate);
			stmt.setDate(5, exitDate);
			stmt.setInt(6, childSponsorDetails.getFiscal_year_fk());
			stmt.setInt(7, childSponsorDetails.getChild_fk());

			if (stmt.executeUpdate() != 0)
				successFullInsert = true;
		} catch (SQLException e) {
			System.out.println("Could not insert childFinanceDetails: "
					+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
		return successFullInsert;
	}

	public static boolean insertFinanceSponsorAmount(Connection conn,
			FinanceSponsorAmount financeSponsorAmount) throws SQLException {
		String sql;
		boolean successFullInsert = false;
		// date formating
		java.sql.Date todayDateSQL = null;
		java.util.Date todayDate = new java.util.Date();
		todayDateSQL = new java.sql.Date(todayDate.getTime());

		sql = "INSERT INTO `finance_sponsor_amount` (sponsor_person_fk,sponsor_amount,fiscal_year_fk,month_fk,child_fk,date) "
				+ "VALUES (?,?,?,?,?,?)";

		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, financeSponsorAmount.getSponsor_person_fk());
			stmt.setFloat(2, financeSponsorAmount.getSponsor_amount());
			stmt.setInt(3, financeSponsorAmount.getFiscal_year_fk());
			stmt.setInt(4, financeSponsorAmount.getMonth_fk());
			stmt.setInt(5, financeSponsorAmount.getChild_fk());
			stmt.setDate(6, todayDateSQL);

			if (stmt.executeUpdate() != 0)
				successFullInsert = true;
		} catch (SQLException e) {
			System.out.println("Could not insert childFinanceSponsorAmount: "
					+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
		return successFullInsert;
	}

	public static boolean insertFinanceExpenseAmount(Connection conn,
			FinanceExpenseAmount financeExpenseAmount) throws SQLException {
		String sql;
		boolean successFullInsert = false;
		// date formating
		java.sql.Date todayDateSQL = null;
		java.util.Date todayDate = new java.util.Date();
		todayDateSQL = new java.sql.Date(todayDate.getTime());

		sql = "INSERT INTO `finance_expense_amount` (expense_type,expense_amount,date,child_fk,fiscal_year_fk,month_fk) "
				+ "VALUES (?,?,?,?,?,?)";

		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, financeExpenseAmount.getExpense_name());
			stmt.setFloat(2, financeExpenseAmount.getAmount());
			stmt.setDate(3, todayDateSQL);
			stmt.setInt(4, financeExpenseAmount.getChild_fk());
			stmt.setInt(5, financeExpenseAmount.getFiscal_year_fk());
			stmt.setInt(6, financeExpenseAmount.getMonth_fk());

			if (stmt.executeUpdate() != 0)
				successFullInsert = true;
		} catch (SQLException e) {
			System.out.println("Could not insert childFinanceInsertAmount: "
					+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
		return successFullInsert;
	}
}
