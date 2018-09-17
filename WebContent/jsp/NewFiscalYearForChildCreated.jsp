<%@page import="sonshine.beans.VNlchStaffDetails"%>
<%@page import="sonshine.beans.ChildParents"%>
<%@page import="sonshine.beans.ChildMedical"%>
<%@page import="sonshine.beans.ChildComments"%>
<%@page import="sonshine.beans.ChildAcademics"%>
<%@page import="java.util.ArrayList"%>
<%@page session="true" import="sonshine.model.DataManager" %>
<%@page import="sonshine.beans.ChildIdentifyMarks"%>
<%@page import="sonshine.beans.ChildProgram"%>
<%@page import="sonshine.beans.Child"%>
<%@page import="sonshine.beans.ChildAcademics"%>
<%@page import="sonshine.beans.ChildSiblings"%>
<%@page import="sonshine.beans.Address"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Welcome</title>
<link rel="stylesheet" href="/sonshine/css/sonshine.css" type="text/css" />
<%
//check if something is there in attribute else route back to ChildNew
if(request.getParameter("childKey") == null)
{
%>
<jsp:forward page="/jsp/NewFiscalForChild.jsp"></jsp:forward>
<%
}
//dataManger
final DataManager dataManager = (DataManager) application.getAttribute("dataManager");

//to save the user who modifies
String user_name = "grill";//sonshine.utils.HTMLFilter.filter(request.getRemoteUser());
VNlchStaffDetails staffDetails = dataManager.getStaffDetailsByUserName(user_name);

//getting childkey parameter
String childKeyString = request.getParameter("childKey");
int childKey = Integer.parseInt(childKeyString);

//getting parameters from continueNewChild
String fatherName = request.getParameter("fatherName");
String fatherStatus = request.getParameter("fatherStatus");
String fatherOccup = request.getParameter("fatherOccup");
String motherName = request.getParameter("motherName");
String motherStatus = request.getParameter("motherStatus");
String motherOccup = request.getParameter("motherOccup");
String guardianName = request.getParameter("guardianName");
String guardianStatus = request.getParameter("guardianStatus");
String guardianOccup = request.getParameter("guardianOccup");

String sib1Name = request.getParameter("sib1Name");
String sib1Age = request.getParameter("sib1Age");
String sib1Program = request.getParameter("sib1Program");
String sib1Details = request.getParameter("sib1Details");
String sib2Name = request.getParameter("sib2Name");
String sib2Age = request.getParameter("sib2Age");
String sib2Program = request.getParameter("sib2Program");
String sib2Details = request.getParameter("sib2Details");
String sib3Name = request.getParameter("sib3Name");
String sib3Age = request.getParameter("sib3Age");
String sib3Program = request.getParameter("sib3Program");
String sib3Details = request.getParameter("sib3Details");
String sib4Name = request.getParameter("sib4Name");
String sib4Age = request.getParameter("sib4Age");
String sib4Program = request.getParameter("sib4Program");
String sib4Details = request.getParameter("sib4Details");

String medCheckDate = request.getParameter("medCheckDate");
String medTreatment = request.getParameter("medTreatment");
String medDetails = request.getParameter("medDetails");

//int acaYear = Integer.parseInt(request.getParameter("acaYear"));
String acaClass = request.getParameter("acaClass");
String acaGrade = request.getParameter("acaGrade");
String acaComments = request.getParameter("acaComments");

String reasonSpon = request.getParameter("reasonSpon");
String comments = request.getParameter("comments");

//getting parameters of childProgram
String program = request.getParameter("program");
String location = request.getParameter("location");
String fyear = request.getParameter("fyear");
String cstatus = request.getParameter("cstatus");
String pc = request.getParameter("pc");

//child program
//setting values to program bean
ChildProgram childProgram = new ChildProgram();
childProgram.setActive(1);
childProgram.setFiscal_year_fk(Integer.parseInt(fyear));
childProgram.setLocation_fk(Integer.parseInt(location));
childProgram.setPc_fk(Integer.parseInt(pc));
childProgram.setTl_fk(Integer.parseInt(pc));
childProgram.setStatus_fk(Integer.parseInt(cstatus));
childProgram.setType_fk(Integer.parseInt(program));
childProgram.setChild_fk(childKey);
childProgram.setLast_modified_by_fk(staffDetails.getStaff_pk());

//child_academics
ChildAcademics childAcademics = new ChildAcademics();
childAcademics.setActive_fk(1);
childAcademics.setClassno(acaClass);
childAcademics.setFiscal_year_fk(childProgram.getFiscal_year_fk());
childAcademics.setFinal_grade(acaGrade);
childAcademics.setComments(acaComments);
childAcademics.setChild_fk(childKey);
childAcademics.setLast_modified_by_fk(staffDetails.getStaff_pk());

//child_comments
ChildComments childComments = new ChildComments();
childComments.setActive_fk(1);
childComments.setFiscal_year_fk(childProgram.getFiscal_year_fk());
childComments.setComment(comments);
childComments.setChild_fk(childKey);
childComments.setLast_modified_by_fk(staffDetails.getStaff_pk());

//child_medical
ChildMedical childMedical = new ChildMedical();
childMedical.setCheckup_date(medCheckDate);
childMedical.setTreatment(medTreatment);
childMedical.setDetails(medDetails);
childMedical.setFiscal_year_fk(childProgram.getFiscal_year_fk());
childMedical.setChild_fk(childKey);
childMedical.setLast_modified_by_fk(staffDetails.getStaff_pk());

