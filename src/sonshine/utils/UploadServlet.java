package sonshine.utils;

import java.io.File;
import java.io.IOException;
import java.nio.file.FileAlreadyExistsException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import sonshine.beans.ChildDocuments;
import sonshine.beans.ChildPhotos;
import sonshine.beans.VNlchStaffDetails;
import sonshine.model.DataManager;

/**
 * Servlet implementation class UploadServlet
 */
public class UploadServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// C:\\Program Files\\Apache Software
	// Foundation\\Tomcat\\webapps\\sonshine\\storage\\images
	// for windows
	private String UPLOAD_DIRECTORY_PHOTO = null;
	private String UPLOAD_DIRECTORY_FILES = null;
	private boolean STRATEGY_TO_PHOTO = true;

	static final Logger LOGGER = Logger.getLogger(UploadServlet.class);

	// public UploadServlet()
	// {
	// to ensure httpservlet is instantiated first and the getServletCOntext
	// does not return null
	// super();
	// cannot access methods of parent class from here

	// }

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		UPLOAD_DIRECTORY_PHOTO = (String) getServletContext().getAttribute(
				"fileUploadPath")
				+ "images";
		UPLOAD_DIRECTORY_FILES = (String) getServletContext().getAttribute(
				"fileUploadPath")
				+ "files";
		DataManager dataManager = (DataManager) getServletContext()
				.getAttribute("dataManager");
		if (dataManager == null)
			System.out.println("DataManager needs to accessed differently");

		// setting the one who modified each table
		String user_name = sonshine.utils.HTMLFilter.filter(request
				.getRemoteUser());
		VNlchStaffDetails staffDetails = dataManager
				.getStaffDetailsByUserName(user_name);
		LOGGER.info("Staff logged in uploadservlet is "
				+ staffDetails.getName() + staffDetails.getStaff_pk());

		int childKey = 0;
		int childFiscal = 0;
		int docType = 0;// only for files upload
		String docName = "File";
		String fileName = "";
		String uploadDir = "";
		boolean uploadSuccessful = false;

		// process only if its multipart content
		if (ServletFileUpload.isMultipartContent(request)) {
			try {
				List<FileItem> multiparts = new ServletFileUpload(
						new DiskFileItemFactory()).parseRequest(request);
				for (FileItem item : multiparts) {
					if (item.isFormField()) {
						// here...
						String fieldname = item.getFieldName();
						String fieldvalue = item.getString();
						if (fieldname.equals("action")) {
							if (!fieldvalue.equals("uploadPhoto"))
								STRATEGY_TO_PHOTO = false;

						} else if (fieldname.equals("childId")) {
							if (STRATEGY_TO_PHOTO) {
								File file = new File(UPLOAD_DIRECTORY_PHOTO
										+ File.separator + fieldvalue);
								if (!file.exists()) {
									if (file.mkdir()) {
										System.out
												.println("Directory for photo is created!");
									} else {
										System.out
												.println("Failed to create directory for file!");
									}
								}
								uploadDir = UPLOAD_DIRECTORY_PHOTO
										+ File.separator + fieldvalue;
							} else {
								File file = new File(UPLOAD_DIRECTORY_FILES
										+ File.separator + fieldvalue);
								if (!file.exists()) {
									if (file.mkdir()) {
										System.out
												.println("Directory for files is created!");
									} else {
										System.out
												.println("Failed to create directory for file!");
									}
								}
								uploadDir = UPLOAD_DIRECTORY_FILES
										+ File.separator + fieldvalue;
							}
						} else if (fieldname.equals("childKey")) {
							childKey = Integer.parseInt(fieldvalue);
							System.out.println("File tried to upload for file" + childKey);
						} else if (fieldname.equals("childFiscal")) {
							childFiscal = Integer.parseInt(fieldvalue);
						} else if (fieldname.equals("docType")) {
							docType = Integer.parseInt(fieldvalue);
						} else if (fieldname.equals("docName")) {
							docName = fieldvalue;
						}
					}
					else
						System.out.println(item.getName());
				}

				for (FileItem item : multiparts) {
					if (!item.isFormField()) {
						String name = new File(item.getName()).getName();
						File fileToWrite = new File(uploadDir + File.separator
								+ name);
						if (fileToWrite.exists())
							throw new FileAlreadyExistsException(
									"Please upload with original file name like geo20_01_2014");
						else
							item.write(fileToWrite);
						// save file name into database
						fileName = name;
						System.out.println(fileName);

						LOGGER.info("Status of photo : " + STRATEGY_TO_PHOTO);

						if (STRATEGY_TO_PHOTO) {
							// inserting into db
							ChildPhotos childPhoto = new ChildPhotos();
							childPhoto.setActive(1);
							// for setting current date
							Date date = new Date();
							childPhoto.setLast_modified_on(date.getDate() + "-"
									+ date.getMonth() + "-" + date.getYear());

							childPhoto.setPhoto_path(fileName);
							childPhoto.setChild_fk(childKey);
							childPhoto.setFiscal_year_fk(childFiscal);
							childPhoto.setLast_modified_by_fk(staffDetails
									.getStaff_pk());
							dataManager.insertChildPhoto(childPhoto);

							// File uploaded successfully
							request.setAttribute(
									"message",
									"Photo Uploaded Successfully "
											+ childPhoto.getPhoto_path());

							uploadSuccessful = true;
						} else {
							// inserting into db
							ChildDocuments childDocument = new ChildDocuments();
							childDocument.setActive_fk(1);
							// for setting current date
							Date date = new Date();
							childDocument.setLast_modified_on(date.getDate()
									+ "-" + date.getMonth() + "-"
									+ date.getYear());
							childDocument.setName(docName);
							childDocument.setPath(fileName);
							childDocument.setChild_fk(childKey);
							childDocument.setType_fk(docType);
							childDocument.setFiscal_year_fk(childFiscal);
							childDocument.setLast_modified_by_fk(staffDetails
									.getStaff_pk());
							dataManager.insertChildDocument(childDocument);

							// File uploaded successfully
							request.setAttribute("message",
									"File Uploaded Successfully "
											+ childDocument.getPath());
							uploadSuccessful = true;

							// revert back to set photo upload to default
							STRATEGY_TO_PHOTO = true;
						}
					}
				}

			} catch (Exception ex) {
				request.setAttribute("message", "Photo Upload Failed due to "
						+ ex);
				System.out.println(ex.getMessage());
			}

		} else {
			request.setAttribute("message",
					"Sorry this Servlet only handles file upload request");
		}

		if (!uploadSuccessful)
		{
			request.setAttribute("childKey", childKey);
			request.setAttribute("uploadStatus", "failed");
			request.setAttribute("childFiscal", childFiscal);
			request.getRequestDispatcher("/jsp/UploadStatus.jsp").forward(
					request, response);
		}
		else {
			// to send the request to another servlet
			// System.out.println("UploadServlet " +
			// "/home?action=childDetails&childId=" + childKey + "&childFiscal="
			// + childFiscal);
			request.setAttribute("childKey", childKey);
			request.setAttribute("uploadStatus", "passed");
			request.setAttribute("childFiscal", childFiscal);
			request.getRequestDispatcher("/jsp/UploadStatus.jsp").forward(
					request, response);
		}

	}
}