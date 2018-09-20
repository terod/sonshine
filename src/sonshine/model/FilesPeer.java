package sonshine.model;

import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import sonshine.beans.ChildDocuments;
import sonshine.beans.ChildPhotos;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class FilesPeer {

	public static void insertPhoto(Statement stmt, ChildPhotos childPhoto)
			throws SQLException {
		String sql;

		// for saving dated field
		java.util.Date date = new java.util.Date();
		java.sql.Date currentDate = new java.sql.Date(date.getTime());

		sql = "insert into child_photos (child_fk, active, last_modified_on, photo_path, fiscal_year_fk, last_modified_by)"
				+ "values (" + childPhoto.getChild_fk() + ",1,'" + currentDate
				+ "','" + childPhoto.getPhoto_path() + "'," + childPhoto.getFiscal_year_fk() + ","
						+ childPhoto.getLast_modified_by_fk() + ");";
		stmt.executeUpdate(sql);
	}

	public static void insertDocument(Statement stmt,
			ChildDocuments childDocument) throws SQLException {
		String sql;

		// for saving dated field
		java.util.Date date = new java.util.Date();
		java.sql.Date currentDate = new java.sql.Date(date.getTime());

		sql = "insert into child_documents (child_fk, active_fk, last_modified_on, name, path, type_fk, fiscal_year_fk, last_modified_by)"
				+ "values ("
				+ childDocument.getChild_fk()
				+ ",1,'"
				+ currentDate
				+ "','"
				+ childDocument.getName()
				+ "','"
				+ childDocument.getPath()
				+ "',"
				+ childDocument.getType_fk()
				+ ","
				+ childDocument.getFiscal_year_fk()
				+ ","
				+ childDocument.getLast_modified_by_fk()
				+ ");";
		stmt.executeUpdate(sql);
	}
}
