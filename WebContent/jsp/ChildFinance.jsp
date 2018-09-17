<%@page import="java.util.Hashtable"%>
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
<title>Welcome</title>
<link rel="stylesheet" href="/sonshine/css/sonshine.css" type="text/css" />
</head>
<body>
	<jsp:include page="TopMenu.jsp" flush="true" />
	<jsp:include page="LeftMenu.jsp" flush="true" />

	<div class="content">
		<%
			String childKeyString = (String) request.getParameter("childKey");
			String childFiscalString = (String) request
					.getParameter("childFiscal");
			String childNameString = (String) request.getParameter("childName");
			int childKey = 0;
			int childFiscal = 0;

			if (childKeyString == null || childFiscalString == null)
				throw new Exception("ChildKey or childFiscal year not reaching");
			else {
				childKey = (Integer.parseInt(childKeyString));
				childFiscal = (Integer.parseInt(childFiscalString));
			}

			//to get the child sponsors alone
			ArrayList<VChildSponsorDetails> childSponsorsDetailsList = dataManager
					.getChildSponsorListByIdAndFiscal(childKey, childFiscal);

			//to get the child sponsor amount alone
			ArrayList<VFinanceSponsorAmount> vFinanceSponsorAmountList = dataManager
					.getFinanceSponsorListByIdAndFiscal(childKey, childFiscal);

			//to get the expense amount
			ArrayList<VFinanceExpenseAmount> vFinanceExpenseAmountList = dataManager
					.getFinanceExpenseListByIdAndFiscal(childKey, childFiscal);

			//get fiscal years to show near name in heading
			Hashtable<Integer, String> fiscalYearMap = dataManager
					.getFiscalYears();
		%>
		<h1><%=childNameString%>'s Finance Details for the year
			<%=fiscalYearMap.get(childFiscal)%>
		</h1>
		<table>
			<tr>
				<th>Sponsor details</th>
				<th colspan="2"><form>
						<input type="submit" value="New Sponsor">
						<input type="hidden" id="childKey" name="childKey"
							value="<%=childKey%>" />
						<input type="hidden" id="childFiscal" name="childFiscal"
							value="<%=childFiscal%>" />
						<input type="hidden" id="action" name="action"
							value="childNewSponsor" />
						<input type="hidden" id="childName" name="childName"
							value="<%=childNameString%>" />
					</form>
					<form>
						<input type="submit" value="New Sponsor amount">
						<input type="hidden" id="childKey" name="childKey"
							value="<%=childKey%>" />
						<input type="hidden" id="childFiscal" name="childFiscal"
							value="<%=childFiscal%>" />
						<input type="hidden" id="action" name="action"
							value="childFinanceSponsor" />
						<input type="hidden" id="childName" name="childName"
							value="<%=childNameString%>" />
					</form></th>

			</tr>
			<tr>
				<td colspan="2">
					<%
						float sponsorSum = 0;
						if (childSponsorsDetailsList.size() == 0) {
							out.print("No sponsors present");
						} else {
					%>
					<table border="1">
						<tr class="subheading">
							<td>Sponsor Name</td>
							<td>Entry Date</td>
							<td>Exit Date</td>
							<td>Country</td>
							<td>Month</td>
							<td>Sponsor Amount</td>
						</tr>

						<%
							for (VChildSponsorDetails vChildSponsors : childSponsorsDetailsList) {
						%>
						<tr>

							<td><%=vChildSponsors.getName()%></td>
							<td><%=vChildSponsors.getEntry_date()%></td>
							<td><%=vChildSponsors.getExit_date()%></td>
							<td><%=vChildSponsors.getCountry()%></td>
							<td colspan='2'><table>

									<%
										boolean foundAtleastOneSponsoramount = false;
												for (VFinanceSponsorAmount sponsorAmount : vFinanceSponsorAmountList) {
									%>

									<%
										if (vChildSponsors.getName().equals(
															sponsorAmount.getSponsor_person())) {
														out.print("<tr><td>" + sponsorAmount.getMonth()
																+ "</td><td> "
																+ sponsorAmount.getSponsor_amount()
																+ "</td></tr>");
														sponsorSum = sponsorSum
																+ sponsorAmount.getSponsor_amount();
														foundAtleastOneSponsoramount = true;
													}
												}
												if (!foundAtleastOneSponsoramount)
													out.print("<tr><td>No sponsor made by "
															+ vChildSponsors.getName() + "</td></tr>");
									%>
								</table></td>
						</tr>
						<%
							}
						%>

						<tr>
							<td colspan="5" style="font-weight: bold;">Total Sponsor
								amount this year:</td>
							<td><%=sponsorSum%></td>
						</tr>
					</table> <%
 	}
 %>

				</td>
			</tr>
		</table>
		<br />
		<table>
			<tr>
				<th>Expense details</th>
				<th><form>
						<input type="submit" value="New Expense">
						<input type="hidden" id="childKey" name="childKey"
							value="<%=childKey%>" />
						<input type="hidden" id="childFiscal" name="childFiscal"
							value="<%=childFiscal%>" />
						<input type="hidden" id="action" name="action"
							value="childFinanceExpense" />
						<input type="hidden" id="childName" name="childName"
							value="<%=childNameString%>" />
					</form></th>
			</tr>
			<tr>
				<td colspan="2">
					<%
						float expenseSum = 0;
						if (vFinanceExpenseAmountList.size() == 0) {
							out.print("No Expense  present");
						} else {
					%>
					<table border="1">
						<tr class="subheading">
							<td>No.</td>
							<td>Month</td>
							<td>Expense name</td>
							<td>Amount</td>
						</tr>
						<%
							int no = 1;
								for (VFinanceExpenseAmount financeExpenseAmount : vFinanceExpenseAmountList) {
									expenseSum = expenseSum + financeExpenseAmount.getAmount();
						%>
						<tr>
							<td><%=no%></td>
							<td><%=financeExpenseAmount.getMonth()%></td>
							<td><%=financeExpenseAmount.getExpense_name()%></td>
							<td><%=financeExpenseAmount.getAmount()%></td>
						</tr>
						<%
							no++;
								}
						%>
						<tr>
							<td colspan="3" style="font-weight: bold;">Total Expense
								this year:</td>
							<td><%=expenseSum%></td>
						</tr>
						<%
							}
						%>
					</table>
				</td>

			</tr>
		</table>
		</br>
		<table>
			<tr>
				<th>Total money remaining: <%=sponsorSum - expenseSum%></th>
			</tr>
		</table>
	</div>
</body>
</html>
