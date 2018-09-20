package sonshine.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import org.apache.log4j.Logger;

import com.mysql.jdbc.PreparedStatement;

import sonshine.beans.Address;
import sonshine.beans.Child;
import sonshine.beans.ChildAcademics;
import sonshine.beans.ChildMedical;
import sonshine.beans.ChildPhotos;
import sonshine.beans.ChildProgram;
import sonshine.beans.ChildSponsorDetails;
import sonshine.beans.ChildView;
import sonshine.beans.VChildAcademics;
import sonshine.beans.VChildDocuments;
import sonshine.beans.VChildParents;
import sonshine.beans.VChildProgram;
import sonshine.beans.VChildSiblings;
import sonshine.beans.VChildSponsorDetails;
import sonshine.beans.VFinanceExpenseAmount;
import sonshine.beans.VFinanceSponsorAmount;
import sonshine.beans.VNlchStaffDetails;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class ChildViewPeer {

	static final Logger LOGGER = Logger.getLogger(ChildViewPeer.class);

	public static ChildView getChildOnly(DataManager dataManager, int childId) {
		ChildView child = null;
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select c.child_id, c.name, c.dob, DATE_FORMAT(c.application_date, '%d-%M-%Y'), DATE_FORMAT(c.enrollment_date, '%d-%M-%Y'), gg.gender, gr.religion, c.place_of_birth, gl.language, "
						+ "ca.street, ca.area, ca.city_town, ca.state, ca.country, ca.zip, "
						+ "c.physical_defects, c.reason, DATE_FORMAT(c.created_date, '%d-%M-%Y') "
						+ "from child c "
						+ "inner join child_address ca on c.address_fk = ca.child_address_pk "
						+ "inner join gen_genders gg on c.gender_fk = gg.gender_pk "
						+ "inner join gen_religions gr on c.religion_fk = gr.religion_pk "
						+ "inner join gen_languages gl on c.mother_tongue_fk = gl.language_pk "
						+ "where c.child_pk = " + childId + ";";
				try {
					ResultSet rs = s.executeQuery(sql);
					if (rs.next()) {
						child = new ChildView();
						Address address = new Address();
						// saving child details
						child.setChild_id(rs.getString(1));
						child.setName(rs.getString(2));
						child.setDob(rs.getString(3));
						child.setApplication_date(rs.getString(4));
						child.setEnrollment_date(rs.getString(5));
						child.setGender(rs.getString(6));
						child.setReligion(rs.getString(7));
						child.setPlace_of_birth(rs.getString(8));
						child.setMother_tongue(rs.getString(9));

						// saving address details
						address.setStreet(rs.getString(10));
						address.setArea(rs.getString(11));
						address.setCity_town(rs.getString(12));
						address.setState(rs.getString(13));
						address.setCountry(rs.getString(14));
						address.setZip(rs.getString(15));
						child.setAddress(address);

						// saving rest of the child details
						child.setPhysical_defects(rs.getString(16));
						child.setReason(rs.getString(17));
						child.setCreated_date(rs.getString(18));
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				LOGGER.debug("Could not get child: " + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return child;
	}

	public static ChildView getChildById(Connection conn, String childId) {
		ChildView child = null;

		if (conn != null) {
			try {
				Statement s = conn.createStatement();
				String sql = "select c.child_id, c.name, c.dob, DATE_FORMAT(c.application_date, '%d-%M-%Y'), DATE_FORMAT(c.enrollment_date, '%d-%M-%Y'), gg.gender, gr.religion, c.place_of_birth, gl.language, "
						+ "ca.street, ca.area, ca.city_town, ca.state, ca.country, ca.zip, "
						+ "c.physical_defects, c.reason, DATE_FORMAT(c.created_date, '%d-%M-%Y'),c.child_pk "
						+ "from child c "
						+ "inner join child_address ca on c.address_fk = ca.child_address_pk "
						+ "inner join gen_genders gg on c.gender_fk = gg.gender_pk "
						+ "inner join gen_religions gr on c.religion_fk = gr.religion_pk "
						+ "inner join gen_languages gl on c.mother_tongue_fk = gl.language_pk "
						+ "where c.child_id = " + childId + ";";
				try {
					ResultSet rs = s.executeQuery(sql);
					if (rs.next()) {
						child = new ChildView();
						Address address = new Address();
						// saving child details
						child.setChild_id(rs.getString(1));
						child.setName(rs.getString(2));
						child.setDob(rs.getString(3));
						child.setApplication_date(rs.getString(4));
						child.setEnrollment_date(rs.getString(5));
						child.setGender(rs.getString(6));
						child.setReligion(rs.getString(7));
						child.setPlace_of_birth(rs.getString(8));
						child.setMother_tongue(rs.getString(9));

						// saving address details
						address.setStreet(rs.getString(10));
						address.setArea(rs.getString(11));
						address.setCity_town(rs.getString(12));
						address.setState(rs.getString(13));
						address.setCountry(rs.getString(14));
						address.setZip(rs.getString(15));
						child.setAddress(address);

						// saving rest of the child details
						child.setPhysical_defects(rs.getString(16));
						child.setReason(rs.getString(17));
						child.setCreated_date(rs.getString(18));
						child.setChild_key(rs.getInt(19));
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				LOGGER.error("Could not get child: " + e.getMessage());
			}
		}
		return child;
	}

	public static ArrayList<VChildAcademics> getChildAcademics(
			DataManager dataManager, int childKey, int childFiscal) {
		VChildAcademics childAcademics = null;
		ArrayList<VChildAcademics> academicsList = new ArrayList<VChildAcademics>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select nfy.year, yn.active,ca.class,ca.final_grade, ca.comments from child c "
						+ "inner join child_academics ca on ca.child_fk = c.child_pk "
						+ "inner join gen_yn yn on yn.yn_pk = ca.active_fk "
						+ "inner join nlch_fiscal_years nfy on nfy.fiscal_year_pk = ca.fiscal_year_fk "
						+ "where c.child_pk ="
						+ childKey
						+ " and nfy.fiscal_year_pk =" + childFiscal + ";";
				try {
					ResultSet rs = s.executeQuery(sql);
					while (rs.next()) {
						childAcademics = new VChildAcademics();
						// saving child address details
						childAcademics.setFiscal_year(rs.getString(1));
						childAcademics.setActive(rs.getString(2));
						childAcademics.setClassno(rs.getString(3));
						childAcademics.setFinal_grade(rs.getString(4));
						childAcademics.setComments(rs.getString(5));
						academicsList.add(childAcademics);
						// System.out.println(rs.getString(5));
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not get childAcademics: "
						+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return academicsList;
	}

	public static ArrayList<ChildMedical> getChildMedical(
			DataManager dataManager, int childKey, int childFiscal) {
		ChildMedical childMedical = null;
		ArrayList<ChildMedical> medicalList = new ArrayList<ChildMedical>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select DATE_FORMAT(cm.checkup_date, '%d-%M-%Y'), cm.treatment, cm.details from child c "
						+ "inner join child_medical cm on c.child_pk = cm.child_fk "
						+ "inner join nlch_fiscal_years nfy on nfy.fiscal_year_pk = cm.fiscal_year_fk "
						+ "where c.child_pk ="
						+ childKey
						+ " and nfy.fiscal_year_pk =" + childFiscal + ";";
				try {
					ResultSet rs = s.executeQuery(sql);
					while (rs.next()) {
						childMedical = new ChildMedical();
						// saving child address details
						childMedical.setCheckup_date(rs.getString(1));
						childMedical.setTreatment(rs.getString(2));
						childMedical.setDetails(rs.getString(3));
						medicalList.add(childMedical);
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not get childMedical: "
						+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return medicalList;
	}

	public static ChildPhotos getChildPhotoActive(DataManager dataManager,
			int childId, int childFiscal) {
		ChildPhotos childPhoto = null;
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select cp.last_modified_on, cp.photo_path from child c "
						+ "inner join child_photos cp on cp.child_fk = c.child_pk "
						+ "inner join nlch_fiscal_years nfy on nfy.fiscal_year_pk = cp.fiscal_year_fk "
						+ " where c.child_pk="
						+ childId
						+ " and nfy.fiscal_year_pk ="
						+ childFiscal
						+ " and cp.active = 1;";
				try {
					ResultSet rs = s.executeQuery(sql);
					if (rs.next()) {
						childPhoto = new ChildPhotos();
						// saving child address details
						childPhoto.setLast_modified_on(rs.getString(1));
						childPhoto.setPhoto_path(rs.getString(2));
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not get child Photo: "
						+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return childPhoto;
	}

	public static VChildProgram getChildProgram(DataManager dataManager,
			int childKey) {
		VChildProgram childProgram = null;
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select nfy.year, nss.status, ns.name, np.program, nl.location from child c "
						+ "inner join child_program cp on c.child_pk = cp.child_fk "
						+ "inner join nlch_fiscal_years nfy on nfy.fiscal_year_pk = cp.fiscal_year_fk "
						+ "inner join nlch_student_status nss on nss.student_status_pk = cp.status_fk "
						+ "inner join nlch_staff ns on ns.staff_pk = cp.pc_fk "
						+ "inner join nlch_programs np on np.programs_pk = cp.type_fk "
						+ "inner join nlch_locations nl on nl.location_pk = cp.location_fk "
						+ "where c.child_pk="
						+ childKey
						+ " and cp.active=1"
						+ ";";
				try {
					ResultSet rs = s.executeQuery(sql);
					if (rs.next()) {
						childProgram = new VChildProgram();
						childProgram.setFiscal_year(rs.getString(1));
						childProgram.setStatus(rs.getString(2));
						childProgram.setPc(rs.getString(3));
						childProgram.setType(rs.getString(4));
						childProgram.setLocation(rs.getString(5));
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not get child Program: "
						+ e.getMessage());

				LOGGER.error("Could not get child Program: " + e.getMessage());

			} finally {
				dataManager.putConnection(connection);
			}
		}
		return childProgram;
	}

	public static ArrayList<VChildParents> getChildParents(
			DataManager dataManager, int childKey) {
		VChildParents childParent = null;
		ArrayList<VChildParents> parentsList = new ArrayList<VChildParents>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "SELECT cp.name,nps.status,cp.occupation,cp.type,cp.parent_pk FROM child c "
						+ "inner join child_parents cp on cp.child_fk = c.child_pk "
						+ "inner join nlch_parent_status nps on nps.parent_status_pk = cp.status_fk "
						+ "where c.child_pk ="
						+ childKey
						+ " and active ="
						+ 1
						+ ";";
				try {
					ResultSet rs = s.executeQuery(sql);
					while (rs.next()) {
						childParent = new VChildParents();
						// saving child address details
						childParent.setName(rs.getString(1));
						childParent.setStatus(rs.getString(2));
						childParent.setOccupation(rs.getString(3));
						childParent.setType(rs.getString(4));
						childParent.setParent_pk(rs.getInt(5));
						parentsList.add(childParent);
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not get childParentsList: "
						+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return parentsList;
	}

	public static ArrayList<VChildSiblings> getChildSiblings(
			DataManager dataManager, int childKey) {
		VChildSiblings childSibling = null;
		ArrayList<VChildSiblings> siblingsList = new ArrayList<VChildSiblings>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select cs.name,yn.active,cs.details,cs.dob,cs.ref_child_key,cs.child_fk from child c "
						+ "inner join child_siblings cs on cs.child_fk = c.child_pk "
						+ "inner join gen_yn yn on yn.yn_pk=cs.current_program_fk "
						+ "where c.child_pk ="
						+ childKey
						+ " and cs.active =" + 1 + ";";
				try {
					ResultSet rs = s.executeQuery(sql);
					while (rs.next()) {
						childSibling = new VChildSiblings();
						// saving child address details
						childSibling.setName(rs.getString(1));
						childSibling.setCurrent_program_fk(rs.getString(2));
						childSibling.setDetails(rs.getString(3));
						childSibling.setDob(rs.getString(4));
						childSibling.setRef_child_key(rs.getString(5));
						childSibling.setChild_key(rs.getInt(6));
						siblingsList.add(childSibling);
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not get childSiblingsList: "
						+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return siblingsList;
	}

	public static ArrayList<VChildDocuments> getChildDocuments(
			DataManager dataManager, int childKey, int childFiscal) {
		VChildDocuments childDocument = null;
		ArrayList<VChildDocuments> documentsList = new ArrayList<VChildDocuments>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select yn.active,cd.last_modified_on,cd.name,cd.path,ndt.document_type from child c "
						+ "inner join child_documents cd on cd.child_fk = c.child_pk "
						+ "inner join gen_yn yn on cd.active_fk = yn.yn_pk "
						+ "inner join nlch_document_type ndt on ndt.document_type_pk = cd.type_fk "
						+ "inner join nlch_fiscal_years nfy on nfy.fiscal_year_pk = cd.fiscal_year_fk "
						+ "where c.child_pk ="
						+ childKey
						+ " and nfy.fiscal_year_pk =" + childFiscal + ";";
				try {
					ResultSet rs = s.executeQuery(sql);
					while (rs.next()) {
						childDocument = new VChildDocuments();
						// saving child address details
						childDocument.setActive(rs.getString(1));
						childDocument.setLast_modified_on(rs.getString(2));
						childDocument.setName(rs.getString(3));
						childDocument.setPath(rs.getString(4));
						childDocument.setType(rs.getString(5));
						documentsList.add(childDocument);
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not get childDocumentList: "
						+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return documentsList;
	}

	public static ArrayList<VChildSponsorDetails> getChildSponsor(
			DataManager dataManager, int childKey, int childFiscal) {
		ArrayList<VChildSponsorDetails> sponsorsList = new ArrayList<VChildSponsorDetails>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select csd.sponsor_details_pk, csd.name,csd.entry_date,csd.exit_date,gc.country_name from child_sponsor_details csd "
						+ "inner join child c on c.child_pk = csd.child_fk "
						+ "inner join gen_countries gc on gc.country_pk = csd.country_fk "
						+ "inner join nlch_fiscal_years nfy on nfy.fiscal_year_pk = csd.fiscal_year_fk "
						+ "where c.child_pk ="
						+ childKey
						+ " and nfy.fiscal_year_pk=" + childFiscal;
				try {
					ResultSet rs = s.executeQuery(sql);
					while (rs.next()) {
						VChildSponsorDetails vChildSponsorDetails = new VChildSponsorDetails();
						// saving child address details
						vChildSponsorDetails.setSponsor_details_pk(Integer
								.parseInt(rs.getString(1)));
						vChildSponsorDetails.setName(rs.getString(2));
						vChildSponsorDetails.setEntry_date(rs.getString(3));
						vChildSponsorDetails.setExit_date(rs.getString(4));
						vChildSponsorDetails.setCountry(rs.getString(5));
						sponsorsList.add(vChildSponsorDetails);
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not get childSponsorsDetailsList: "
						+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return sponsorsList;
	}

	public static ArrayList<VFinanceSponsorAmount> getFinanceSponsor(
			DataManager dataManager, int childKey, int childFiscal) {
		ArrayList<VFinanceSponsorAmount> financeSponsorsList = new ArrayList<VFinanceSponsorAmount>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select gm.month_name, csd.name,fsa.sponsor_amount  from finance_sponsor_amount fsa "
						+ "inner join child c on c.child_pk = fsa.child_fk "
						+ "inner join nlch_fiscal_years nfy on nfy.fiscal_year_pk = fsa.fiscal_year_fk "
						+ "inner join gen_month gm on gm.month_pk = fsa.month_fk "
						+ "inner join child_sponsor_details csd on csd.sponsor_details_pk=fsa.sponsor_person_fk "
						+ "where c.child_pk ="
						+ childKey
						+ " and nfy.fiscal_year_pk="
						+ childFiscal
						+ " order by gm.month_pk";
				try {
					ResultSet rs = s.executeQuery(sql);
					while (rs.next()) {
						VFinanceSponsorAmount financeSponsorAmount = new VFinanceSponsorAmount();
						// saving child address details
						financeSponsorAmount.setMonth(rs.getString(1));
						financeSponsorAmount.setSponsor_person(rs.getString(2));
						financeSponsorAmount.setSponsor_amount(Float
								.parseFloat(rs.getString(3)));
						financeSponsorsList.add(financeSponsorAmount);
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not get financeSponsorsAmountList: "
						+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return financeSponsorsList;
	}

	public static ArrayList<VFinanceExpenseAmount> getFinanceExpense(
			DataManager dataManager, int childKey, int childFiscal) {
		ArrayList<VFinanceExpenseAmount> financeExpensesList = new ArrayList<VFinanceExpenseAmount>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select gm.month_name, fea.expense_type ,fea.expense_amount  from finance_expense_amount fea "
						+ "inner join child c on c.child_pk = fea.child_fk "
						+ "inner join nlch_fiscal_years nfy on nfy.fiscal_year_pk = fea.fiscal_year_fk "
						+ "inner join gen_month gm on gm.month_pk = fea.month_fk "
						+ "where c.child_pk ="
						+ childKey
						+ " and nfy.fiscal_year_pk="
						+ childFiscal
						+ " order by gm.month_pk";
				try {
					ResultSet rs = s.executeQuery(sql);
					while (rs.next()) {
						VFinanceExpenseAmount financeExpenseAmount = new VFinanceExpenseAmount();
						// saving child address details
						financeExpenseAmount.setMonth(rs.getString(1));
						financeExpenseAmount.setExpense_name(rs.getString(2));
						financeExpenseAmount.setAmount(Float.parseFloat(rs
								.getString(3)));
						financeExpensesList.add(financeExpenseAmount);
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not get financeExpenseAmountList: "
						+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return financeExpensesList;
	}

	public static VNlchStaffDetails getStaffDetails(DataManager dataManager,
			String user_name) {
		VNlchStaffDetails staff = null;
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select staff_pk,user_name,name from nlch_staff ns where ns.user_name = '"
						+ user_name + "';";
				try {
					ResultSet rs = s.executeQuery(sql);
					if (rs.next()) {
						staff = new VNlchStaffDetails();
						staff.setStaff_pk(rs.getInt(1));
						staff.setUser_name(rs.getString(2));
						staff.setName(rs.getString(3));
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out
						.println("Could not get nlch staff details by username: "
								+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return staff;

	}

	public static Hashtable<Integer, String> getFiscalYearsByChildId(
			DataManager dataManager, int childKey) {
		Hashtable<Integer, String> fiscalYears = new Hashtable<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select nfy.fiscal_year_pk, nfy.year from child c "
						+ "inner join child_program cp on c.child_pk = cp.child_fk "
						+ "inner join nlch_programs np on np.programs_pk = cp.type_fk "
						+ "inner join nlch_fiscal_years nfy on cp.fiscal_year_fk = nfy.fiscal_year_pk "
						+ "where c.child_pk = " + childKey;
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							fiscalYears.put(rs.getInt(1), rs.getString(2));
							// System.out.println("Successfully loaded zyn");
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not fetch fiscal_years by child id:"
						+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return fiscalYears;
	}
}
