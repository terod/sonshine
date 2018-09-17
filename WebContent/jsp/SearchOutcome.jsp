<%@page session="true" import="sonshine.model.DataManager"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="sonshine.beans.VSearchOutcomeChild"%>
<%@page language="java" contentType="text/html"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="sonshine.beans.Child"%>
<jsp:useBean id="dataManager" scope="application"
	class="sonshine.model.DataManager" />
<%
	String base = (String) application.getAttribute("base");
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
					String keyword = request.getParameter("keyword");
					if (keyword != null && !keyword.trim().equals("")) {
				%>

				<h3 class="pull-right">Search results</h3>


				<table class="table">
					<tr>
						<th>ID</th>
						<th>Program</th>
						<th>Name</th>
						<th>Fiscal Year</th>
					</tr>

					<%
						ArrayList<VSearchOutcomeChild> childList = dataManager
									.getSearchResults(keyword);
							Iterator<VSearchOutcomeChild> iterator = childList.iterator();
							while (iterator.hasNext()) {
								VSearchOutcomeChild child = (VSearchOutcomeChild) iterator
										.next();

								//fiscalyear for child
								HashMap<Integer, String[]> childFiscalYears = child
										.getFiscal_years_map();
								Set<Integer> childFiscalYearSet = childFiscalYears.keySet();
								Iterator<Integer> childFiscalYearIDs = childFiscalYearSet
										.iterator();

								int pKey = child.getChild_key();
					%>

					<tr>
						<td><%=child.getChild_id()%></td>
						<td><%=childFiscalYears.get(childFiscalYearSet.toArray()[0])[1]%></td>
						<td><%=child.getName()%></td>
						<td>
							<div class="dropdown">
								<button class="btn btn-default dropdown-toggle" type="button"
									id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
									Select Fiscal Year&nbsp;<span class="caret"></span>
								</button>
								<ul class="dropdown-menu" role="menu"
									aria-labelledby="dropdownMenu1">
									<%
										while (childFiscalYearIDs.hasNext()) {
													int childFiscalYearId = childFiscalYearIDs.next();
													out.println("<li role=\"presentation\"><a role=\"menuitem\" tabindex=\"-1\" href=\""
															+ base
															+ "?action=childDetails&childFiscal="
															+ childFiscalYearId
															+ "&childKey="
															+ child.getChild_key()
															+ "#home\">"
															+ childFiscalYears.get(childFiscalYearId)[0]
															+ "</a></li>");
												}
									%>
								</ul>
							</div>

						</td>
						<%--<td><a class="link1"
              href="<%=base%>?action=childDetails&childId=<%=pId%>">
		      Details</a></td> --%>
					</tr>

					<%
						}
					%>
				</table>
				<%
					} else {
				%><p class="error">Invalid search keyword!</p>
				<%
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
