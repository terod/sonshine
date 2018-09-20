package sonshine.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;

import sonshine.beans.ChildProgram;
/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class PopulatorPeer {

	public static HashMap<Integer, String> getPrograms(DataManager dataManager) {
		HashMap<Integer, String> programs = new HashMap<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select programs_pk, program from nlch_programs";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							programs.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out
						.println("Could not fetch programs:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return programs;
	}

	public static HashMap<Integer, String> getLocations(DataManager dataManager) {
		HashMap<Integer, String> locations = new HashMap<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select location_pk, location from nlch_locations";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							locations.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out
						.println("Could not fetch locations:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return locations;
	}
	
	public static HashMap<Integer, String> getCoordinators(DataManager dataManager) {
		HashMap<Integer, String> coordinators = new HashMap<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select staff_pk, name from nlch_staff";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							coordinators.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out
						.println("Could not fetch coordinators:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return coordinators;
	}
	
	public static HashMap<Integer, String> getStudentStatus(DataManager dataManager) {
		HashMap<Integer, String> StudentStatuss = new HashMap<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select student_status_pk, status from nlch_student_status";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							StudentStatuss.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out
						.println("Could not fetch coordinators:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return StudentStatuss;
	}
	
	public static Hashtable<Integer, String> getFiscalYears(DataManager dataManager) {
		Hashtable<Integer, String> fiscalYears = new Hashtable<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select fiscal_year_pk, year from nlch_fiscal_years order by year";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							fiscalYears.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not fetch fiscal_years:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return fiscalYears;
	}
	
	public static HashMap<Integer, String> getLanguages(DataManager dataManager) {
		HashMap<Integer, String> languages = new HashMap<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select language_pk, language from gen_languages";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							languages.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not fetch languages:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return languages;
	}
	
	public static HashMap<Integer, String> getReligions(DataManager dataManager) {
		HashMap<Integer, String> religions = new HashMap<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select religion_pk, religion from gen_religions";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							religions.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not fetch religionss:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return religions;
	}
	
	public static HashMap<Integer, String> getParentStatus(DataManager dataManager) {
		HashMap<Integer, String> parentStatus = new HashMap<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select parent_status_pk, status from nlch_parent_status";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							parentStatus.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not fetch parentstatus:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return parentStatus;
	}
	
	public static HashMap<Integer, String> getYN(DataManager dataManager) {
		HashMap<Integer, String> yn = new HashMap<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select yn_pk, active from gen_yn";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							yn.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not fetch yn:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return yn;
	}
	
	public static HashMap<Integer, String> getDocumentTypes(
			DataManager dataManager) {
		HashMap<Integer, String> documentTypes = new HashMap<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select document_type_pk,document_type from nlch_document_type;";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							documentTypes.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not fetch document types:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return documentTypes;
	}

	public static HashMap<Integer, String> getMonths(DataManager dataManager) {
		HashMap<Integer, String> months = new HashMap<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select month_pk, month_name from gen_month";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							months.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not fetch months:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return months;
	}

	public static HashMap<Integer, String> getCountries(DataManager dataManager) {
		HashMap<Integer, String> countries = new HashMap<Integer, String>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select country_pk, country_name from gen_countries";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							countries.put(rs.getInt(1), rs.getString(2));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not fetch countries:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return countries;
	}

	public static ArrayList<ChildProgram> getCurrentProgramsActiveForChild(
			DataManager dataManager, int childKey) {
		Connection connection = dataManager.getConnection();
		ChildProgram childProgram = null;
		ArrayList<ChildProgram> childProgramsList = new ArrayList<ChildProgram>(); 
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select * from child_program where child_fk =" + childKey + " and active = 1";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							childProgram = new ChildProgram();
							childProgram.setProgram_pk(rs.getInt(1));
							childProgram.setActive(rs.getInt(2));
							childProgram.setChild_fk(rs.getInt(3));
							childProgram.setType_fk(rs.getInt(4));
							childProgram.setLocation_fk(rs.getInt(5));
							childProgram.setPc_fk(rs.getInt(6));
							childProgram.setStatus_fk(rs.getInt(7));
							childProgram.setFiscal_year_fk(rs.getInt(8));
							childProgram.setFiscal_year_fk(rs.getInt(9));
							
							childProgramsList.add(childProgram);
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not fetch programs for the child:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return childProgramsList;
	}
	
	/*
	 * public static ArrayList<Book> getBooksByCategory(DataManager dataManager,
	 * String categoryId) { ArrayList<Book> books = new ArrayList<Book>();
	 * Connection connection = dataManager.getConnection(); if (connection !=
	 * null) { try { Statement s = connection.createStatement(); String sql =
	 * "select book_id, title, author, price from books" + " where category_id="
	 * + categoryId; try { ResultSet rs = s.executeQuery(sql); try { while
	 * (rs.next()) { Book book = new Book(); book.setId(rs.getString(1));
	 * book.setTitle(rs.getString(2)); book.setAuthor(rs.getString(3));
	 * book.setPrice(rs.getDouble(4)); books.add(book); } } finally {
	 * rs.close(); } } finally { s.close(); } } catch (SQLException e) {
	 * System.out.println("Could not get books: " + e.getMessage()); } finally {
	 * dataManager.putConnection(connection); } } return books; }
	 * 
	 * public static Book getBookById(DataManager dataManager, String bookID) {
	 * Book book = null; Connection connection = dataManager.getConnection(); if
	 * (connection != null) { try { Statement s = connection.createStatement();
	 * String sql = "select book_id, title, author, price from books" +
	 * " where book_id=" + bookID; try { ResultSet rs = s.executeQuery(sql); if
	 * (rs.next()) { book = new Book(); book.setId(rs.getString(1));
	 * book.setTitle(rs.getString(2)); book.setAuthor(rs.getString(3));
	 * book.setPrice(rs.getDouble(4)); } } finally { s.close(); } } catch
	 * (SQLException e) { System.out.println("Could not get book: " +
	 * e.getMessage()); } finally { dataManager.putConnection(connection); } }
	 * return book; }
	 */

}
