<%@page import="sonshine.beans.ChildSponsorDetails"%>
<%@page import="sonshine.model.DataManager"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="sonshine.beans.VFinanceExpenseAmount"%>
<%@page import="sonshine.beans.VFinanceSponsorAmount"%>
<%@page import="sonshine.beans.VChildSponsorDetails"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sonshine.beans.ChildView"%>
<jsp:useBean id="dataManager" scope="application"
	class="sonshine.model.DataManager" />
<%@page session="true" import="sonshine.model.DataManager"%>
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
<link rel="stylesheet" type="text/css" href="css/jquery-ui.css" />
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
				<div class="well">
			<%
				String childKeyString = (String) request.getParameter("childKey");
				String childFiscalString = (String) request
						.getParameter("childFiscal");
				String childNameString = (String) request.getParameter("childName");
				String base = (String) application.getAttribute("base");

				int childKey = 0;
				int childFiscal = 0;
				if (childKeyString == null || childFiscalString == null)
					throw new Exception(
							"ChildKey or childFiscal year not reaching");
				else {
					childKey = (Integer.parseInt(childKeyString));
					childFiscal = (Integer.parseInt(childFiscalString));
				}

				//switch to avoid multiple submissions
				String submitted = (String) request.getParameter("submitted");
				boolean allowOneSubmit = false;
				if (submitted == null || submitted.equals("")) {

					//get country
					HashMap<Integer, String> countriesMap = dataManager
							.getCountries();
					Set<Integer> countrieIdSet = countriesMap.keySet();
					Iterator<Integer> countriesIDs = countrieIdSet.iterator();
			%>
			<h1><%=childNameString%>'s new Sponsor Details
			</h1>
			<form class="form">
				<div class="form-group">
				<label for="newSponsorName">Name:</label>
				<input class="form-control" type="text" name="newSponsorName" />
				<label for="startDate">Start Date: </label>
				<input class="form-control" type="text" name="startDate" id="startDate" />
				<label for="endDate">End Date: </label>
				<input class="form-control" type="text" name="endDate" id="endDate" />
				<label for="country">Country: </label>
				<select class="form-control" name="country">
					<%
						while (countriesIDs.hasNext()) {
								int countrieId = countriesIDs.next();
								out.println("<option value=\"" + countrieId + "\">"
										+ countriesMap.get(countrieId) + "</option>");
							}
					%>

				</select>
				<input type="hidden" name="submitted" value="true" />
				<input type="hidden" name="action" value="childNewSponsor" />
				<input type="hidden" id="childKey" name="childKey" value="<%=childKey%>" /> 
				<input type="hidden" id="childFiscal" name="childFiscal" value="<%=childFiscal%>" />
				<input type="hidden" id="childName" name="childName" value="<%=childNameString%>" />
				</div>
				<button type="submit" class="btn btn-info" >Submit</button>
				
			</form>
		</div>
		<%
		session.setAttribute("allowOneSubmit", true);
			}

			else {
				boolean fetchAllowOneSubmit = (Boolean)session.getAttribute("allowOneSubmit");
				if(fetchAllowOneSubmit == true)
				{
					session.setAttribute("allowOneSubmit", false);
					//settting  and inserting sponsor details
					String country = (String) request.getParameter("country");
					String startDate = (String) request.getParameter("startDate");
					String endDate = (String) request.getParameter("endDate");
					String sponsorName = (String) request.getParameter("newSponsorName");
					
					ChildSponsorDetails sponsorDetails = new ChildSponsorDetails();
					sponsorDetails.setActive_fk(1);
					sponsorDetails.setChild_fk(childKey);
					sponsorDetails.setFiscal_year_fk(childFiscal);
					sponsorDetails.setCountry_fk(Integer.parseInt(country));
					sponsorDetails.setEntry_date(startDate);
					sponsorDetails.setExit_date(endDate);
					sponsorDetails.setName(sponsorName);
					boolean insertionPassed = false;
					insertionPassed = dataManager.insertChildSponsorDetails(sponsorDetails);
					if(insertionPassed){
						%>
						<div class="alert alert-success" role="alert">
						New Sponsor successfully added! <a
							href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscal%>&childName=<%=childNameString%>">Click
							here to return</a>
						</div>
						<%
					}
					else { %> 
					<div class="alert alert-danger" role="alert">
						New Sponsor could not be added! <a
							href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscal%>&childName=<%=childNameString%>">Click
							here to return</a>
						</div>
					<%
					}
				}
				else
				{ %>
				<div class="alert alert-warning" role="alert">
						New Sponsor already added! <a
							href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscal%>&childName=<%=childNameString%>">Click
							here to return</a>
						</div>
				
				<%
					
					
				}
			}
		%>
	</div>
			</div>
			<!-- closing tag of col -->

		</div>
		<!-- closing tag of row -->
	</div>
	<!-- closing tag of container -->
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="/sonshine/css/jquery-1.10.2.js"></script>
	<script src="/sonshine/css/jquery-ui.js"></script>
	<script>
		$(function() {
			$("#startDate").datepicker({
				dateFormat : 'dd-mm-yy'
			});
			$("#endDate").datepicker({
				dateFormat : 'dd-mm-yy'
			});
		});
	</script>
</body>
</html>