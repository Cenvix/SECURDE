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
				var finalOut="";
				for(var i=0;i<$admins.length;i++){
					var out = "";
					out+=	"<div>"+$admins[i].userNumber + 
							"<br>" + $admins[i].firstName +
							" " + $admins[i].lastName +
							"<br>" + $admins[i].email;
							
					if($admins[i].userType==1)
						out+= "<br>" + "\(Library Staff\)";
					else if($admins[i].userType==2)
						out+= "<br>" + "\(Library Manager\)";
					else
						out+= "<br>" + "\(Admin\)";
					out+="<br><br><br><\div>";
					
					finalOut+=out;
				}
				
				$("#adminTable").html(finalOut);
			}
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
		<div class="jumbotron text-center" id="adminTable"></div>
	</c:if>
	</body>
</html>