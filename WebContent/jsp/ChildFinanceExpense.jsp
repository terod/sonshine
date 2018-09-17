<%@page session="true" import="sonshine.model.DataManager"%>
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
			<h1><%=childNameString%>'s new expense amount Details
			</h1>
			<form class="form-inline well">
				<label for="type">Type of expense:</label>
				<input class="form-control" type="text" name="type" id="type"/>
				<label for="month">Month: </label>
				<select class="form-control" name="month" id="month">
					<%
						while (monthsIDs.hasNext()) {
								int monthId = monthsIDs.next();
								out.println("<option value=\"" + monthId + "\">"
										+ monthsMap.get(monthId) + "</option>");
							}
					%>

				</select>
				<label for="amount">Amount:</label>
				<input class="form-control" type="text" name="amount" id="amount"/>
				
				<input type="hidden" name="submitted" value="true" />
				<input type="hidden" name="action" value="childFinanceExpense" />
				<input type="hidden" id="childKey" name="childKey" value="<%=childKey%>" /> 
				<input type="hidden" id="childFiscal" name="childFiscal" value="<%=childFiscal%>" />
				<input type="hidden" id="childName" name="childName" value="<%=childNameString%>" />
				<button type="submit" class="btn btn-info" >Submit</button>
				
			</form>
	
		<%
		session.setAttribute("allowOneSubmit", true);
			}

			else {
				boolean fetchAllowOneSubmit = (Boolean)session.getAttribute("allowOneSubmit");
				if(fetchAllowOneSubmit == true)
				{
					boolean insertionPassed = false;
					FinanceExpenseAmount expenseAmount = new FinanceExpenseAmount();
					try{
					session.setAttribute("allowOneSubmit", false);
					//settting  and inserting sponsor details
					String amount = (String) request.getParameter("amount");
					String month = (String) request.getParameter("month");
					String type = (String) request.getParameter("type");
					
					
					expenseAmount.setChild_fk(childKey);
					expenseAmount.setFiscal_year_fk(childFiscal);
					expenseAmount.setMonth_fk(Integer.parseInt(month));
					expenseAmount.setAmount(Float.parseFloat(amount));
					expenseAmount.setExpense_name(type);
					}
					catch(Exception e){
						insertionPassed = false;
					}
					
					insertionPassed = dataManager.insertFinanceExpenseDetails(expenseAmount);
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
			<!-- closing tag of col -->

		</div>
		<!-- closing tag of row -->
	</div>
	<!-- closing tag of container -->
	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>