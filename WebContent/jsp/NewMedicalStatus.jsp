<%@page session="true" import="sonshine.model.DataManager"%>
<%@page import="org.apache.commons.lang3.exception.ExceptionUtils"%>
<%@page import="sonshine.beans.ChildMedical"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>New Medical information</title>
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

			<div class="col-md-10 col-xs-12">
				<div class="well">
					<%
						if (request.getParameter("submitted") != null && session.getAttribute("NewProgramSubmitted") == null) {													
													//to avoid duplication submission by refresh mistake
													session.setAttribute("NewProgramSubmitted", "true");
													
																															String medCheckDate = request.getParameter("medCheckDate");
																															String medTreatment = request.getParameter("medTreatment");
																															String medDetails = request.getParameter("medDetails");
																															int insertedRecordValue = 0;

																															//setting the one who modified each table
																															String user_name = sonshine.utils.HTMLFilter.filter(request
																																	.getRemoteUser());
																															VNlchStaffDetails staffDetails = dataManager
																																	.getStaffDetailsByUserName(user_name);

																															ChildMedical childMedical = new ChildMedical();
																															childMedical.setCheckup_date(medCheckDate);
																															childMedical.setChild_fk(Integer.parseInt(childKey));
																															childMedical.setDetails(medDetails);
																															childMedical.setFiscal_year_fk(Integer
																																	.parseInt(childFiscalKey));
																															childMedical.setLast_modified_by_fk(staffDetails
																																	.getStaff_pk());
																															childMedical.setTreatment(medTreatment);

																															insertedRecordValue = dataManager
																																	.insertNewMedicalInformation(childMedical);

																															if (insertedRecordValue > 0) {
					%>
					<div class="alert alert-success" role="alert">
						New medical record successfully added! <a
							href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscalKey%>&childName=<%=childName%>">Click
							here to return</a>
					</div>
					<%
						} else {
					%>
					<div class="alert alert-danger" role="alert">
						New medical record insertion failed! <a
							href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscalKey%>&childName=<%=childName%>">Click
							here to return</a>
					</div>
					<%
						}																				
													}
												else if(request.getParameter("submitted") != null && session.getAttribute("NewProgramSubmitted") != null){
					%>
					<div class="alert alert-warning" role="alert">
						Insertion already done! <a
							href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscalKey%>&childName=<%=childName%>">Click
							here to return</a>
					</div>
					<%
						}
												else {
													
													//to avoid duplication submission by refresh mistake
													session.removeAttribute("NewProgramSubmitted");
													
														out.println("<h3>Add new medical information here</h3>");
														VChildProgram childProgram = dataManager
																.getChildProgramById(Integer.parseInt(childKey));

														//student status
														HashMap<Integer, String> studentStatuss = dataManager
																.getStudentStatuss();
														Set<Integer> studentStatusIdSet = studentStatuss.keySet();
														Iterator<Integer> studentStatusIDs = studentStatusIdSet
																.iterator();
					%>
					<form class="form-horizontal" action="">

						<div class="form-group">
							<label class="col-md-2 control-label" for="medCheckDate">Health
								Check up date: </label>
							<div class="col-md-3">
								<input class="form-control" type="text" id="medCheckDate"
									name="medCheckDate"> </input>
							</div>
							<label class="col-md-4 control-label" for="medTreatment">Medical
								Treatment if any: </label>
							<div class="col-md-3">
								<input class="form-control" type="text" id="medTreatment"
									name="medTreatment"> </input>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label" for="medDetails">Details:
							</label>
							<div class="col-md-10">
								<textarea class="form-control" id="medDetails" name="medDetails"
									rows="3"></textarea>
							</div>

							<input type="hidden" id="action" name="action" value="newMedical"></input>
							<input type="hidden" id="childFiscal" name="childFiscal"
								value="<%=childFiscalKey%>" /> <input type="hidden"
								id="childKey" name="childKey" value="<%=childKey%>" /> <input
								type="hidden" id="submitted" name="submitted" value="true" />
						</div>
						<button class="col-md-2 btn btn-info pull-right" type="submit">Submit</button>
					</form>
					<%
						}
					%>
					<%
						} catch (Exception e) {
																									Logger LOGGER = Logger.getLogger("ERROR");
																									System.out.println("Data not showing due to some problem " + e);
																									LOGGER.error(ExceptionUtils.getStackTrace(e));
																								}
					%>
				</div>
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
			$("#medCheckDate").datepicker({
				dateFormat : 'dd-mm-yy'
			});
		});
	</script>
</body>
</html>