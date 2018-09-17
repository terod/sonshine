<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="/sonshine/css/sonshine.css" type="text/css" />
<title>Document Uploading Form</title>
<%
	String base = (String) application.getAttribute("base");
	String childId = request.getParameter("childId");
	String childKey = request.getParameter("childKey");
	String childFiscal = request.getParameter("childFiscal");
%>
</head>
<body>
	<jsp:include page="TopMenu.jsp" flush="true" />
	<jsp:include page="LeftMenu.jsp" flush="true" />
	<div class="content">
	<h3>Document Upload:</h3>
	Select a document to upload:
	<br /> Please give the document name as name + date. E.g: geo20_01_2013
	<form action="/sonshine/Upload" method="post" 
                        enctype="multipart/form-data">
		<input type="hidden" id="action" name="action" value="uploadDocument" />
		<input type="hidden" id="childId" name="childId" value="<%=childId %>" />
		<input type="hidden" id="childKey" name="childKey" value="<%=childKey %>" />
		<input type="hidden" id="childFiscal" name="childFiscal" value="<%=childFiscal %>" />
		 <input type="file"
			name="file" size="50" /> <br />
			<input
			type="submit" id="submit" value="Upload File" />
	</form>
	</div>
</body>
</html>