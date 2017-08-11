<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	
		
		<%@ include file="header.jsp" %>
		
		<script type="text/javascript">
			$(document).ready(function(){
				var userID ='<%= session.getAttribute("userID")%>';
				console.log(userID);
				$admins = (JSON.parse('${admins}'));
				console.log($admins);
				
				var userType = '<%= session.getAttribute("userType")%>';
				console.log(userType);
				if(userType!=3){
					window.location="AccessDenied.jsp";
				}
				
				initAdmins();
			});
			
			function initAdmins(){
				if($admins.length>0){
					var finalOut="<h2>List of Employees: </h2>";
					
					for(var i=0;i<$admins.length;i++){
						var out = "";
						var type = "";
						
						if($admins[i].userType==1)
							type = "Library Staff";
						else if($admins[i].userType==2)
							type = "Library Manager";
						else
							type = "Admin";
							
						out += "<div class='well row' style='margin:20px'>" +
									"<div class='col-sm-10'>" +
							 			"<h4>" + type + "</h4>" +
										"<div>ID Number: " + $admins[i].userNumber + "</div>" +
										"<div>Name: " + $admins[i].firstName + " " + $admins[i].middleName + " " + $admins[i].lastName + "</div>" +
										"<div>Email: " + $admins[i].email + "</div>" +
									"</div>" +
									"<div class='col-sm-2'>" +
										"<button type='button' class='btn btn-info' id='edit_"+i +"' onclick='editEmployee("+$admins[i].userNumber+")'>Edit</button>" +
									"</div>" +
								"</div>"
						finalOut+=out;
					}
					
					$("#adminTable").html(finalOut);
				}
			}
			
			function editEmployee(employeeNumber) {
				console.log("EDIT EMPLOYEE: " + employeeNumber);
				document.getElementById("invisFormContainer").innerHTML = "<form id='invisForm' action='EditEmployee' method='post'><input type='hidden' name='employeeID' value='"+employeeNumber+"''></form>";
				document.getElementById("invisForm").submit();
			}
		</script>
	</head>

	<body>
	
	<c:if test = "${sessionScope.userType==3}">
		<div class="jumbotron text-center">
			<h1>Welcome</h1>
			<h3 style="margin-bottom:20px"> Admin <span id="name">Namehere</span></h3>
			<p><a role="button" class="btn btn-primary" type="button" href="AddEmployees">Add New Staff</a></p>
			<!-- <p><a role="button" class="btn btn-primary" type="button" href="EmployeeEdit.jsp">Edit / Delete Existing Staff</a></p>-->
			
		</div>
		
		<div class="well container" id="adminTable" style="max-width: 800px"></div>
		<div id="invisFormContainer" style="visibiliy:false"></div>
	</c:if>
	</body>
</html>