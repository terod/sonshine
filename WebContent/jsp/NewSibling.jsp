<%@page import="sonshine.beans.ChildSiblings"%>
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

		//yn
		HashMap<Integer, String> yn = dataManager.getYN();
		Set<Integer> ynIdSet = yn.keySet();
		Iterator<Integer> ynIDs1 = ynIdSet.iterator();
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
<link rel="stylesheet" type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/smoothness/jquery-ui.css" media="all" />
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

			<div class="col-md-6 col-xs-12">


				<%
					if (request.getParameter("submitted") != null
								&& session.getAttribute("NewProgramSubmitted") == null) {
							
							int insertedRecordValue = 0;
							ChildSiblings sibling = new ChildSiblings();
						
							//to avoid duplication submission by refresh mistake
							session.setAttribute("NewProgramSubmitted", "true");
							
							//setting the one who modified each table
							String user_name = sonshine.utils.HTMLFilter.filter(request
									.getRemoteUser());
							VNlchStaffDetails staffDetails = dataManager
									.getStaffDetailsByUserName(user_name);

							try{
							String siblingName = request.getParameter("siblingName");
							String siblingProg = request.getParameter("siblingProg");
							String siblingRef = request.getParameter("siblingRef");
							String siblingDob = request.getParameter("siblingDob");
							String siblingDetail = request.getParameter("siblingDetail");

							
							sibling.setChild_fk(Integer.parseInt(childKey));
							sibling.setFiscal_year_fk(Integer.parseInt(childFiscalKey));
							sibling.setName(siblingName);
							sibling.setDob(siblingDob);
							if(siblingRef.equals(""))
								sibling.setCurrent_program_fk(2);
							else
								sibling.setCurrent_program_fk(1);
							sibling.setRef_child_id(siblingRef);
							sibling.setDetails(siblingDetail);
							sibling.setLast_modified_by_fk(staffDetails.getStaff_pk());
							
									
							}catch(Exception e){
								e.printStackTrace();
							}
														
							insertedRecordValue = dataManager
									.insertNewSibling(sibling);
					
							if (insertedRecordValue > 0) {
				%>
				<div class="alert alert-success" role="alert">
					New Sibling added successfully! <a
						href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscalKey%>&childName=<%=childName%>">Click
						here to return</a>
				</div>
				<%
					} else {
				%>
				<div class="alert alert-danger" role="alert">
					New sibling could not be added! <a
						href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscalKey%>&childName=<%=childName%>">Click
						here to return</a>
				</div>
				<%
					}

						} else if (request.getParameter("submitted") != null
								&& session.getAttribute("NewProgramSubmitted") != null) {
				%>
				<div class="alert alert-warning" role="alert">
					Record already inserted! <a
						href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscalKey%>&childName=<%=childName%>">Click
						here to return</a>
				</div>
				<%
					}

						else {

							//to avoid duplication submission by refresh mistake
							session.removeAttribute("NewProgramSubmitted");

							out.println("<h3>Add new sibling of child here</h3>");
				%>

				<form class="form well" action="">
				<fieldset>
				<legend>If not part of nlch, fill this section</legend>
					<div class="form-group">
					
						<label for="parentName">Name: </label> <input class="form-control"
							type="text" name="siblingName" id="siblingName" />  <label for="siblingDob">DOB: </label> <input
							class="form-control" type="text" name="siblingDob"
							id="siblingDob" /> <label for="siblingDetail">Detail:
						</label>
						<input
							class="form-control" type="text" name="siblingDetail"
							id="siblingDetail" />
						
						</div>
						</fieldset>
						<fieldset>
				<legend>If part of nlch, fill this section</legend>
						<div class="form-group">
						<label for="siblingRef">Reference Id:
						</label>
						<input
							class="form-control" type="text" name="siblingRef"
							id="siblingRef" />
							</div>
						 <input type="hidden" id="action" name="action" value="newSibling" />
						<input type="hidden" id="childKey" name="childKey"
							value="<%=childKey%>" /> <input type="hidden" id="childFiscal"
							name="childFiscal" value="<%=childFiscalKey%>" /> <input
							type="hidden" id="submitted" name="submitted" value="true" /> 
					
					</fieldset>
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
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script>
		$(function() {
			$("#siblingDob").datepicker({
				dateFormat : 'dd-mm-yy'
			});
		});
	</script>
</body>
</html>