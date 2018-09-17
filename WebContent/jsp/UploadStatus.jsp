<%@page session="true" import="sonshine.model.DataManager"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	DataManager dataManager = (DataManager) application
			.getAttribute("dataManager");
	String base = (String) application.getAttribute("base");
	int childKey = (Integer) request.getAttribute("childKey");
	int childFiscal = (Integer) request.getAttribute("childFiscal");
	String uploadStatus = (String) request.getAttribute("uploadStatus");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Upload Successful</title>
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

			<div class="col-md-10 col-xs-12">
				<%
					String error = "";
					if (request.getAttribute("message") != null)
						error = (String) request.getAttribute("message");

					if (uploadStatus.equals("passed")) {
				%>

				<div class="alert alert-success" role="alert">
					Your upload successful!<a
						href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscal%>">
						click here to return</a>

				</div>
				<%
					} else {
				%>
				<div class="alert alert-danger" role="alert">
					Your upload failed!
					<%=error%><a
						href="<%=base%>?action=childDetails&childKey=<%=childKey%>&childFiscal=<%=childFiscal%>">
						click here to return</a>

				</div>
				<%
					}
				%>
				<!-- <div class="content"></div> -->
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
