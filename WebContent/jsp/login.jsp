<%--
 Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<html>
<head>
<title>Login Page for Sonshine</title>
<link rel="stylesheet" href="/sonshine/css/login.css" type="text/css" />
</head>
<body>
	<div id="wrapper">
		<form name="login-form" class="login-form" method="POST"
			action='<%=response.encodeURL("j_security_check")%>'>
	
		<div class="header">
		<h1>Login Form</h1>
		<span>Welcome to project sonshine. Please enter login details</span>
		</div>
	
		<div class="content">
		<input name="j_username" type="text" class="input username" placeholder="Username" />
		<div class="user-icon"></div>
		<input name="j_password" type="password" class="input password" placeholder="Password" />
		<div class="pass-icon"></div>		
		</div>

		<div class="footer">
		<input type="submit" name="submit" value="Login" class="button" />
		<input type="reset" name="reset" value="Reset" class="register" />
		</div>
	
	</form>
	</div>
</body>
</html>
