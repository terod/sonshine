<%@page import="sonshine.beans.FinanceSponsorAmount"%>
<%@page import="sonshine.beans.FinanceExpenseAmount"%>
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
<link href="css/styles.css" rel="stylesheet" type="text/css" />
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
			<div class="w">
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

					//get sponsors list
					ArrayList<VChildSponsorDetails> sponsorDetails = dataManager
							.getChildSponsorListByIdAndFiscal(childKey, childFiscal);
					
					//get month list
					HashMap<Integer, String> monthsMap = dataManager
							.getMonths();
					Set<Integer> monthIdSet = monthsMap.keySet();
					Iterator<Integer> monthsIDs = monthIdSet.iterator();
					//
					
			%>
			<h1><%=childNameString%>'s new sponsor amount Details
			</h1>
			<form class="form-inline well">
			<div class="form-group">
				<label for="amount">Amount:</label>
				<input class="form-control" type="text" name="amount" id="amount"/>
				<label for="month">Month: </label>
				<select class="form-control"  name="month" id="month">
					<%
						while (monthsIDs.hasNext()) {
								int monthId = monthsIDs.next();
								out.println("<option value=\"" + monthId + "\">"
										+ monthsMap.get(monthId) + "</option>");
							}
					%>

				</select>
				<label for="sponsorName">SponsorName: </label>
				<select class="form-control" name="sponsorName" id="sponsorName">
					<%
						for(VChildSponsorDetails childSponsorDetail : sponsorDetails) {
								out.println("<option value=\"" + childSponsorDetail.getSponsor_details_pk() + "\">"
										+ childSponsorDetail.getName() + "</option>");
							}
					%>

				</select>
				<input type="hidden" name="submitted" value="true" />
				<input type="hidden" name="action" value="childFinanceSponsor" />
				<input type="hidden" id="childKey" name="childKey" value="<%=childKey%>" /> 
				<input type="hidden" id="childFiscal" name="childFiscal" value="<%=childFiscal%>" />
				<input type="hidden" id="childName" name="childName" value="<%=childNameString%>" />
				</div> &nbsp;
				<div class="form-group">
				<button type="submit" class="btn btn-info" >Submit</button>
				</div>
			</form>
		</div>
		<%
		session.setAttribute("allowOneSubmit", true);
			}

			else {
				boolean fetchAllowOneSubmit = (Boolean)session.getAttribute("allowOneSubmit");
				if(fetchAllowOneSubmit == true)
				{
					boolean insertionPassed = false;
					String sponsorName="";
					String month = "";
					String amount = "";
					FinanceSponsorAmount sponsorAmount = new FinanceSponsorAmount();
					try{
					session.setAttribute("allowOneSubmit", false);
					//settting  and inserting sponsor details
					amount = (String) request.getParameter("amount");
					month = (String) request.getParameter("month");
					sponsorName = (String) request.getParameter("sponsorName");
					
					
					sponsorAmount.setChild_fk(childKey);
					sponsorAmount.setFiscal_year_fk(childFiscal);
					sponsorAmount.setMonth_fk(Integer.parseInt(month));
					sponsorAmount.setSponsor_amount(Float.parseFloat(amount));
					sponsorAmount.setSponsor_person_fk(Integer.parseInt(sponsorName));
					}
					catch(Exception e){
						insertionPassed = false;
						
					}
					
					insertionPassed = dataManager.insertFinanceSponsorDetails(sponsorAmount);
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
</body>
</html>