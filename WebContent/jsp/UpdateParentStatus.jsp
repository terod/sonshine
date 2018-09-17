<%@page import="sonshine.beans.ChildParents"%>
<%@page import="sonshine.beans.VChildParents"%>
<%@page import="java.util.ArrayList"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
Logger logger = Logger.getLogger("ChildDetails.jsp:");

	try {
		String base = (String) application.getAttribute("base");
		String childKey = request.getParameter("childKey");
		String childFiscalKey = request.getParameter("childFiscal");
		String childName = request.getParameter("childName");
		String parentKey = request.getParameter("parentKey");
		//System.out.println("Parent key " + parentKey);

		//getting parent status
		HashMap<Integer, String> parentStatus = dataManager
				.getParentStatus();
		Set<Integer> parentStatusIdSet = parentStatus.keySet();
		Iterator<Integer> parentStatusIDs1 = parentStatusIdSet
				.iterator();
%>
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
								&& session.getAttribute("NewParentStatusSubmitted") == null) {
							
							//System.out.println("Entering submitting place");
							//to avoid duplication submission by refresh mistake
							session.setAttribute("NewParentStatusSubmitted", "true");

							
							int insertedRecordValue = 0;
							String parentName = request.getParameter("parentName");
							String parentOccup = request.getParameter("parentOccup");
							String parentType = request.getParameter("parentType");
							String parentStatusKey = request.getParameter("parentStatus");

							//setting the one who modified each table
							String user_name = sonshine.utils.HTMLFilter.filter(request
									.getRemoteUser());
							VNlchStaffDetails staffDetails = dataManager
									.getStaffDetailsByUserName(user_name);

							ChildParents childParent = new ChildParents();
							childParent.setChild_fk(Integer.parseInt(childKey));
							childParent.setFiscal_year_fk(Integer.parseInt(childFiscalKey));
							childParent.setLast_modified_by_fk(staffDetails.getStaff_pk());
							childParent.setName(parentName);
							childParent.setOccupation(parentOccup);
							childParent.setStatus_fk(Integer.parseInt(parentStatusKey));
							childParent.setType(parentType);
							childParent.setActive(1);
							childParent.setParent_pk(Integer.parseInt(parentKey));
							//System.out.println("Hello world");
							//logger.info("Parent update executing");
							insertedRecordValue = dataManager
									.doParentStatusUpdate(childParent);

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
								&& session.getAttribute("NewParentStatusSubmitted") != null) {
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
							session.removeAttribute("NewParentStatusSubmitted");

							out.println("<h3>Update Parent status of child here</h3>");
							ArrayList<VChildParents> childParents = dataManager
									.getChildParentsListById(Integer.parseInt(childKey));

							//setting the current parent in context
							VChildParents parent = null;
							int parentKeyInt = Integer.parseInt(parentKey);
							for(VChildParents parent1 : childParents){
								if(parent1.getParent_pk() == parentKeyInt)
									parent = parent1;
							}
							
				%>

				
				<form class="form-inline well" action="">
					<div class="form-group">
						<label for="parentName">Name: </label> <input class="form-control"
							type="text" name="parentName" id="parentName" value="<%=parent.getName() %>" /> <label
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
							id="parentOccup" value="<%=parent.getOccupation() %>" /> <label for="parentType">Type: </label> <input
							class="form-control" type="text" name="parentType" id="parentType" value="<%=parent.getType()%>" >
						</input> <input type="hidden" id="action" name="action" value="updateParentStatus" />
						<input type="hidden" id="childKey" name="childKey"
							value="<%=childKey%>" /> <input type="hidden" id="childFiscal"
							name="childFiscal" value="<%=childFiscalKey%>" /><input type="hidden" id="parentKey"
							name="parentKey" value="<%=parent.getParent_pk()%>" /> <input
							type="hidden" id="submitted" name="submitted" value="true" />
							
					</div>
					<div class="form-group">
					
					</div>
					<button class="btn btn-info pull-right" type="submit">Submit</button>
					
				</form>

				<%
					}
				%>
				<%
	
					} catch (Exception e) {
						Logger LOGGER = Logger.getLogger("ERROR");
						e.printStackTrace();
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