//child_parents
ArrayList<ChildParents> childParentsList = new ArrayList<ChildParents>(); 
if(!fatherName.equals(""))
{
	ChildParents childParents = new ChildParents();
	childParents.setName(fatherName);
	childParents.setOccupation(fatherOccup);
	childParents.setStatus_fk(Integer.parseInt(fatherStatus));
	childParents.setType("Father");//check whether hardcoding is correct
	childParents.setFiscal_year_fk(childProgram.getFiscal_year_fk());
	childParents.setChild_fk(childKey);
	childParents.setLast_modified_by_fk(staffDetails.getStaff_pk());
	childParentsList.add(childParents);
}
if(!motherName.equals(""))
{
	ChildParents childParents = new ChildParents();
	childParents.setName(motherName);
	childParents.setOccupation(motherOccup);
	childParents.setStatus_fk(Integer.parseInt(motherStatus));
	childParents.setType("Mother");//check whether hardcoding is correct
	childParents.setFiscal_year_fk(childProgram.getFiscal_year_fk());
	childParents.setChild_fk(childKey);
	childParents.setLast_modified_by_fk(staffDetails.getStaff_pk());
	childParentsList.add(childParents);
}
if(!guardianName.equals(""))
{
	ChildParents childParents = new ChildParents();
	childParents.setName(guardianName);
	childParents.setOccupation(guardianOccup);
	childParents.setStatus_fk(1);//since always guardian is assumed to be alive
	childParents.setType("Guardian");//check whether hardcoding is correct
	childParents.setFiscal_year_fk(childProgram.getFiscal_year_fk());
	childParents.setChild_fk(childKey);
	childParents.setLast_modified_by_fk(staffDetails.getStaff_pk());
	childParentsList.add(childParents);
}
	
//child_siblings
ArrayList<ChildSiblings> childSiblingsList = new ArrayList<ChildSiblings>();
if(!sib1Name.equals(""))
{
	ChildSiblings childSiblings = new ChildSiblings();
	childSiblings.setName(sib1Name);
	childSiblings.setCurrent_program_fk(Integer.parseInt(sib1Program));
	//childSiblings.setDob(Integer.parseInt(sib1Age));
	childSiblings.setDetails(sib1Details);
	childSiblings.setFiscal_year_fk(childProgram.getFiscal_year_fk());
	childSiblings.setChild_fk(childKey);
	childSiblings.setLast_modified_by_fk(staffDetails.getStaff_pk());
	childSiblingsList.add(childSiblings);
}
if(!sib2Name.equals(""))
{
	ChildSiblings childSiblings = new ChildSiblings();
	childSiblings.setName(sib2Name);
	childSiblings.setCurrent_program_fk(Integer.parseInt(sib2Program));
	//childSiblings.setAge(Integer.parseInt(sib2Age));
	childSiblings.setDetails(sib2Details);
	childSiblings.setFiscal_year_fk(childProgram.getFiscal_year_fk());
	childSiblings.setChild_fk(childKey);
	childSiblings.setLast_modified_by_fk(staffDetails.getStaff_pk());
	childSiblingsList.add(childSiblings);
}
if(!sib3Name.equals(""))
{
	ChildSiblings childSiblings = new ChildSiblings();
	childSiblings.setName(sib3Name);
	childSiblings.setCurrent_program_fk(Integer.parseInt(sib3Program));
	//childSiblings.setAge(Integer.parseInt(sib3Age));
	childSiblings.setDetails(sib3Details);
	childSiblings.setFiscal_year_fk(childProgram.getFiscal_year_fk());
	childSiblings.setChild_fk(childKey);
	childSiblings.setLast_modified_by_fk(staffDetails.getStaff_pk());
	childSiblingsList.add(childSiblings);
}
if(!sib4Name.equals(""))
{
	ChildSiblings childSiblings = new ChildSiblings();
	childSiblings.setName(sib4Name);
	childSiblings.setCurrent_program_fk(Integer.parseInt(sib4Program));
	//childSiblings.setAge(Integer.parseInt(sib4Age));
	childSiblings.setDetails(sib4Details);
	childSiblings.setFiscal_year_fk(childProgram.getFiscal_year_fk());
	childSiblings.setChild_fk(childKey);
	childSiblings.setLast_modified_by_fk(staffDetails.getStaff_pk());
	childSiblingsList.add(childSiblings);
}



//insert newChild8
	int transactionKey = 0;
	transactionKey = dataManager.insertNewFiscalForChild
			(childProgram, childAcademics, childComments, childMedical, childParentsList, childSiblingsList);
%>
</head>
<body>
<jsp:include page="TopMenu.jsp" flush="true"/>
<jsp:include page="LeftMenu.jsp" flush="true"/>
	<div class="content">
	<div class="basic-grey">
	<h1>Transaction Status</h1>
	<%if (transactionKey != 0){ %>
		<label style="padding-left:20%; color: green">Record successfully updated and the transaction ID is: <%=transactionKey%></label>
		<%} else {%>
		<label style="padding-left:50%; color: red">Transaction failed</label><%} %>
	</div>
	</div>
	</body>
</html>
