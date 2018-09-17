<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Hashtable"%>
<%@page session="true" import="sonshine.model.DataManager"%>
<%@ page
	import="sonshine.model.DataManager, java.util.HashMap, java.util.Enumeration"%>
<%@page import="sonshine.beans.Child"%>
<%
	//starting to populate all the fields from database
  final DataManager dataManager = (DataManager) application.getAttribute("dataManager");
  
  //programs of sonshine
  final HashMap<Integer,String> programs  =  dataManager.getPrograms();
  Set<Integer> programIdSet = programs.keySet();
  Iterator<Integer> programIDs = programIdSet.iterator();
  //locations of sonshine
  HashMap<Integer,String> locations =  dataManager.getLocations();
  Set<Integer> locationIdSet = locations.keySet();
  Iterator<Integer> locationIDs = locationIdSet.iterator();
  //coordinators of sonshine
  HashMap<Integer,String> coordinators =  dataManager.getCoordinators();
  Set<Integer> coordinatorIdSet = coordinators.keySet();
  Iterator<Integer> coordinatorIDs = coordinatorIdSet.iterator();
  //student status
  HashMap<Integer,String> studentStatuss =  dataManager.getStudentStatuss();
  Set<Integer> studentStatusIdSet = studentStatuss.keySet();
  Iterator<Integer> studentStatusIDs = studentStatusIdSet.iterator();
  //fiscal years. Using hashtable to maintain order in the retrieved items
  Hashtable<Integer,String> fiscalYears =  dataManager.getFiscalYears();
  Enumeration<Integer> fiscalYearIDs = fiscalYears.keys();
  //languages
  HashMap<Integer,String> languages =  dataManager.getLanguages();
  Set<Integer> languageIdSet = languages.keySet();
  Iterator<Integer> languagesIDs = languageIdSet.iterator();
  //religions
  HashMap<Integer,String> religions =  dataManager.getReligions();
  Set<Integer> religionIdSet = religions.keySet();
  Iterator<Integer> religionsIDs = religionIdSet.iterator();
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
				<div class="basic-grey">
			<h1>New Enrollment</h1>
			<form style="border: 0px solid; padding: 0; margin: 0;">
				<input type="hidden" name="action" value="continueNewChild" />
				<fieldset>
					<legend>Program</legend>
					<label>Program:</label> <select id="program" name="program">
						<%
							while (programIDs.hasNext()) {
												      int programId = programIDs.next();
												      out.println("<option value=\"" + programId + "\">" + 
												      programs.get(programId) + "</option>");
												      }
						%>
					</select> <label>Location:</label> <select id="location" name="location">
						<%
							while (locationIDs.hasNext()) {
												      int locationId = locationIDs.next();
												      out.println("<option value=\"" + locationId + "\">" + 
												      locations.get(locationId) + "</option>");
												      }
						%>
					</select><br> <label>Fiscal Year: </label> <select id="fyear"
						name="fyear">
						<%
							while (fiscalYearIDs.hasMoreElements()) {
												      int fiscalYearId = fiscalYearIDs.nextElement();
												      out.println("<option value=\"" + fiscalYearId + "\">" + 
												      fiscalYears.get(fiscalYearId) + "</option>");
												      }
						%>
					</select>
					<label>Application Date: </label> <input style="width: 18%;" id="application_date" name="application_date"
						type="text" required> <br />
					<label>Enrollment Date: </label> <input style="width: 18%;" id="enrollment_date" name="enrollment_date"
						type="text" required>
					<br> <label for="pc">Project Coordinator: </label> <select
						id="pc" name="pc">
						<%
							while (coordinatorIDs.hasNext()) {
												      int coordinatorId = coordinatorIDs.next();
												      out.println("<option value=\"" + coordinatorId + "\">" + 
												      coordinators.get(coordinatorId) + "</option>");
												      }
						%>
					</select> <label>Status: </label> <select id="cstatus" name="cstatus">
						<%
							while (studentStatusIDs.hasNext()) {
												      int studentStatusId = studentStatusIDs.next();
												      out.println("<option value=\"" + studentStatusId + "\">" + 
												      studentStatuss.get(studentStatusId) + "</option>");
												      }
						%>
					</select><br>
				</fieldset>
				<fieldset>
					<legend>Personal Details</legend>
					<label>Unique ID: </label> <input id="cid_1" name="cid_1"
						type="text" required maxlength="4" style="width: 50px;" /> <input
						id="cid_2" name="cid_2" type="text" required maxlength="4"
						style="width: 50px;" /> <input id="cid_3" name="cid_3"
						type="text" required maxlength="4" style="width: 50px;" /> <input
						id="cid_4" name="cid_4" type="text" required maxlength="4"
						style="width: 50px;" /> <label>Name: </label> <input
						style="width: 30%" id="cname" name="cname" type="text" required /><br>
					<label>DOB: </label> <input style="width: 18%;" id="dob" name="dob"
						type="text" required> <label>Age: </label> <input
						style="width: 30px;" id="age" name="age" type="text"
						readonly="readonly" required> <label for="pob">Place
						of birth: </label> <input id="pob" name="pob" type="text" required><br>
					<label>Gender: </label> <input type="radio" name="gender" value="1"
						required>Male <input type="radio" name="gender" value="2"
						required>Female &nbsp;&nbsp;&nbsp;<label>Mother
						tongue: </label> <select id="tongue" name="tongue">
						<%
							while (languagesIDs.hasNext()) {
												      int languageId = languagesIDs.next();
												      out.println("<option value=\"" + languageId + "\">" + 
												      languages.get(languageId) + "</option>");
												      }
						%>
					</select><br> <label>Religion: </label> <select id="religion"
						name="religion">
						<%
							while (religionsIDs.hasNext()) {
												      int religionId = religionsIDs.next();
												      out.println("<option value=\"" + religionId + "\">" + 
												      religions.get(religionId) + "</option>");
												      }
						%>
					</select><br> <label>Identification mark: </label><br /> <input id="im1"
						name="im1" type="text" placeholder="Identification Mark 1">
					<input id="im2" name="im2" type="text"
						placeholder="Identification Mark 2"> <input id="im3"
						name="im3" type="text" placeholder="Identification Mark 3">
					<br> <label>Physical defects, if any </label> <input id="pd"
						name="pd" type="text"><br>
				</fieldset>
				<fieldset>
					<legend>Address</legend>
					<input id="street" name="street" type="text" placeholder="street">
					<input id="area" name="area" type="text" placeholder="area/taluk">
					<input id="city" name="city" type="text" placeholder="city/town">
					<input id="state" name="state" type="text" placeholder="state">
					<input id="country" name="country" type="text"
						placeholder="country"> <input id="zip" name="zip"
						type="text" placeholder="zip">
				</fieldset>
				<input class="button" id="submit" type="submit" value="Continue" />
				<input class="button" id="reset" type="reset" /> <input
					class="button" id="homebutton" type="button" value="Home">

			</form>
			</div>
			</div>
			<!-- closing tag of col -->

		</div>
		<!-- closing tag of row -->
	</div>
	<!-- closing tag of container -->
	<script>
		function showDays() {
			var bday = $('#dob').datepicker('getDate');
			var current = new Date();
			if (!bday || !current)
				return;
			var age = current.getFullYear() - bday.getFullYear();
			var m = current.getMonth() - bday.getMonth();
			if (m < 0 || (m === 0 && current.getDate() < bday.getDate())) {
				age--;
			}
			$('#age').val(age);
		}
	</script>
	<script>
		$(document).ready(function() {
			$("#cid_1").keypress(function(event) {
				return /\d/.test(String.fromCharCode(event.keyCode));
			});
		});
	</script>
	<script>
		$(function() {
			$("#dob").datepicker({
				dateFormat : 'dd-mm-yy',
				onSelect : showDays
			});
		});
		$(function() {
			$("#application_date").datepicker({
				dateFormat : 'dd-mm-yy',
				onSelect : showDays
			});
		});
		$(function() {
			$("#enrollment_date").datepicker({
				dateFormat : 'dd-mm-yy',
				onSelect : showDays
			});
		});
	</script>
	
</body>
</html>