<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="java.util.Hashtable"%>
<%@page import="sonshine.utils.DateUtility"%>
<%@page language="java" contentType="text/html"%>
<%@page import="sonshine.beans.*"%>
<%@page
	import="java.util.ArrayList, java.util.HashMap, java.util.Set, java.util.Iterator"%>
<%@page import="sonshine.beans.VFinanceExpenseAmount"%>
<%@page import="sonshine.beans.VFinanceSponsorAmount"%>
<%@page import="sonshine.beans.VChildSponsorDetails"%>
<jsp:useBean id="dataManager" scope="application"
	class="sonshine.model.DataManager" />
<%
	Logger logger = Logger.getLogger("ChildDetails.jsp:");
	//logger.info("From inside child details");
	//System.out.println("Hellow world");
	String base = (String) application.getAttribute("base");
	String imageURL = (String) application.getAttribute("imageURL");
	String storeImagesURL = (String) application
			.getAttribute("storeImages");
	String storeFilesURL = (String) application
			.getAttribute("storeFiles");

	try {
		//System.out.println("ChildDetails :" + "entering child details"
		//	+ request.getParameter("childKey"));
		String childKeyString = request.getParameter("childKey");
		String childFiscalString = request.getParameter("childFiscal");
		int childKey = 0;
		int childFiscal = 0;

		if (childKeyString == null || childFiscalString == null)
			throw new Exception(
					"ChildKey or childFiscal year not reaching");
		else {
			childKey = (Integer.parseInt(childKeyString));
			childFiscal = (Integer.parseInt(childFiscalString));
			//for using in ChildDetailsLeftMenu.jsp
			session.setAttribute("childKey", childKey);
			session.setAttribute("childFiscal", childFiscal);
		}
		ChildView child = dataManager.getChildOnlyById(childKey);
		Address address = child.getAddress();
		//setting child for reuse in childFinance.jsp and ChildDetailsLeftMenu.jsp
		session.setAttribute("childData", child);
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



			<%
				//for using in document & photo upload
					String childRealId = child.getChild_id();

					//get child academics
					ArrayList<VChildAcademics> childAcademicsList = dataManager
							.getChildAcademicsListByIdAndFiscal(childKey,
									childFiscal);
					//get child idenify marks

					//get program
					VChildProgram childProgram = null;

					//get fiscal years to show near name in heading
					Hashtable<Integer, String> fiscalYearMap = dataManager
							.getFiscalYears();

					//get medical
					ArrayList<ChildMedical> childMedicalList = dataManager
							.getChildMedicalListByIdAndFiscal(childKey, childFiscal);
					//get siblings
					ArrayList<VChildParents> childParentsList = dataManager
							.getChildParentsListById(childKey);
					//get comments

					//get parents
					ArrayList<VChildSiblings> childSiblingsList = dataManager
							.getChildSiblingsListById(childKey);

					//get photo
					ChildPhotos childPhoto = null;

					//get documents
					ArrayList<VChildDocuments> childDocumentsList = dataManager
							.getChildDocumentListByIdAndFiscal(childKey,
									childFiscal);

					//dropdown for categories
					HashMap<Integer, String> documentType = dataManager
							.getDocumentTypes();
					Set<Integer> documentTypeIdSet = documentType.keySet();
					Iterator<Integer> documentTypeIDs = documentTypeIdSet
							.iterator();

					if (child != null) {
			%>

			<div class="col-md-10 col-xs-12">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-8 col-xs-12">
							<h2><%=child.getName()%>'s details for the year
								<%=fiscalYearMap.get(childFiscal)%><br />
							</h2>
							<!-- Nav tabs -->
							<ul class="nav nav-tabs">
								<li class="active"><a href="#home" data-toggle="tab">Primary
										Details</a></li>
								<li><a href="#medical" data-toggle="tab">Medical &
										Education</a></li>
								<li><a href="#files" data-toggle="tab">Correspondance</a></li>
								<li><a href="#finance" data-toggle="tab">Expense &
										Sponsor</a></li>
							</ul>
							<br />
						</div>
						<div class="col-md-2 col-xs-12">
							<a class="btn btn-warning" href="<%=base%>?action=childNewFiscal&childKey=<%=childKey%>&childFiscalKey=<%=childFiscal%>" role="button">Add New Year</a>
						</div>
						<div class="col-md-2 col-xs-12">
							<div class="btn-group">
								<button type="button" class="btn btn-warning">Select
									Year</button>
								<button type="button" class="btn btn-warning dropdown-toggle"
									data-toggle="dropdown" aria-expanded="false">
									<span class="caret"></span> <span class="sr-only">Toggle
										Dropdown</span>
								</button>
								<ul class="dropdown-menu" role="menu">

									<%
										Hashtable<Integer, String> fiscalYears2 = dataManager
														.getFiscalYearsByChildId(childKey);
												//System.out.println("Test data is " + fiscalYears2.get(30));
												Enumeration<Integer> fiscalYearIds = fiscalYears2.keys();
												while (fiscalYearIds.hasMoreElements()) {
													Object fiscalYearId = fiscalYearIds.nextElement();
													out.println("<li role=\"presentation\"><a role=\"menuitem\" href=\""
															+ base
															+ "?action=childDetails&childFiscal="
															+ fiscalYearId
															+ "&childKey="
															+ childKey
															+ "\">"
															+ fiscalYears2.get(fiscalYearId)
															+ "</a></li>");
												}
									%>
								</ul>
							</div>

						</div>
					</div>
				</div>
				<!-- end of first container -->

				<!-- This is the tab container -->
				<div class="tab-content">
					<div class="tab-pane active" id="home">
						<div class="row">
							<div class="col-md-2 col-xs-12">




								<%
									if (dataManager.getChildPhotoActiveByIdAndFiscal(childKey,
													childFiscal) == null) {
												out.print("No photo present");
								%>
								<a class="link1"
									href="<%=base%>?action=uploadPhoto&childId=<%=childRealId%>&childKey=<%=childKey%>&childFiscal=<%=childFiscal%>">
									Add photo</a>
								<%
									} else {
												childPhoto = dataManager
														.getChildPhotoActiveByIdAndFiscal(childKey,
																childFiscal);
								%>
								<img width="160px" height="160px"
									src="<%=storeImagesURL + child.getChild_id() + "/"
								+ childPhoto.getPhoto_path()%>" />
								<%
									}
								%>
							</div>
							<div class="col-md-10 col-xs-12">


								<table class="table table-hover">
									<tr>
										<th colspan="4">Program</th>
										<%
											if (dataManager.getChildProgramById(childKey) != null) {
														childProgram = dataManager
																.getChildProgramById(childKey);
										%>
										<th colspan="2">
											<form class="form-inline" action="">
												<input type="hidden" id="action" name="action"
													value="updateStatus" />
												<input type="hidden" id="childKey" name="childKey"
													value="<%=childKey%>" />
												<input type="hidden" id="childFiscal" name="childFiscal"
													value="<%=childFiscal%>" />
												<input type="hidden" id="childName" name="childName"
													value="<%=child.getName()%>" />
												<button type="submit" class="btn btn-info">Update
													Program status</button>
											</form>
										</th>
									</tr>
									<%
										}
												if (childProgram == null)
													out.print("<td>No Program present</td>");
												else {
									%>

									<tr class="subheading">
										<td>Application Date</td>
										<td>Enrollment Date</td>
										<td>Status</td>
										<td>Project Coordinator</td>
										<td>Program</td>
										<td>Location</td>
									</tr>
									<tr>
										<td><%=child.getApplication_date()%></td>
										<td><%=child.getEnrollment_date()%></td>
										<td><%=childProgram.getStatus()%></td>
										<td><%=childProgram.getPc()%></td>
										<td><%=childProgram.getType()%></td>
										<td><%=childProgram.getLocation()%></td>
									</tr>
									<%
										}
									%>
								</table>
							</div>
						</div>


						<div class="row">
							<div class="col-xs-12">
								<table class="table table-hover">
									<tr>
										<th><%=child.getName()%></th>
										<th>Address</th>
									</tr>
									<tr>
										<td>
											<table class="table table-condensed">
												<tr>
													<td>Child ID:</td>
													<td><%=child.getChild_id()%></td>
												</tr>
												<tr>
													<td>Date of birth:</td>
													<td><%=child.getDob()%></td>
												</tr>
												<tr>
													<td>Age:</td>
													<td><%=DateUtility.getDiffFromCurrentYear(child.getDob())%></td>
												</tr>
												<tr>
													<td>Gender:</td>
													<td><%=child.getGender()%></td>
												</tr>
												<tr>
													<td>Mother Tongue:</td>
													<td><%=child.getMother_tongue()%></td>
												</tr>
												<tr>
													<td>Physical defects:</td>
													<td><%=child.getPhysical_defects()%></td>
												</tr>
												<tr>
													<td>Place of birth:</td>
													<td><%=child.getPlace_of_birth()%></td>
												</tr>
												<tr>
													<td>Reason:</td>
													<td><%=child.getReason()%></td>
												</tr>
												<tr>
													<td>Religion:</td>
													<td><%=child.getReligion()%></td>
												</tr>

											</table>
										</td>

										<td>
											<table class="table table-condensed">
												<tr>
													<td>Street:</td>
													<td><%=address.getStreet()%></td>
												</tr>
												<tr>
													<td>Area:</td>
													<td><%=address.getArea()%></td>
												</tr>
												<tr>
													<td>City/town:</td>
													<td><%=address.getCity_town()%></td>
												</tr>
												<tr>
													<td>State:</td>
													<td><%=address.getState()%></td>
												</tr>
												<tr>
													<td>Country:</td>
													<td><%=address.getCountry()%></td>
												</tr>
												<tr>
													<td>Zip:</td>
													<td><%=address.getZip()%></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>

							</div>
						</div>
						<div class="row">
							<div class="col-xs-12">
								<table class="table table-hover">
									<tr>
										<th>Parents </th>
										<th>
										<form class="form-inline" action="">
												<input type="hidden" id="action" name="action"
													value="newParent" />
												<input type="hidden" id="childKey" name="childKey"
													value="<%=childKey%>" />
												<input type="hidden" id="childFiscal" name="childFiscal"
													value="<%=childFiscal%>" />
												<input type="hidden" id="childName" name="childName"
													value="<%=child.getName()%>" />
												<button type="submit" class="btn btn-info">New Parent</button>
											</form>
										</th>
										<th>Siblings</th>
										<th>
										<form class="form-inline" action="">
												<input type="hidden" id="action" name="action"
													value="newSibling" />
												<input type="hidden" id="childKey" name="childKey"
													value="<%=childKey%>" />
												<input type="hidden" id="childFiscal" name="childFiscal"
													value="<%=childFiscal%>" />
												<input type="hidden" id="childName" name="childName"
													value="<%=child.getName()%>" />
												<button type="submit" class="btn btn-info">New Sibling</button>
											</form>
										</th>
									</tr>
									<tr>
										<td colspan="2">
											<table class="table table-condensed">

												<%
													if (childParentsList.size() == 0)
																out.print("<td>No Parent records found</td>");
															else {
												%>
												<tr class="subheading">
													<td>Type</td>
													<td>Name</td>
													<td>Status</td>
													<td>Occupation</td>
												</tr>
												<%
													for (VChildParents vChildParents : childParentsList) {
												%>
												<tr>
													<td><%=vChildParents.getType()%></td>
													<td><%=vChildParents.getName()%></td>
													<td><a href="<%=base%>?action=updateParentStatus&childKey=<%=childKey%>&childFiscal=<%=childFiscal%>&parentKey=<%=vChildParents.getParent_pk()%>"><%=vChildParents.getStatus()%></a></td>
													<td><%=vChildParents.getOccupation()%></td>
												</tr>
												<%
													}
															}
												%>
											</table>
										</td>
										<td colspan="2">
											<table class="table table-condensed">
												<%
													if (childSiblingsList.size() == 0)
																out.print("<td>No Sibling records found</td>");
															else {
												%>
												<tr class="subheading">
													<td>Name</td>
													<td>Age</td>
													<td>Currently active in program</td>
													<td>Details</td>
												</tr>
												<%
													for (VChildSiblings childSibling : childSiblingsList) {
												%>
												<tr>
												<%if(childSibling.getCurrent_program_fk().equals("Yes")){ 
													ChildView refChildView = dataManager.getChildOnlyById(Integer.parseInt(childSibling.getRef_child_key()));
												%>
													<td><a href="<%=base%>?action=search&keyword=<%=refChildView.getChild_id()%>"><%=refChildView.getName()%></a></td>
													<td><%=DateUtility.getDiffFromCurrentYear(refChildView.getDob()) %></td>
													<td><%=childSibling.getCurrent_program_fk()%></td>
													<td><%=childSibling.getDetails()%></td>
													<%} else{ %>
														<td><%=childSibling.getName()%></td>
													<td><%=DateUtility.getDiffFromCurrentYear(childSibling.getDob())%></td>
													<td><%=childSibling.getCurrent_program_fk()%></td>
													<td><%=childSibling.getDetails()%></td>	
													<%} %>
												</tr>
												<%
													}
															}
												%>
											</table>
										</td>
									</tr>
								</table>
							</div>
						</div>

					</div>
					<!-- end of first pane -->

					<!-- start of second pane -->
					<div class="row tab-pane" id="medical">
						<div class="col-xs-12">
							<table class="table table-hover">
								<tr>
									<th>Academics</th>
									<th>
										<form class="form-inline push-right" action="">
											<div class="form-group">
												<label class="sr-only">Medical</label>
												<p class="form-control-static">Medical</p>
											</div>
											<div class="form-group">
												<input type="hidden" id="action" name="action"
													value="newMedical" /> <input type="hidden" id="childKey"
													name="childKey" value="<%=childKey%>" /> <input
													type="hidden" id="childFiscal" name="childFiscal"
													value="<%=childFiscal%>" /> <input type="hidden"
													id="childName" name="childName"
													value="<%=child.getName()%>" />
											</div>
											<button class="btn btn-info" type="submit">Add
												Medical Record</button>
										</form>
									</th>
								</tr>
								<tr>
									<td>
										<table class="table table-condensed">

											<%
												if (childAcademicsList.size() == 0)
															out.print("<td>No Academics records found</td>");
														else {
											%>
											<tr class="subheading">
												<td>Year</td>
												<td>Current</td>
												<td>Grade</td>
												<td>ClassNo</td>
												<td>Comments</td>
											</tr>
											<%
												for (VChildAcademics vChildAcademics : childAcademicsList) {
											%>
											<tr>
												<td><%=vChildAcademics.getFiscal_year()%></td>
												<td><%=vChildAcademics.getActive()%></td>
												<td><%=vChildAcademics.getFinal_grade()%></td>
												<td><%=vChildAcademics.getClassno()%></td>
												<td><%=vChildAcademics.getComments()%></td>
											</tr>
											<%
												}
														}
											%>
										</table>
									</td>
									<td>
										<table class="table table-condensed">
											<%
												if (childMedicalList.size() == 0)
															out.print("<td>No Medical records found</td>");
														else {
											%>
											<tr class="subheading">
												<td>Checkup date</td>
												<td>Treatment</td>
												<td>Details</td>
											</tr>
											<%
												for (ChildMedical childMedical : childMedicalList) {
											%>
											<tr>
												<td><%=childMedical.getCheckup_date()%></td>
												<td><%=childMedical.getTreatment()%></td>
												<td><%=childMedical.getDetails()%></td>
											</tr>
											<%
												}
														}
											%>
										</table>
									</td>
								</tr>
							</table>
						</div>
					</div>

					<!-- <table>
			<tr>
				<th>Sponsor Details & Expense Details</th>
			</tr>
			<tr>
			<td>
					<form>
						<input type="submit" value="Sponsor & Expense sheet">
						<input type="hidden" id="childKey" name="childKey" value="" /> 
						<input type="hidden" id="childFiscal" name="childFiscal" value="" />
						<input type="hidden" id="action" name="action" value="childFinance" />
						<input type="hidden" id="childName" name="childName" value="" />
					</form>
				</td>
			</tr>
		</table>  -->

					<!-- Start of third pane -->
					<div class="row tab-pane" id="files">
						<div class="col-xs-12">
							<table class="table table-hover">
								<tr>
									<th colspan="3">Correspondence</th>
								</tr>
								<%
									if (childDocumentsList.size() == 0)
												out.print("<td>No Documents found</td>");
											else {
								%>
								<tr class="subheading">
									<td>Name</td>
									<td>Category</td>
									<td>Dated</td>
								</tr>
								<%
									for (VChildDocuments vChildDocument : childDocumentsList) {
								%>
								<tr>
									<td><a
										href="<%=storeFilesURL + child.getChild_id() + "/"
									+ vChildDocument.getPath()%>"><%=vChildDocument.getPath()%></a></td>
									<td><%=vChildDocument.getType()%></td>
									<td><%=vChildDocument.getLast_modified_on()%></td>
								</tr>
								<%
									}
											}
								%>
								<tr>
									<td colspan="3">
										<div class="well">
											<label>Upload Document:</label>
											<form class="form" action="/sonshine/Upload" method="post"
												enctype="multipart/form-data">
												<input type="hidden" id="action" name="action"
													value="uploadDocument" />
												<input type="hidden" id="childId" name="childId"
													value="<%=childRealId%>" />
												<input type="hidden" id="childKey" name="childKey"
													value="<%=childKey%>" />
												<input type="hidden" id="childFiscal" name="childFiscal"
													value="<%=childFiscal%>" />
												<select class="form-control" id="docType" name="docType">
													<%
														while (documentTypeIDs.hasNext()) {
																	int documentTypeId = documentTypeIDs.next();
																	out.println("<option value=\"" + documentTypeId + "\">"
																			+ documentType.get(documentTypeId)
																			+ "</option>");
																}
													%>
												</select>
												<input type="file" name="file" size="50" />
												<br />
												<button class="btn btn-default" type="submit" id="submit">Upload
													File</button>
											</form>
										</div>
									</td>
								</tr>
							</table>
						</div>

					</div>
					<!-- end of files pane -->

					<!-- start of expense pane -->
					<div class="row tab-pane" id="finance">
						<div class="col-xs-12">
							<%
			
			

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

			
		%>
		
		<table class="table table-bordered">
			<tr>
				<th>Sponsor details</th>
				<th><form>
						<button type="submit" class="btn btn-info">New Sponsor</button>
						<input type="hidden" id="childKey" name="childKey"
							value="<%=childKey%>" />
						<input type="hidden" id="childFiscal" name="childFiscal"
							value="<%=childFiscal%>" />
						<input type="hidden" id="action" name="action"
							value="childNewSponsor" />
						<input type="hidden" id="childName" name="childName"
							value="<%=child.getName()%>" />
					</form>
					</th><th>
					<form>
						<button type="submit" class="btn btn-info">Enter Sponsor Amount</button>
						<input type="hidden" id="childKey" name="childKey"
							value="<%=childKey%>" />
						<input type="hidden" id="childFiscal" name="childFiscal"
							value="<%=childFiscal%>" />
						<input type="hidden" id="action" name="action"
							value="childFinanceSponsor" />
						<input type="hidden" id="childName" name="childName"
							value="<%=child.getName()%>" />
					</form></th>

			</tr>
			<tr>
				<td colspan="3">
					<%
						float sponsorSum = 0;
						if (childSponsorsDetailsList.size() == 0) {
							out.print("No sponsors present");
						} else {
					%>
					<table class="table table-condensed">
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
							<td colspan='2'><table class="table table-striped">

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
		<table class="table table-bordered">
			<tr>
				<th>Expense details</th>
				<th><form>
						<button type="submit" class="btn btn-info">New Expense</button>
						<input type="hidden" id="childKey" name="childKey"
							value="<%=childKey%>" />
						<input type="hidden" id="childFiscal" name="childFiscal"
							value="<%=childFiscal%>" />
						<input type="hidden" id="action" name="action"
							value="childFinanceExpense" />
						<input type="hidden" id="childName" name="childName"
							value="<%=child.getName()%>" />
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
					<table class="table table-condensed">
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
		<br />
		<table class="table table-condensed">
			<tr>
				<th>
				<%if((sponsorSum - expenseSum) > 0) { %>
				<div class="alert alert-success" role="alert">Total money remaining: <%=sponsorSum - expenseSum%></div>
				<%} else { %>
				<div class="alert alert-danger" role="alert">Total money remaining: <%=sponsorSum - expenseSum%></div>
				<%} %>
				</th>
			</tr>
		</table>
						</div>
					</div>
					<%
						}
						} catch (Exception e) {
							logger.error(e);
					%><p class="error"><%=e%>
						- Some problem occured here! Please contact dev
					</p>
					<%
						}
					%>
				</div>
				<!-- closing tag of fluid container -->
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