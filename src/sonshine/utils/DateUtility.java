package sonshine.utils;

import java.sql.SQLData;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import org.apache.log4j.Logger;

/**
 * 
 * @author George Ebbinason
 * @version v1
 */
public class DateUtility {
	final static Logger LOGGER = Logger.getLogger(DateUtility.class);

	public static int getDiffYears(Date first, Date last) {
		Calendar a = getCalendar(first);
		Calendar b = getCalendar(last);
		int diff = b.get(Calendar.YEAR) - a.get(Calendar.YEAR);
		if (a.get(Calendar.MONTH) > b.get(Calendar.MONTH)
				|| (a.get(Calendar.MONTH) == b.get(Calendar.MONTH) && a
						.get(Calendar.DATE) > b.get(Calendar.DATE))) {
			diff--;
		}
		return diff;
	}

	public static int getDiffFromCurrentYear(String firstString) {
		Date last = new Date();
		// LOGGER.debug("Incoming date is " + firstString);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date first = null;
		try {

			first = formatter.parse(firstString);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		// LOGGER.debug("First year: " + first.getYear() + ", Last Year: " +
		// last.getYear());
		Calendar a = getCalendar(first);
		Calendar b = getCalendar(last);
		int diff = b.get(Calendar.YEAR) - a.get(Calendar.YEAR);
		// LOGGER.debug("Difference in years is: " + diff);
		if (a.get(Calendar.MONTH) > b.get(Calendar.MONTH)
				|| (a.get(Calendar.MONTH) == b.get(Calendar.MONTH) && a
						.get(Calendar.DATE) > b.get(Calendar.DATE))) {
			diff--;
		}
		return diff;
	}

	public static Calendar getCalendar(Date date) {
		Calendar cal = Calendar.getInstance(Locale.US);
		cal.setTime(date);
		return cal;
	}

	public static java.sql.Date convertStringToSQLDate(String string) {
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		java.sql.Date sqlDate = null;
		try {

			java.util.Date tempDate = formatter.parse(string);
			sqlDate = new java.sql.Date(tempDate.getTime());

		} catch (ParseException e) {
			e.printStackTrace();
		}
		return sqlDate;
	}

	public static java.sql.Date getCurrentDate() {
		// create a new object called date to record the current date
		java.util.Date createDate = new java.util.Date();
		return new java.sql.Date(createDate.getTime());
	}
}
