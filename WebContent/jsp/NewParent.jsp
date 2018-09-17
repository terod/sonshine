<%@page import="java.util.ArrayList"%>
<%@page import="sonshine.beans.ChildParents"%>
<%@page session="true" import="sonshine.model.DataManager"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="sonshine.beans.VNlchStaffDetails"%>
<%@page import="sonshine.beans.ChildProgram"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="sonshine.beans.VChildProgram"%>
<jsp:useBean id="dataManager" scope="application"
	class="sonshine.model.DataManager" />
<%
	try {
		String base = (String) application.getAttribute("base");
		String childKey = request.getParameter("childKey");
		String childFiscalKey = request.getParameter("childFiscal");
		String childName = request.getParameter("childName");
%>
<%
	//populating fields

		//getting parent status
		HashMap<Integer, String> parentStatus = dataManager
				.getParentStatus();
		Set<Integer> parentStatusIdSet = parentStatus.keySet();
		Iterator<Integer> parentStatusIDs1 = parentStatusIdSet
				.iterator();
		
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Welcome to Sonshine</title>
<link rel="stylesheet" href="/sonshine/css/sonshine.css" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link href="css/styles.css" rel="stylesheet" />
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>
<body>
	<div class="container">
		<jsp:include page="TopMenu.jsp" flush="true" />
		<div class="row">

			<div class="col-md-2 col-xs-12">
				<jsp:include page="LeftMenu.jsp" flush="true" />
			</div>

			<div class="col-md-10 col-xs-12">


				<%
					if (request.getParameter("submitted") != null
								&& session.getAttribute("NewParentSubmitted") == null) {

							//to avoid duplication submission by refresh mistake
							session.setAttribute("NewParentSubmitted", "true");

							
							String parentType = request.getParameter("parentType");
							String parentOccup = request.getParameter("parentOccup");
							String parentName = request.getParameter("parentName");
							String parentStatusKey = request.getParameter("parentStatus");
							int insertedRecordValue = 0;

							//setting the one who modified each table
							String user_name = sonshine.utils.HTMLFilter.filter(request
									.getRemoteUser());
							VNlchStaffDetails staffDetails = dataManager
									.getStaffDetailsByUserName(user_name);

							ChildParents childParents = new ChildParents();
							childParents.setChild_fk(Integer.parseInt(childKey));
							childParents.setFiscal_year_fk(Integer.parseInt(childFiscalKey));
							childParents.setLast_modified_by_fk(staffDetails.getStaff_pk());
							childParents.setOccupation(parentOccup);
							childParents.setStatus_fk(Integer.parseInt(parentStatusKey));
							childParents.setName(parentName);
							childParents.setType(parentType);
							childParents.setActive(1);
							ArrayList<ChildParents> childParentsArrayList = new ArrayList<ChildParents>();
							childParentsArrayList.add(childParents);
							
							insertedRecordValue = dataManager
									.insertNewParent(childParentsArrayList);

							if (insertedRecordValue > 0) {
				%>
				<div class="alert alert-success" role="alert">
					Program update successful! <a
						href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscalKey%>&childName=<%=childName%>">Click
						here to return</a>
				</div>
				<%
					} else {
				%>
				<div class="alert alert-danger" role="alert">
					Program update failed! <a
						href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscalKey%>&childName=<%=childName%>">Click
						here to return</a>
				</div>
				<%
					}

						} else if (request.getParameter("submitted") != null
								&& session.getAttribute("NewParentSubmitted") != null) {
				%>
				<div class="alert alert-warning" role="alert">
					Update already done! <a
						href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscalKey%>&childName=<%=childName%>">Click
						here to return</a>
				</div>
				<%
					}

						else {

							//to avoid duplication submission by refresh mistake
							session.removeAttribute("NewParentSubmitted");

							out.println("<h3>Add new parent of child here</h3>");
				%>

				<form class="form-inline well" action="">
					<div class="form-group">
						<label for="parentName">Name: </label> <input class="form-control"
							type="text" name="parentName" id="parentName" /> <label
							for="parentStatus">Status: </label> <select class="form-control"
							name="parentStatus" id="parentStatus">
							<%
								while (parentStatusIDs1.hasNext()) {
											int parentStatusId = parentStatusIDs1.next();
											out.println("<option value=\"" + parentStatusId + "\">"
													+ parentStatus.get(parentStatusId)
													+ "</option>");
										}
							%>
						</select> <label for="parentStatus">Occupation: </label> <input
							class="form-control" type="text" name="parentOccup"
							id="parentOccup" /> <label for="parentType">Type:
						</label> <select class="form-control" name="parentType" id="parentType">
							<option value="Father">Father</option>
							<option value="Mother">Mother</option>
							<option value="Guardian">Guardian</option>
						</select> <input type="hidden" id="action" name="action" value="newParent" />
						<input type="hidden" id="childKey" name="childKey"
							value="<%=childKey%>" /> <input type="hidden" id="childFiscal"
							name="childFiscal" value="<%=childFiscalKey%>" /> <input
							type="hidden" id="submitted" name="submitted" value="true" /> 
					</div>
					<br />
					<button class="btn btn-info pull-right" type="submit">Submit</button>
				</form>

				<%
					}
				%>
				<%
					} catch (Exception e) {
						Logger LOGGER = Logger.getLogger("ERROR");
						System.out.println("Data not showing due to some problem " + e);
						LOGGER.error("Data not showing due to some problem " + e);
					}
				%>

			</div>
			<!-- closing tag of col -->

		</div>
		<!-- closing tag of row -->
	</div>
	<!-- closing tag of container -->
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>