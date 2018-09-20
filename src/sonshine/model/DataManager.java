package sonshine.model;

import sonshine.beans.Address;
import sonshine.beans.Child;
import sonshine.beans.ChildDocuments;
import sonshine.beans.ChildPhotos;
import sonshine.beans.ChildSponsorDetails;
import sonshine.beans.ChildView;
import sonshine.beans.ChildAcademics;
import sonshine.beans.ChildComments;
import sonshine.beans.ChildIdentifyMarks;
import sonshine.beans.ChildMedical;
import sonshine.beans.ChildParents;
import sonshine.beans.ChildProgram;
import sonshine.beans.ChildSiblings;
import sonshine.beans.FinanceExpenseAmount;
import sonshine.beans.FinanceSponsorAmount;
import sonshine.beans.VChildAcademics;
import sonshine.beans.VChildDocuments;
import sonshine.beans.VChildParents;
import sonshine.beans.VChildProgram;
import sonshine.beans.VChildSiblings;
import sonshine.beans.VChildSponsorDetails;
import sonshine.beans.VFinanceExpenseAmount;
import sonshine.beans.VFinanceSponsorAmount;
import sonshine.beans.VNlchStaffDetails;
import sonshine.beans.VSearchOutcomeChild;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.ArrayList;
import java.util.Enumeration;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;

import org.apache.commons.lang3.exception.ExceptionUtils;
import org.apache.log4j.Logger;

