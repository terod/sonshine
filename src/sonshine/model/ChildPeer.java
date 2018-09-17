package sonshine.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import sonshine.beans.Child;
import sonshine.beans.VSearchOutcomeChild;

public class ChildPeer {
	public static ArrayList<VSearchOutcomeChild> searchChildren(
			DataManager dataManager, String keyword) {
		int ChildKeyForFiscalYears = 0;
		ArrayList<VSearchOutcomeChild> childList = new ArrayList<VSearchOutcomeChild>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sqlForBasicDetails = "select c.child_pk,c.child_id,c.name from child c inner join child_program cp on c.child_pk=cp.child_fk "
						+ "inner join nlch_programs np on cp.type_fk = np.programs_pk "
						+ "inner join nlch_fiscal_years nfy on nfy.fiscal_year_pk = cp. fiscal_year_fk "
						+ " where c.name like '%"
						+ keyword.trim()
						+ "%'"
						+ " or c.child_id like '%"
						+ keyword.trim()
						+ "%' "
						+ "group by c.child_pk,c.child_id,c.name; ";

				
				try {
					ResultSet rs = s.executeQuery(sqlForBasicDetails);
					try {
						while (rs.next()) {
							VSearchOutcomeChild child = new VSearchOutcomeChild();
							child.setChild_key(Integer.parseInt((rs
									.getString(1))));
							child.setChild_id(rs.getString(2));
							child.setName(rs.getString(3));

							// now fetching fiscal year details for this child
							Statement s2 = connection.createStatement();
							String sqlForFiscalYears = "select cp.fiscal_year_fk,nfy.year,np.program from child c inner join child_program cp on c.child_pk=cp.child_fk "
									+ "inner join nlch_programs np on cp.type_fk = np.programs_pk "
									+ "inner join nlch_fiscal_years nfy on nfy.fiscal_year_pk = cp. fiscal_year_fk "
									+ " where c.child_pk =" + child.getChild_key() +" and cp.active=1" +  ";";
							try {
								ResultSet rs2 = s2
										.executeQuery(sqlForFiscalYears);
								HashMap<Integer, String[]> childFiscalYears = new HashMap<Integer, String[]>();
								try {
									while (rs2.next()) {
										String[] yearProgram = new String[2];
										yearProgram[0] = rs2.getString(2);
										yearProgram[1] = rs2.getString(3);
										childFiscalYears.put(rs2.getInt(1),
												yearProgram);
									}

									child.setFiscal_years_map(childFiscalYears);
									childList.add(child);

								} finally {
									rs2.close();
								}
							} finally {
								s2.close();
							}
						}
					} finally {
						rs.close();
					}

				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not search for children:"
						+ e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return childList;
	}

	public static Child getChildById(DataManager dataManager, int childId) {
		Child child = null;
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "select child_id, name from child"
						+ " where child_pk='" + childId + "';";
				try {
					ResultSet rs = s.executeQuery(sql);
					if (rs.next()) {
						child = new Child();
						child.setChild_id(rs.getString(1));
						child.setName(rs.getString(2));
					}
				} finally {
					s.close();
				}
			} catch (SQLException e) {
				System.out.println("Could not get child: " + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return child;

	}
}
