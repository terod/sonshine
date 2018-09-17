<%@page language="java" contentType="text/html"%>
<%
	String base = (String) application.getAttribute("base");
%>
<div class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#mynavbar-content">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="#" title="Sonshine"><img
				style="max-width: 130px; margin-top: -12px;"
				src="/sonshine/images/Sonshine_logo.png"></a>
		</div>
		<div class="collapse navbar-collapse" id="mynavbar-content">
			<ul class="nav navbar-nav">
				<li class="active"><a href="<%=base%>">Home</a></li>
				<li><a href="<%=base%>?action=newchild">New Registration</a></li>
				<li><a href="http://www.google.com">Google</a></li>
			</ul>
		</div>
		<div class="navbar-right" style="margin-top: -35px; margin-right: 30px;">
			<%
				if (request.getRemoteUser() != null) {
			%>
			<span class="label label-primary">
			<%=sonshine.utils.HTMLFilter.filter(request
						.getRemoteUser())%>
			</span>
			<a href="<%=base%>?logoff=true">&nbsp;Logoff</a>
			<%
				}
			%>
		</div>
		<div class="navbar-right"
			style="margin-top: -50px; margin-right: 150px;">
			<form id="ci-gs-form" class="navbar-form">
				<div class="input-group">
					<input id="keyword" name="keyword" type="text" class="form-control"
						placeholder="Search child ..."> 
					<input type="hidden" name="action" value="search"/>
						<span class="input-group-btn"
						title="Submit"><button type="submit"
							class="btn btn-default">
							<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
						</button></span>
				</div>
			</form>
		</div>
	</div>
</div>