import com.mysql.fabric.xmlrpc.base.Value;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class DataManager {
	private String dbURL = "";
	private String dbUserName = "";
	private String dbPassword = "";
	static final Logger LOGGER = Logger.getLogger(DataManager.class);

	public void setDbURL(String dbURL) {
		this.dbURL = dbURL;
	}

	public String getDbURL() {
		return dbURL;
	}

	public void setDbUserName(String dbUserName) {
		this.dbUserName = dbUserName;
	}

	public String getDbUserName() {
		return dbUserName;
	}

	public void setDbPassword(String dbPassword) {
		this.dbPassword = dbPassword;
	}

	public String getDbPassword() {
		return dbPassword;
	}

	public Connection getConnection() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(getDbURL(), getDbUserName(),
					getDbPassword());
		} catch (SQLException e) {
			LOGGER.error("Could not connect to DB: " + e.getMessage());
		}
		return conn;
	}

	public void putConnection(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
			}
		}
	}

	// child create populate operations
	public HashMap<Integer, String> getPrograms() {
		return PopulatorPeer.getPrograms(this);
	}

	public HashMap<Integer, String> getLocations() {
		return PopulatorPeer.getLocations(this);
	}

	public HashMap<Integer, String> getCoordinators() {
		return PopulatorPeer.getCoordinators(this);
	}

	public HashMap<Integer, String> getStudentStatuss() {
		return PopulatorPeer.getStudentStatus(this);
	}

	public Hashtable<Integer, String> getFiscalYears() {
		return PopulatorPeer.getFiscalYears(this);
	}

	public HashMap<Integer, String> getLanguages() {
		return PopulatorPeer.getLanguages(this);
	}

	public HashMap<Integer, String> getReligions() {
		return PopulatorPeer.getReligions(this);
	}

	public HashMap<Integer, String> getParentStatus() {
		return PopulatorPeer.getParentStatus(this);
	}

	public HashMap<Integer, String> getYN() {
		return PopulatorPeer.getYN(this);
	}

	public HashMap<Integer, String> getDocumentTypes() {
		return PopulatorPeer.getDocumentTypes(this);
	}

	public HashMap<Integer, String> getMonths() {
		return PopulatorPeer.getMonths(this);
	}

	public HashMap<Integer, String> getCountries() {
		return PopulatorPeer.getCountries(this);
	}
	
	public ArrayList<ChildProgram> getCurrentProgramsActiveForChild(int childKey) {
		return PopulatorPeer.getCurrentProgramsActiveForChild(this, childKey);
	}

	// insert operations
	public int insertChildNew(Child child, ChildProgram childProgram,
			Address childAddress,
			ArrayList<ChildIdentifyMarks> childIdentifyMarks,
			ChildAcademics childAcademics, ChildComments childComments,
			ChildMedical childMedical,
			ArrayList<ChildParents> childParentsList,
			ArrayList<ChildSiblings> childSiblingsList) {
		int returnValue = 0;
		int addressKey = 0, childKey = 0;

		// getting connection
		Connection connection = getConnection();
		if (connection != null) {
			try {
				connection.setAutoCommit(false);

				// insert address transaction
				addressKey = ChildNewPeer.insertChildAddressOnly(connection,
						childAddress);
				child.setAddress_fk(addressKey);// set the child address
				childKey = ChildNewPeer.insertChild(connection, child);

				// childProgram transaction
				childProgram.setChild_fk(childKey);
				ChildNewPeer.insertChildProgram(connection, childProgram);

				// childIdentifyMarks transaction
				for (ChildIdentifyMarks childIdentifyMarks1 : childIdentifyMarks) {
					childIdentifyMarks1.setChild_fk(childKey);
				}
				ChildNewPeer.insertChildIdentifyMarks(connection,
						childIdentifyMarks);

				// ChildAcademics transaction
				childAcademics.setChild_fk(childKey);
				ChildNewPeer.insertChildAcademics(connection, childAcademics);

				// ChildComments transaction
				childComments.setChild_fk(childKey);
				ChildNewPeer.insertChildComments(connection, childComments);

				// ChildMedical transaction
				childMedical.setChild_fk(childKey);
				ChildNewPeer.insertChildMedical(connection, childMedical);

				// ArrayList<ChildParents> transaction
				for (ChildParents childParents : childParentsList) {
					childParents.setChild_fk(childKey);
				}
				ChildNewPeer.insertChildParents(connection, childParentsList);

				// ArrayList<ChildSiblings> transaction
				for (ChildSiblings childSiblings : childSiblingsList) {
					childSiblings.setChild_fk(childKey);
				}
				// ChildNewPeer.insertChildSiblings(connection,
				// childSiblingsList);

				connection.commit();
				// after successful transactions return key value
				returnValue = childKey;
			} catch (Exception e) {
				LOGGER.error("Could not insert child: " + e.getMessage());
				System.out.println("Could not insert child: " + e.getMessage());
				try {
					connection.rollback();
				} catch (SQLException ee) {
				}
			}
			putConnection(connection);
		}

		return returnValue;
	}

	public int insertNewFiscalForChild(ChildProgram childProgram,
			ChildAcademics childAcademics, ChildComments childComments,
			ChildMedical childMedical,
			ArrayList<ChildParents> childParentsList,
			ArrayList<ChildSiblings> childSiblingsList) {
		int returnValue = 0;

		// getting connection
		Connection connection = getConnection();
		if (connection != null) {
			try {
				connection.setAutoCommit(false);

				// childProgram transaction
				ChildNewPeer.insertChildProgram(connection, childProgram);

				// ChildAcademics transaction
				ChildNewPeer.insertChildAcademics(connection, childAcademics);

				// ChildComments transaction
				ChildNewPeer.insertChildComments(connection, childComments);

				// ChildMedical transaction
				ChildNewPeer.insertChildMedical(connection, childMedical);

				// ArrayList<ChildParents> transaction
				ChildNewPeer.insertChildParents(connection, childParentsList);

				// ArrayList<ChildSiblings> transaction
				// ChildNewPeer.insertChildSiblings(connection,
				// childSiblingsList);

				connection.commit();
				// after successful transactions return key value
				returnValue = childProgram.getChild_fk();
			} catch (Exception e) {
				System.out.println("Could not insert ChildNewFiscalYear: "
						+ e.getMessage());
				try {
					connection.rollback();
				} catch (SQLException ee) {
				}
			}
			putConnection(connection);
		}

		return returnValue;
	}

	public void insertChildPhoto(ChildPhotos childPhoto) {
		// getting connection
		Connection connection = getConnection();
		if (connection != null) {
			Statement stmt = null;
			try {
				connection.setAutoCommit(false);
				stmt = connection.createStatement();
				try {
					FilesPeer.insertPhoto(stmt, childPhoto);

					try {
						stmt.close();
					} finally {
						stmt = null;
					}
					connection.commit();
					// after successful transactions return key value

				} catch (SQLException e) {
					System.out.println("Could not insert child photo path: "
							+ e.getMessage());
					try {
						connection.rollback();
					} catch (SQLException ee) {
					}
				}
			} catch (SQLException e) {
				System.out.println("Could not insert child photopath: "
						+ e.getMessage());
			} finally {
				if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
					}
				}
				putConnection(connection);
			}
		}

	}

	public boolean insertChildSponsorDetails(
			ChildSponsorDetails childSponsorDetails) {
		// getting connection
		boolean insertionStatus = false;
		Connection connection = getConnection();
		if (connection != null) {

			try {
				connection.setAutoCommit(false);
				insertionStatus = ChildFinancePeer.insertChildSponsorDetails(
						connection, childSponsorDetails);
				connection.commit();
				// after successful transactions return key value

			} catch (SQLException e) {
				System.out.println("Could not insert child sponsor details: "
						+ e.getMessage());
				try {
					connection.rollback();
				} catch (SQLException ee) {
				}
			}
			putConnection(connection);
		}
		return insertionStatus;
	}

	public boolean insertFinanceSponsorDetails(
			FinanceSponsorAmount financeSponsorAmount) {
		// getting connection
		Connection connection = getConnection();
		boolean insertionStatus = false;
		if (connection != null) {

			try {
				connection.setAutoCommit(false);
				insertionStatus = ChildFinancePeer.insertFinanceSponsorAmount(
						connection, financeSponsorAmount);
				connection.commit();
				// after successful transactions return key value

			} catch (SQLException e) {
				System.out.println("Could not insert finance sponsor details: "
						+ e.getMessage());
				try {
					connection.rollback();
				} catch (SQLException ee) {
				}
			} finally {
				putConnection(connection);
			}
		}
		return insertionStatus;
	}

	public boolean insertFinanceExpenseDetails(
			FinanceExpenseAmount financeExpenseAmount) {
		// getting connection
		boolean insertionStatus = false;
		Connection connection = getConnection();
		if (connection != null) {

			try {
				connection.setAutoCommit(false);
				insertionStatus = ChildFinancePeer.insertFinanceExpenseAmount(
						connection, financeExpenseAmount);
				connection.commit();
				// after successful transactions return key value

			} catch (SQLException e) {
				System.out.println("Could not insert finance expense details: "
						+ e.getMessage());
				try {
					connection.rollback();
				} catch (SQLException ee) {
				}
			}
			putConnection(connection);
		}
		return insertionStatus;
	}

	public int insertNewMedicalInformation(ChildMedical childMedical) {
		Connection connection = getConnection();
		int retValue = 0;
		if (connection != null) {

			try {
				connection.setAutoCommit(false);
				retValue = ChildNewPeer.insertChildMedical(connection,
						childMedical);
				connection.commit();
				// after successful transactions return key value

			} catch (SQLException e) {
				System.out.println("Could not insert medical record details: "
						+ e.getMessage());
				LOGGER.error("Could not insert medical record details: "
						+ ExceptionUtils.getStackTrace(e));

				try {
					connection.rollback();
				} catch (SQLException ee) {
				}
			} finally {
				putConnection(connection);
			}
		}
		return retValue;
	}

	public int insertNewParent(ArrayList<ChildParents> childParents) {
		Connection connection = getConnection();
		int retValue = 0;
		if (connection != null) {

			try {
				connection.setAutoCommit(false);
				retValue = ChildNewPeer.insertChildParents(connection,
						childParents);
				connection.commit();
				// after successful transactions return key value

			} catch (SQLException e) {
				System.out.println("Could not insert Parent details: "
						+ e.getMessage());
				LOGGER.error("Could not insert Parent details: "
						+ ExceptionUtils.getStackTrace(e));

				try {
					connection.rollback();
				} catch (SQLException ee) {
				}
			} finally {
				putConnection(connection);
			}
		}
		return retValue;
	}

	public int insertNewSibling(ChildSiblings sibling) {
		Connection connection = getConnection();
		int retValue = 0;
		ChildView refChild = null;
		if (connection != null) {

			try {
				connection.setAutoCommit(false);
					if (!(sibling.getRef_child_id().equals(""))
							&& sibling.getRef_child_id() != null) {
						refChild = ChildViewPeer.getChildById(connection,
								sibling.getRef_child_id());
						//exception will be thrown if a reference cannot be found
						sibling.setRef_child_key(refChild.getChild_key());
						System.out.println(refChild.getChild_key());
						
						//insert the brother now
						retValue = ChildNewPeer.insertChildSiblings(connection,
								sibling);
						
						int child = sibling.getChild_fk();
						int brother = sibling.getRef_child_key();
						if(!doesBrotherHasChildAlready(child, brother)){
							sibling.setChild_fk(brother);
							sibling.setRef_child_key(child);
							retValue = ChildNewPeer.insertChildSiblings(connection,
									sibling);
						}
					}
					else{
						retValue = ChildNewPeer.insertChildSiblings(connection,
								sibling);
					}
					//System.out.println(sibling.getRef_child_id());
				
				connection.commit();
				// after successful transactions return key value

			} catch (SQLException e) {
				System.out.println("Could not insert Sibling details: "
						+ e.getMessage());
				LOGGER.error("Could not insert Sibling details: "
						+ ExceptionUtils.getStackTrace(e));

				try {
					connection.rollback();
				} catch (SQLException ee) {
				}
			} finally {
				putConnection(connection);
			}
		}
		return retValue;
	}

	private boolean doesBrotherHasChildAlready(int child, int brother) {
		ArrayList<VChildSiblings> childSiblingsList = getChildSiblingsListById(brother);
		for (VChildSiblings sibling : childSiblingsList) {
			if (sibling.getChild_key() == child)
				return true;
		}
		return false;
	}

	public void insertChildDocument(ChildDocuments childDocument) {
		// getting connection
		Connection connection = getConnection();
		if (connection != null) {
			Statement stmt = null;
			try {
				connection.setAutoCommit(false);
				stmt = connection.createStatement();
				try {
					FilesPeer.insertDocument(stmt, childDocument);

					try {
						stmt.close();
					} finally {
						stmt = null;
					}
					connection.commit();
					// after successful transactions return key value

				} catch (SQLException e) {
					System.out.println("Could not insert child document path: "
							+ e.getMessage());
					try {
						connection.rollback();
					} catch (SQLException ee) {
					}
				}
			} catch (SQLException e) {
				System.out.println("Could not insert child document: "
						+ e.getMessage());
			} finally {
				if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
					}
				}
				putConnection(connection);
			}
		}
	}

	// -------------search operation
	public ArrayList<VSearchOutcomeChild> getSearchResults(String keyword) {
		return ChildPeer.searchChildren(this, keyword);
	}

	public Child getChildDetails(int childId) {
		return ChildPeer.getChildById(this, childId);
	}

	// -----------View Operations---------------//
	public ChildView getChildOnlyById(int childId) {
		return ChildViewPeer.getChildOnly(this, childId);
	}

	public ArrayList<VChildAcademics> getChildAcademicsListByIdAndFiscal(
			int childId, int childFiscal) {
		return ChildViewPeer.getChildAcademics(this, childId, childFiscal);
	}

	public ArrayList<ChildMedical> getChildMedicalListByIdAndFiscal(
			int childId, int childFiscal) {
		return ChildViewPeer.getChildMedical(this, childId, childFiscal);
	}

	public ChildPhotos getChildPhotoActiveByIdAndFiscal(int childId,
			int childFiscal) {
		return ChildViewPeer.getChildPhotoActive(this, childId, childFiscal);
	}

	public VChildProgram getChildProgramById(int childId) {
		return ChildViewPeer.getChildProgram(this, childId);
	}

	public ArrayList<VChildParents> getChildParentsListById(
			int childId) {
		return ChildViewPeer.getChildParents(this, childId);
	}

	public ArrayList<VChildSiblings> getChildSiblingsListById(int childId) {
		return ChildViewPeer.getChildSiblings(this, childId);
	}

	public ArrayList<VChildDocuments> getChildDocumentListByIdAndFiscal(
			int childId, int childFiscal) {
		return ChildViewPeer.getChildDocuments(this, childId, childFiscal);
	}

	public ArrayList<VChildSponsorDetails> getChildSponsorListByIdAndFiscal(
			int childId, int childFiscal) {
		return ChildViewPeer.getChildSponsor(this, childId, childFiscal);
	}

	public ArrayList<VFinanceSponsorAmount> getFinanceSponsorListByIdAndFiscal(
			int childId, int childFiscal) {
		return ChildViewPeer.getFinanceSponsor(this, childId, childFiscal);
	}

	public ArrayList<VFinanceExpenseAmount> getFinanceExpenseListByIdAndFiscal(
			int childId, int childFiscal) {
		return ChildViewPeer.getFinanceExpense(this, childId, childFiscal);
	}

	public VNlchStaffDetails getStaffDetailsByUserName(String user_name) {
		return ChildViewPeer.getStaffDetails(this, user_name);
	}

	public Hashtable<Integer, String> getFiscalYearsByChildId(int childKey) {
		return ChildViewPeer.getFiscalYearsByChildId(this, childKey);
	}
	
	
	// update operations

	public int doChildStatusUpdate(ChildProgram childProgram) {
		// getting connection
		int returnValue = 0;
		Connection connection = getConnection();
		int[] presentData = new int[4];
		if (connection != null) {
			try {
				connection.setAutoCommit(false);

				presentData = ChildUpdatePeer
						.findActiveChildProgramAndMakeInactive(connection,
								childProgram.getChild_fk(), true);
				// setting existing values
				childProgram.setPc_fk(presentData[0]);
				childProgram.setLocation_fk(presentData[1]);
				childProgram.setType_fk(presentData[2]);
				// after successful update, do the insert
				returnValue = ChildNewPeer.insertChildProgram(connection,
						childProgram);

				connection.commit();
			} catch (Exception e) {
				LOGGER.error("Could not do status update: " + e.getMessage());
				System.out.println("Could not do status update: "
						+ e.getMessage());
				try {
					connection.rollback();
				} catch (SQLException ee) {
				}
			}
			putConnection(connection);
		}
		return returnValue;
	}
	
	public int doChildProgramUpdate(ChildProgram childProgram) {
		// getting connection
		int returnValue = 0;
		Connection connection = getConnection();
		int[] presentData = new int[4];
		if (connection != null) {
			try {
				connection.setAutoCommit(false);

				presentData = ChildUpdatePeer
						.findActiveChildProgramAndMakeInactive(connection,
								childProgram.getChild_fk(), false);
				// setting existing values
				childProgram.setPc_fk(presentData[0]);
				childProgram.setLocation_fk(presentData[1]);
				childProgram.setType_fk(presentData[2]);
				childProgram.setStatus_fk(presentData[3]);
				// after successful update, do the insert
				returnValue = ChildNewPeer.insertChildProgram(connection,
						childProgram);

				connection.commit();
			} catch (Exception e) {
				LOGGER.error("Could not do Program update: " + e.getMessage());
				System.out.println("Could not do Program update: "
						+ e.getMessage());
				try {
					connection.rollback();
				} catch (SQLException ee) {
				}
			}
			putConnection(connection);
		}
		return returnValue;
	}
	
	public int doParentStatusUpdate(ChildParents childParent) {
		// getting connection
		int returnValue = 0;
		Connection connection = getConnection();
		if (connection != null) {
			try {
				connection.setAutoCommit(false);
				//System.out.println("Entering do parentstatus update");
				int temp = ChildUpdatePeer.makeCurrentParentDataInactive(connection, childParent);
				//System.out.println(temp);
				ArrayList<ChildParents> arrayList = new ArrayList<ChildParents>();
				arrayList.add(childParent);
				if(temp > 0){
					returnValue = ChildNewPeer.insertChildParents(connection, arrayList);
				}
				else
					System.out.println("Old parent status update did not happen");
				connection.commit();
			} catch (Exception e) {
				LOGGER.error("Could not do parent status update: " + e.getMessage());
				System.out.println("Could not do parent status update: "
						+ e.getMessage());
				try {
					connection.rollback();
				} catch (SQLException ee) {
				}
			}
			putConnection(connection);
		}
		return returnValue;
	}
	//
	/*
	 * //---------- Category operations ---------- public String
	 * getCategoryName(String categoryID) { Category category =
	 * CategoryPeer.getCategoryById(this, categoryID); return (category == null)
	 * ? null : category.getName(); }
	 * 
	 * public Hashtable<String, String> getCategories() { return
	 * CategoryPeer.getAllCategories(this); }
	 * 
	 * public Enumeration<String> getCatIDs() { return
	 * CategoryPeer.getAllCategories(this).keys(); }
	 * 
	 * //---------- Book operations ---------- public ArrayList<Book>
	 * getSearchResults(String keyword) { return BookPeer.searchBooks(this,
	 * keyword); }
	 * 
	 * public ArrayList<Book> getBooksInCategory(String categoryID) { return
	 * BookPeer.getBooksByCategory(this, categoryID); }
	 * 
	 * public Book getBookDetails(String bookID) { return
	 * BookPeer.getBookById(this, bookID); }
	 * 
	 * //---------- Order operations ---------- public long insertOrder(Customer
	 * customer, Hashtable<String, CartItem> shoppingCart) { long returnValue =
	 * 0L; long orderId = System.currentTimeMillis(); Connection connection =
	 * getConnection(); if (connection != null) { Statement stmt = null; try {
	 * connection.setAutoCommit(false); stmt = connection.createStatement(); try
	 * { OrderPeer.insertOrder(stmt, orderId, customer);
	 * OrderDetailsPeer.insertOrderDetails(stmt, orderId, shoppingCart); try {
	 * stmt.close(); } finally { stmt = null; } connection.commit(); returnValue
	 * = orderId; } catch (SQLException e) {
	 * System.out.println("Could not insert order: " + e.getMessage()); try {
	 * connection.rollback(); } catch (SQLException ee) { } } } catch
	 * (SQLException e) { System.out.println("Could not insert order: " +
	 * e.getMessage()); } finally { if (stmt != null) { try { stmt.close(); }
	 * catch (SQLException e) { } } putConnection(connection); } } return
	 * returnValue; }
	 */

}
