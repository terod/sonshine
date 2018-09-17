package sonshine.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import sonshine.beans.ChildParents;
import sonshine.beans.ChildProgram;
import sonshine.beans.VChildProgram;

public class ChildUpdatePeer {

	public static int[] findActiveChildProgramAndMakeInactive(
			Connection connection, int childKey, boolean makeActive) throws SQLException {
		int programKey = 0;
		//to get back the current data values in order to save another query
		int[] presentData = new int[4];
		String sql;
		int activeState = 1;
		if(makeActive)
			activeState = 1;
		else
			activeState = 0;
		sql = "select cp.program_pk, cp.pc_fk, cp.location_fk, cp.type_fk, cp.status_fk from child_program cp where cp.child_fk = "
				+ childKey + " and cp.active =" + activeState + ";";
		Statement s = connection.createStatement();
		try {
			ResultSet rs = s.executeQuery(sql);
			if (rs.next()) {
				programKey = rs.getInt(1);
				presentData[0] = rs.getInt(2);
				presentData[1] = rs.getInt(3);
				presentData[2] = rs.getInt(4);
				presentData[3] = rs.getInt(5);
			}
		} finally {
			s.close();
		}

		String updatesql = "UPDATE child_program SET active=0 WHERE program_pk = ?";

		PreparedStatement stmt = null;
		try {
			stmt = connection.prepareStatement(updatesql);
			stmt.setInt(1, programKey);
			stmt.execute();
		} catch (SQLException e) {
			throw new SQLException(
					"Could not make the existing record as inactive: "
							+ e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
				}
			}
		}
		return presentData;
	}

	public static int makeCurrentParentDataInactive(Connection connection, ChildParents childParent)  throws SQLException {
		int retValue = 0;

		String updatesql = "UPDATE child_parents SET active=0 WHERE parent_pk = ?";
		//System.out.println(childParent.getName() + "is going to be made inactive with " + childParent.getParent_pk());
		PreparedStatement stmt = null;
		try {
			stmt = connection.prepareStatement(updatesql);
			stmt.setInt(1, childParent.getParent_pk());
			retValue = stmt.executeUpdate();
		} catch (SQLException e) {
			throw new SQLException(
					"Could not make the parent existing record as inactive: "
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
