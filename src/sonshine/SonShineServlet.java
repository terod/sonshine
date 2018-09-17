package sonshine;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import sonshine.model.DataManager;

public class SonShineServlet extends javax.servlet.http.HttpServlet implements
		javax.servlet.Servlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(SonShineServlet.class);
	public SonShineServlet() {
		super();
	}

	public void init(ServletConfig config) throws ServletException {
		System.out.println("*** initializing controller servlet.");
		super.init(config);

		DataManager dataManager = new DataManager();
		dataManager.setDbURL(config.getInitParameter("dbURL"));
		dataManager.setDbUserName(config.getInitParameter("dbUserName"));
		dataManager.setDbPassword(config.getInitParameter("dbPassword"));

		ServletContext context = config.getServletContext();
		context.setAttribute("base", config.getInitParameter("base"));
		context.setAttribute("imageURL", config.getInitParameter("imageURL"));
		context.setAttribute("storeFiles",
				config.getInitParameter("storeFiles"));
		context.setAttribute("storeImages",
				config.getInitParameter("storeImages"));
		context.setAttribute("fileUploadPath",
				config.getInitParameter("fileUploadPath"));
		context.setAttribute("dataManager", dataManager);

		try { // load the database JDBC driver
			Class.forName(config.getInitParameter("jdbcDriver"));
		} catch (ClassNotFoundException e) {
			System.out.println(e.toString());
		}
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String base = "/jsp/";
		String url = base + "index.jsp";
		String action = request.getParameter("action");
		//System.out.println("sonShineServlet : " + request.getParameter("childFiscal"));
		if (action != null) {
			switch (action) {
			case "newchild":
				url = base + "NewChild.jsp";
				break;
			case "continueNewChild":
				url = base + "ContinueNewChild.jsp";
				break;
			case "submitNewChild":
				url = base + "ChildCreated.jsp";
				break;
			case "search":
				url = base + "SearchOutcome.jsp";
				break;
			case "selectCatalog":
				url = base + "SelectCatalog.jsp";
				break;
			case "childDetails":
				url = base + "ChildDetails.jsp";
				break;
			case "uploadPhoto":
				url = base + "uploadPhoto.jsp";
				break;
			case "uploaded":
				url = base + "Uploaded.jsp";
				break;
			case "childFinance":
				url = base + "ChildFinance.jsp";
				break;
			case "childNewSponsor":
				url = base + "ChildNewSponsor.jsp";
				break;
			case "childFinanceSponsor":
				url = base + "ChildFinanceSponsor.jsp";
				break;
			case "childFinanceExpense":
				url = base + "ChildFinanceExpense.jsp";
				break;
			case "childNewFiscal":
				url = base + "NewFiscalForChild.jsp";
				break;
			case "NewChildForFiscal":
				url = base + "NewFiscalYearForChildCreated.jsp";
				//System.out.println("output url" + url);
				break;
			case "updateStatus":
				url = base + "UpdateNewStatus.jsp";
				break;
			case "newMedical":
				url = base + "NewMedicalStatus.jsp";
				break;
			case "newParent":
				url = base + "NewParent.jsp";
				break;
			case "newSibling":
				url = base + "NewSibling.jsp";
				break;
			case "updateParentStatus":
				url = base + "UpdateParentStatus.jsp";
				break;
			default:
				url = base + "index.jsp";
				break;
			}
		}
		//logger.info(url);
		RequestDispatcher requestDispatcher = getServletContext()
				.getRequestDispatcher(url);
		requestDispatcher.forward(request, response);
	}
}
