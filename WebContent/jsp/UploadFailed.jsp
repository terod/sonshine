<%@page import="sonshine.model.DataManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="/sonshine/css/sonshine.css" type="text/css" />
<title>Upload Successful</title>
<% DataManager dataManager = (DataManager) application.getAttribute("dataManager");%>
</head>
<body>
	<jsp:include page="TopMenu.jsp" flush="true" />
	<jsp:include page="LeftMenu.jsp" flush="true" />
	<div class="content">
<% String error = "";
if(request.getAttribute("message") != null)
	error  = (String) request.getAttribute("message"); 
%>
<h3>Your upload failed! Check whether is proper</h3>
</div>
<div class="content"><%=error %></div>
</body>
</html>