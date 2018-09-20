package sonshine.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

import org.apache.log4j.Logger;

import sonshine.beans.Address;
import sonshine.beans.Child;
import sonshine.beans.ChildAcademics;
import sonshine.beans.ChildComments;
import sonshine.beans.ChildIdentifyMarks;
import sonshine.beans.ChildMedical;
import sonshine.beans.ChildParents;
import sonshine.beans.ChildProgram;
import sonshine.beans.ChildSiblings;
import sonshine.utils.DateUtility;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class ChildNewPeer {

	static final Logger LOGGER = Logger.getLogger(ChildNewPeer.class);

	public static int insertChildAddressOnly(Connection conn,
			Address childAddress) throws Exception {
		String sql;
		ResultSet rs = null;
		int key = 0;
		sql = "insert into child_address (street, area, city_town, state, country, zip, last_modified_by) values(?,?,?,?,?,?,?)";
		PreparedStatement stmt = null;
		try {

			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, childAddress.getStreet());
			stmt.setString(2, childAddress.getArea());
			stmt.setString(3, childAddress.getCity_town());
			stmt.setString(4, childAddress.getState());
			stmt.setString(5, childAddress.getCountry());
			stmt.setString(6, childAddress.getZip());
			stmt.setInt(7, childAddress.getLast_modified_by_fk());
			stmt.executeUpdate();
			try {
				rs = stmt.getGeneratedKeys();
				while (rs.next()) {
					System.out.println("Key returned from getGeneratedKeys():"
							+ rs.getInt(1));
					key = rs.getInt(1);
				}
				rs.close();
			} finally {

				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException ex) {
					}
				}
			}
		} catch (SQLException e) {
			throw new Exception("Could not insert childAddress: "
					+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
		return key;
	}

	public static int insertChild(Connection conn, Child child)
			throws Exception {
		String sql;
		ResultSet rs = null;
		int key = 0;

		java.sql.Date dobDate = DateUtility.convertStringToSQLDate(child
				.getDob());

		// create a new object called date to record the current date
		java.util.Date createDate = new java.util.Date();
		java.sql.Date createSqlDate = new java.sql.Date(createDate.getTime());

		sql = "insert into child (child_id, name, dob, age, place_of_birth, "
				+ "gender_fk, mother_tongue_fk, religion_fk, address_fk, physical_defects, reason, created_date, last_modified_by, application_date, enrollment_date) "
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, child.getChild_id());
			stmt.setString(2, child.getName());
			stmt.setDate(3, dobDate);
			stmt.setInt(4, child.getAge());
			stmt.setString(5, child.getPlace_of_birth());
			stmt.setInt(6, child.getGender());
			stmt.setInt(7, child.getMother_tongue_fk());
			stmt.setInt(8, child.getReligion_fk());
			stmt.setInt(9, child.getAddress_fk());
			stmt.setString(10, child.getPhysical_defects());
			stmt.setString(11, child.getReason());
			stmt.setDate(12, createSqlDate);
			stmt.setInt(13, child.getLast_modified_by_fk());
			stmt.setDate(14, DateUtility.convertStringToSQLDate(child
					.getApplication_date()));
			stmt.setDate(15, DateUtility.convertStringToSQLDate(child
					.getEnrollment_date()));
			stmt.execute();
			try {
				rs = stmt.getGeneratedKeys();
				while (rs.next()) {
					System.out.println("Key returned from getGeneratedKeys():"
							+ rs.getInt(1));
					key = rs.getInt(1);
				}
				rs.close();
			} finally {

				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException ex) {
					}
				}
			}
		} catch (SQLException e) {
			LOGGER.error("Could not insert child: " + e.getMessage());
			throw new Exception("Could not insert child: " + e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
		return key;
	}

	public static int insertChildProgram(Connection conn,
			ChildProgram childProgram) throws Exception {
		String sql;

		// create a new object called date to record the current date
		java.util.Date createDate = new java.util.Date();
		java.sql.Date createSqlDate = new java.sql.Date(createDate.getTime());

		sql = "insert into child_program (child_fk, type_fk, location_fk, pc_fk, "
				+ "status_fk, fiscal_year_fk, last_modified_by, active, last_modified_on) values(?,?,?,?,?,?,?,?,?)";

		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, childProgram.getChild_fk());
			stmt.setInt(2, childProgram.getType_fk());
			stmt.setInt(3, childProgram.getLocation_fk());
			stmt.setInt(4, childProgram.getPc_fk());
			stmt.setInt(5, childProgram.getStatus_fk());
			stmt.setInt(6, childProgram.getFiscal_year_fk());
			stmt.setInt(7, childProgram.getLast_modified_by_fk());
			stmt.setInt(8, 1);
			stmt.setDate(9, createSqlDate);
			return stmt.executeUpdate();
		} catch (SQLException e) {
			throw new Exception("Could not insert childProgram: "
					+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	public static void insertChildIdentifyMarks(Connection conn,
			ArrayList<ChildIdentifyMarks> childIdentifyMarks) throws Exception {
		String sql;
		PreparedStatement stmt = null;
		try {
			for (ChildIdentifyMarks childIdentifyMarks1 : childIdentifyMarks) {
				sql = "insert into child_identify_marks (child_fk, mark, last_modified_by) "
						+ "values(?,?,?)";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, childIdentifyMarks1.getChild_fk());
				stmt.setString(2, childIdentifyMarks1.getMark());
				stmt.setInt(3, childIdentifyMarks1.getLast_modified_by_fk());
				stmt.execute();
			}
		} catch (SQLException e) {
			throw new Exception("Could not insert childIdentifyMarks: "
					+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}

	}

	public static void insertChildAcademics(Connection conn,
			ChildAcademics childAcademics) throws Exception {
		String sql;
		sql = "insert into child_academics (fiscal_year_fk, child_fk, active_fk, year, class, final_grade, comments, last_modified_by) "
				+ "values(?,?,?,?,?,?,?,?)";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, childAcademics.getFiscal_year_fk());
			stmt.setInt(2, childAcademics.getChild_fk());
			stmt.setInt(3, childAcademics.getActive_fk());
			stmt.setString(4, childAcademics.getYear());
			stmt.setString(5, childAcademics.getClassno());
			stmt.setString(6, childAcademics.getFinal_grade());
			stmt.setString(7, childAcademics.getComments());
			stmt.setInt(8, childAcademics.getLast_modified_by_fk());
			stmt.execute();
		} catch (SQLException e) {
			throw new Exception("Could not insert childAcademics: "
					+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	public static void insertChildComments(Connection conn,
			ChildComments childComments) throws Exception {
		String sql;

		sql = "insert into child_comments (child_fk, comment, active_fk, fiscal_year_fk, last_modified_by) "
				+ "values(?,?,?,?,?)";
		PreparedStatement stmt = null;
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, childComments.getChild_fk());
			stmt.setString(2, childComments.getComment());
			stmt.setInt(3, childComments.getActive_fk());
			stmt.setInt(4, childComments.getFiscal_year_fk());
			stmt.setInt(5, childComments.getLast_modified_by_fk());
			stmt.execute();
		} catch (SQLException e) {
			throw new Exception("Could not insert childComments: "
					+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
	}

	public static int insertChildMedical(Connection conn,
			ChildMedical childMedical) throws SQLException {
		String sql;
		int returnValue = 0;
		PreparedStatement stmt = null;
		try {
			// to safe guard against empty string as date
			if (childMedical.getCheckup_date().equals("")) {

				sql = "insert into child_medical (child_fk, treatment, details, last_modified_by, last_modified_on) "
						+ "values(?,?,?,?,?)";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, childMedical.getChild_fk());
				stmt.setString(2, childMedical.getTreatment());
				stmt.setString(3, childMedical.getDetails());
				stmt.setInt(4, childMedical.getLast_modified_by_fk());
				stmt.setDate(5, DateUtility.getCurrentDate());
				returnValue = stmt.executeUpdate();
			}

			else {

				sql = "insert into child_medical (child_fk, checkup_date, treatment, details, fiscal_year_fk, last_modified_by, last_modified_on) "
						+ "values(?,?,?,?,?,?,?)";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, childMedical.getChild_fk());
				stmt.setDate(2, DateUtility.convertStringToSQLDate(childMedical
						.getCheckup_date()));
				stmt.setString(3, childMedical.getTreatment());
				stmt.setString(4, childMedical.getDetails());
				stmt.setInt(5, childMedical.getFiscal_year_fk());
				stmt.setInt(6, childMedical.getLast_modified_by_fk());
				stmt.setDate(7, DateUtility.getCurrentDate());
				returnValue = stmt.executeUpdate();
			}
		} catch (SQLException e) {
			throw new SQLException("Could not insert childMedical: "
					+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
		return returnValue;
	}

	public static int insertChildParents(Connection conn,
			ArrayList<ChildParents> childParentsList) throws SQLException {
		String sql;
		int retValue = 0;
		PreparedStatement stmt = null;
		try {

			for (ChildParents childParents : childParentsList) {
				sql = "insert into child_parents (child_fk, name, status_fk, occupation, type, fiscal_year_fk, last_modified_by, active, last_modified_on) "
						+ "values(?,?,?,?,?,?,?,?,?)";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, childParents.getChild_fk());
				stmt.setString(2, childParents.getName());
				stmt.setInt(3, childParents.getStatus_fk());
				stmt.setString(4, childParents.getOccupation());
				stmt.setString(5, childParents.getType());
				stmt.setInt(6, childParents.getFiscal_year_fk());
				stmt.setInt(7, childParents.getLast_modified_by_fk());
				stmt.setInt(8, childParents.getActive());
				stmt.setDate(9, DateUtility.getCurrentDate());
				retValue = stmt.executeUpdate();
			}
		} catch (SQLException e) {
			throw new SQLException("Could not insert childParents: "
					+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
		return retValue;
	}

	public static int insertChildSiblings(Connection conn,
			ChildSiblings childSiblings) throws SQLException {
		String sql;
		int retValue = 0;
		PreparedStatement stmt = null;
		try {
				if (childSiblings.getRef_child_key() != 0) {
					sql = "insert into child_siblings (child_fk, current_program_fk, details, last_modified_by, last_modified_on, active, ref_child_key) "
							+ "values(?,?,?,?,?,?,?)";
					stmt = conn.prepareStatement(sql);
					stmt.setInt(1, childSiblings.getChild_fk());
					stmt.setInt(2, 1);
					stmt.setString(3, childSiblings.getDetails());
					stmt.setInt(4, childSiblings.getLast_modified_by_fk());
					stmt.setDate(5, DateUtility.getCurrentDate());
					stmt.setInt(6, 1);
					stmt.setInt(7, childSiblings.getRef_child_key());
					retValue = stmt.executeUpdate();
				}
				else{
					sql = "insert into child_siblings (child_fk, name, dob, current_program_fk, details, fiscal_year_fk, last_modified_by, last_modified_on, active) "
							+ "values(?,?,?,?,?,?,?,?,?)";
					stmt = conn.prepareStatement(sql);
					stmt.setInt(1, childSiblings.getChild_fk());
					stmt.setString(2, childSiblings.getName());
					stmt.setDate(3, DateUtility.convertStringToSQLDate(childSiblings.getDob()));
					stmt.setInt(4, 2);
					stmt.setString(5, childSiblings.getDetails());
					stmt.setInt(6, childSiblings.getFiscal_year_fk());
					stmt.setInt(7, childSiblings.getLast_modified_by_fk());
					stmt.setDate(8, DateUtility.getCurrentDate());
					stmt.setInt(9, 1);
					retValue = stmt.executeUpdate();
				}
			
		} catch (SQLException e) {
			throw new SQLException("Could not insert childSiblings: "
					+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
		return retValue;
	}
}
