<%@page import="sonshine.beans.ChildView"%>
<%@page import="sonshine.model.DataManager"%>
<%@page language="java" contentType="text/html"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%
	String base = (String) application.getAttribute("base");
	final DataManager dataManager = (DataManager) application.getAttribute("dataManager");
	Integer childKeyObject = (Integer) session.getAttribute("childKey");
	int childKey = childKeyObject.intValue();
	Integer childFiscalObject = (Integer) session.getAttribute("childFiscal");
	int childFiscal = childFiscalObject.intValue();
	
	//for getting name
	ChildView child = (ChildView) session.getAttribute("childData");
%>
<div class="menu">
	<div class="box">
		<div class="title">Quick Search</div>
		<br />
		<p>Child's ID/Name:</p>
		<form style="border: 0px solid; padding: 0; margin: 0;">
			<input type="hidden" name="action" value="search" /> <input
				id="text" type="text" name="keyword" size="15" /> <input
				id="submit" type="submit" value="Search" />
		</form>
		<br />
		<form style="border: 0px solid; padding: 0; margin: 0;">
			<input type="hidden" name="action" value="newchild" /> <input
				type="submit" value="New Registration" />
		</form>
		<br />
		<form action="<%=base%>" style="border: 0px solid; padding: 0; margin: 0;">
			<input type="submit" value="Home" />
		</form>
	</div>


	<br/>
	<div class="box">
		<div class="title">Options</div>
		
		 
	  <br /> 	<p>Select fiscal year:</p>
		<form style="border: 0px solid; padding: 0; margin: 0;">
			<select name="childFiscal" id="select" style="font-size: 12px;
  padding: .2em;
  margin: .5em .8em .5em .8em;
  border: 1px #000000 solid;" >
				<%
					Hashtable<Integer, String> fiscalYears2 = dataManager
							.getFiscalYearsByChildId(childKey);
					//System.out.println("Test data is " + fiscalYears2.get(30));
					Enumeration<Integer> fiscalYearIds = fiscalYears2.keys();
					while (fiscalYearIds.hasMoreElements()) {
						Object fiscalYearId = fiscalYearIds.nextElement();
						out.println("<option value=\"" + fiscalYearId + "\">"
								+ fiscalYears2.get(fiscalYearId) + "</option>");
					}
				%>
			</select> <input type="hidden" name="childKey" value=<%=childKey%> /> <input
				type="hidden" name="action" value="childDetails" /><br/> <input
				id="submit" type="submit" value="Continue" />
		</form>
		<br />
		<form style="border: 0px solid; padding: 0; margin: 0;">
			<input type="submit" value="New fiscal year" /> <input type="hidden"
				name="childKey" value=<%=childKey%> /> <input type="hidden"
				name="action" value="childNewFiscal" />
		</form>
		<br />
		<form style="border: 0px solid; padding: 0; margin: 0;">
			<input type="submit" value="Sponsor & Expense sheet">
						<input type="hidden" id="childKey" name="childKey" value="<%=childKey%>" /> 
						<input type="hidden" id="childFiscal" name="childFiscal" value="<%=childFiscal%>" />
						<input type="hidden" id="action" name="action" value="childFinance" />
						<input type="hidden" id="childName" name="childName" value="<%=child.getName()%>" />
		</form>
	</div>
</div>