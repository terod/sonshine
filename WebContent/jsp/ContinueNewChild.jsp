<%@page
	import="java.util.ArrayList, java.util.Hashtable, java.util.Enumeration"%>
<%@page import="sonshine.beans.ChildIdentifyMarks"%>
<%@page import="sonshine.beans.ChildProgram"%>
<%@page import="sonshine.beans.Child"%>
<%@page import="sonshine.beans.Address"%>
<%@page session="true" import="sonshine.model.DataManager"%>
<%@page import="sonshine.model.DataManager"%>
<%@page import="java.util.Iterator,java.util.HashMap,java.util.Set"%>
<%

try{
	//to ensure NewChild is completed before this
if(request.getParameter("cid_1") == null || request.getParameter("cid_1").equals(""))
{
%>
<jsp:forward page="NewChild.jsp"></jsp:forward>
<%
	}

final DataManager dataManager = (DataManager) application.getAttribute("dataManager");


//fiscal years. Using hashtable to maintain order in the retrieved items
Hashtable<Integer,String> fiscalYears =  dataManager.getFiscalYears();
Enumeration<Integer> fiscalYearIDs = fiscalYears.keys();

//save data in bean for further reference
	String program = request.getParameter("program");
	String location = request.getParameter("location");
	String fyear = request.getParameter("fyear");
	String cstatus = request.getParameter("cstatus");
	String application_date = request.getParameter("application_date");
	String enrollment_date = request.getParameter("enrollment_date");
	String pc = request.getParameter("pc");
	String tongue = request.getParameter("tongue");
	String religion = request.getParameter("religion");
	String age = request.getParameter("age");
	String gender = request.getParameter("gender");
	String cid1 = request.getParameter("cid_1");
	String cid2 = request.getParameter("cid_2");
	String cid3 = request.getParameter("cid_3");
	String cid4 = request.getParameter("cid_4");
	String cid = cid1 + cid2 + cid3 + cid4;
	String cname = request.getParameter("cname");
	String dob = request.getParameter("dob");
	String pob = request.getParameter("pob");
	String im1 = request.getParameter("im1");
	String im2 = request.getParameter("im2");
	String im3 = request.getParameter("im3");
	String pd = request.getParameter("pd");
	String street = request.getParameter("street");
	String area = request.getParameter("area");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String country = request.getParameter("country");
	String zip = request.getParameter("zip");
	
	//bean instantiation
	Child child = new Child();
	Address childAddress = new Address();
	ChildProgram childProgram = new ChildProgram();
	
	
	//id marks array initialization
	ArrayList<ChildIdentifyMarks> childIdentifyMarks = new ArrayList<ChildIdentifyMarks>();
	
	//to ensure that only fields that are filled are saved into the arraylist
	if(im1 != "" && im1 != null)
	{
		ChildIdentifyMarks childNewIdentifyMark1 = new ChildIdentifyMarks();
		childNewIdentifyMark1.setMark(im1);
		childIdentifyMarks.add(childNewIdentifyMark1);
	}
	if(im2 != "" && im2 != null)
	{
		ChildIdentifyMarks childNewIdentifyMark2 = new ChildIdentifyMarks();
		childNewIdentifyMark2.setMark(im2);
		
		childIdentifyMarks.add(childNewIdentifyMark2);
	}
	if(im3 != "" && im3 != null)
	{
		ChildIdentifyMarks childNewIdentifyMark3 = new ChildIdentifyMarks();
		childNewIdentifyMark3.setMark(im3);
		childIdentifyMarks.add(childNewIdentifyMark3);
	}
	
	//setting values to address bean
	childAddress.setArea(area);
	childAddress.setCity_town(city);
	childAddress.setCountry(country);
	childAddress.setState(state);
	childAddress.setStreet(street);
	childAddress.setZip(zip);
		
	//setting values to child bean
	child.setChild_id(cid);
	child.setName(cname);
	child.setDob(dob);
	child.setPlace_of_birth(pob);
	child.setGender(Integer.parseInt(gender));
	child.setMother_tongue_fk(Integer.parseInt(tongue));
	child.setAge(Integer.parseInt(age));
	child.setPhysical_defects(pd);
	child.setReligion_fk(Integer.parseInt(religion));
	child.setEnrollment_date(enrollment_date);
	child.setApplication_date(application_date);
	
	//setting values to program bean
	childProgram.setActive(1);
	childProgram.setFiscal_year_fk(Integer.parseInt(fyear));
	childProgram.setLocation_fk(Integer.parseInt(location));
	childProgram.setPc_fk(Integer.parseInt(pc));
	childProgram.setTl_fk(Integer.parseInt(pc));
	childProgram.setStatus_fk(Integer.parseInt(cstatus));
	childProgram.setType_fk(Integer.parseInt(program));
	
	
	//setting attributes to servlet session
	session.setAttribute("childNew", child);
	session.setAttribute("childAddressNew", childAddress);
	session.setAttribute("childProgramNew", childProgram);
	session.setAttribute("childIdentifyMarksNew", childIdentifyMarks);
%>
<%
	//populating fields

//getting parent status
HashMap<Integer,String> parentStatus =  dataManager.getParentStatus();
  Set<Integer> parentStatusIdSet = parentStatus.keySet();
  Iterator<Integer> parentStatusIDs1 = parentStatusIdSet.iterator();
  Iterator<Integer> parentStatusIDs2 = parentStatusIdSet.iterator();
  //yn
  HashMap<Integer,String> yn =  dataManager.getYN();
  Set<Integer> ynIdSet = yn.keySet();
  Iterator<Integer> ynIDs1 = ynIdSet.iterator();
  Iterator<Integer> ynIDs2 = ynIdSet.iterator();
  Iterator<Integer> ynIDs3 = ynIdSet.iterator();
  Iterator<Integer> ynIDs4 = ynIdSet.iterator();
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
<link rel="stylesheet" type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/themes/smoothness/jquery-ui.css" media="all">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
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
			<div class="content">
				<div class="basic-grey">
			<h1>Complete the form and submit</h1>
			<form style="border: 0px solid; padding: 0; margin: 0;">
				<input type="hidden" name="action" value="submitNewChild" />
				<fieldset>
					<legend>Family</legend>
					<table style="margin-top: 10px;">
						<tr>
							<th>Family details</th>
							<th>Name</th>
							<th>Living Status</th>
							<th>Occupation</th>
						</tr>
						<tr>
							<td>Father</td>
							<td><input type="text" name="fatherName" id="fatherName" /></td>
							<td><select name="fatherStatus" id="fatherStatus"><% 
								    while (parentStatusIDs1.hasNext()) {
									      int parentStatusId = parentStatusIDs1.next();
									      out.println("<option value=\"" + parentStatusId + "\">" + 
									      parentStatus.get(parentStatusId) + "</option>");
									      }
										%> </select></td>
							<td><input type="text" name="fatherOccup" id="fatherOccup" /></td>
						</tr>
						<tr>
							<td>Mother</td>
							<td><input type="text" name="motherName" id="motherName" /></td>
							<td><select name="motherStatus" id="motherStatus"><%
								    while (parentStatusIDs2.hasNext()) {
									      int parentStatusId = parentStatusIDs2.next();
									      out.println("<option value=\"" + parentStatusId + "\">" + 
									      parentStatus.get(parentStatusId) + "</option>");
									      }
										%> </select></td>
							<td><input type="text" name="motherOccup" id="motherOccup" /></td>
						</tr>
						<tr>
							<td>Guardian</td>
							<td><input type="text" name="guardianName" id="guardianName" /></td>
							<td><input type="hidden" name="guardianStatus" id="guardianStatus" /></td>
							<td><input type="text" name="guardianOccup" id="guardianOccup" /></td>
						</tr>
					</table>
					<table style="margin-top: 10px;">
						<tr>
							<th>Sibling Information</th>
							<th>Name</th>
							<th>Age</th>
							<th>Is the sibling under any NLC program?</th>
							<th>If yes, details</th>
						</tr>
						<tr>
							<td>1</td>
							<td><input type="text" name="sib1Name" id="sib1Name" /></td>
							<td><input style="width: 30px;" type="text" name="sib1Age" id="sib1Age" /></td>
							<td><select name="sib1Program" id="sib1Program"><%
								    while (ynIDs1.hasNext()) {
									      int ynId = ynIDs1.next();
									      out.println("<option value=\"" + ynId + "\">" + 
									      yn.get(ynId) + "</option>");
									      }
										%></select></td>
							<td><input type="text" name="sib1Details" id="sib1Details" /></td>
						</tr>
						<tr>
							<td>2</td>
							<td><input type="text" name="sib2Name" id="sib2Name" /></td>
							<td><input style="width: 30px;" type="text" name="sib2Age" id="sib2Age" /></td>
							<td><select name="sib2Program" id="sib2Program"><%
								    while (ynIDs2.hasNext()) {
									      int ynId = ynIDs2.next();
									      out.println("<option value=\"" + ynId + "\">" + 
									      yn.get(ynId) + "</option>");
									      }
										%></select></td>
							<td><input type="text" name="sib2Details" id="sib2Details" /></td>
						</tr>
						<tr>
							<td>3</td>
							<td><input type="text" name="sib3Name" id="sib3Name" /></td>
							<td><input style="width: 30px;" type="text" name="sib3Age" id="sib3Age" /></td>
							<td><select name="sib3Program" id="sib3Program"><%
								    while (ynIDs3.hasNext()) {
									      int ynId = ynIDs3.next();
									      out.println("<option value=\"" + ynId + "\">" + 
									      yn.get(ynId) + "</option>");
									      }
										%></select></td>
							<td><input type="text" name="sib3Details" id="sib3Details" /></td>
						</tr>
						<tr>
							<td>4</td>
							<td><input type="text" name="sib4Name" id="sib4Name" /></td>
							<td><input style="width: 30px;" type="text" name="sib4Age" id="sib4Age" /></td>
							<td><select name="sib4Program" id="sib4Program"><%
								    while (ynIDs4.hasNext()) {
									      int ynId = ynIDs4.next();
									      out.println("<option value=\"" + ynId + "\">" + 
									      yn.get(ynId) + "</option>");
									      }
										%></select></td>
							<td><input type="text" name="sib4Details" id="sib4Details" /></td>				</tr>
					</table>
				</fieldset>
				<fieldset>
				<legend>Medical</legend><br />
				<label>Health Check up date: </label>
				<input type="text" id="medCheckDate" name="medCheckDate" ><br />
				<label>Medical Treatment if any: </label>
				<input type="text" id="medTreatment" name="medTreatment"></input><br />
				<label for="medDetails">Details: </label>
				<textarea id="medDetails" name="medDetails"> </textarea>
				</fieldset>
				<fieldset>
				<legend>Academics</legend><br />
				<%-- Not needed as of now
				 <label>Year: </label>
				<select id="acaYear" name="acaYear">
				<% 
				    while (fiscalYearIDs.hasMoreElements()) {
				      int fiscalYearId = fiscalYearIDs.nextElement();
				      out.println("<option value=\"" + fiscalYearId + "\">" + 
				      fiscalYears.get(fiscalYearId) + "</option>");
				      }
				%> 
				</select> --%>
				<label>Class: </label>
				<input type="text" id="acaClass" name="acaClass" /><br/>
				<label>Final grade: </label>
				<input type="text" id="acaGrade" name="acaGrade"/>
				<label>Comments: </label>
				<input type="text" id="acaComments" name="acaComments"/>
				</fieldset>
				<fieldset>
				<legend>Misc</legend><br/>
				<label>Reason for Requesting Sponsorship:</label><br/>
				<textarea id="reasonSpon" name="reasonSpon"></textarea>
				<label>Comments:</label><br/>
				<textarea id="comments" name="comments"></textarea>
				</fieldset>
				<input class="button" id="submit" type="submit" value="Save" /> 
				<input class="button" id="reset" type="reset" />
			</form>
		</div>
		</div>
			</div>
			<!-- closing tag of col -->

		</div>
		<!-- closing tag of row -->
	</div>
	<!-- closing tag of container -->
	<script type="text/javascript">
		$(document).ready(function() {
			$("#sib1Age").keypress(function(event) {
				return /\d/.test(String.fromCharCode(event.keyCode));
			});
		});
		$(document).ready(function() {
			$("#sib2Age").keypress(function(event) {
				return /\d/.test(String.fromCharCode(event.keyCode));
			});
		});
		$(document).ready(function() {
			$("#sib3Age").keypress(function(event) {
				return /\d/.test(String.fromCharCode(event.keyCode));
			});
		});
		$(document).ready(function() {
			$("#sib4Age").keypress(function(event) {
				return /\d/.test(String.fromCharCode(event.keyCode));
			});
		});
	</script>
	<script type="text/javascript">
		window.onbeforeunload = function() {
			return "Continue saving?";
		};
	</script>
	<script type="text/javascript">
		$(function() {
			$("#medCheckDate").datepicker({
				dateFormat : 'dd-mm-yy'
			});
		});
	</script>
	<%}catch(Exception e){
		e.printStackTrace();
	} %>
</body>
</html>