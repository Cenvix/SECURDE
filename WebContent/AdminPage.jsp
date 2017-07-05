<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	
		<title>SECURDE Library</title>

		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="stylesheet.css" rel="stylesheet">
		<script type="text/javascript" src="js/jquery-3.0.0.min.js" ></script>
		<%@  taglib  prefix="c"   uri="http://java.sun.com/jsp/jstl/core"  %>
		
		<script type="text/javascript">

		$(document).ready(function(){
			var userID ='<%= session.getAttribute("userID")%>';
			console.log(userID);
			$admins = (JSON.parse('${admins}'));
			console.log($admins);
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
					else
						out+= "<br>" + "\(Library Manager\)";
					out+="<br><br><br><\div>";
					
					finalOut+=out;
				}
				
				$("#adminTable").html(finalOut);
			}
		}
		</script>
	</head>

	<body>
		<nav class="navbar navbar-inverse">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>                        
					</button>
					<a class="navbar-brand" href="Home.jsp">SECURDE Library</a>
				</div>
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav">
						<li class="active"><a href="Home.jsp">Home</a></li>
						<li><a href="LibraryInit">Search Library</a></li>
						<li><a href="BookingsInit">Room Reservation</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<c:choose>
						  	<c:when test="${empty userID}">
						    	<li><a href="LoginPage.jsp"><span class="glyphicon glyphicon-log-in"></span> Login / Register</a></li>
						  	</c:when>
						  	<c:otherwise>
						  		<li><a href="Logout"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
						  	</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</nav>
		
		<div class="jumbotron text-center">
			<h1>Welcome</h1>
			<h3 style="margin-bottom:20px"> Admin <span id="name">Namehere</span></h3>
			<p><a role="button" class="btn btn-primary" type="button" href="EmployeeAdd.jsp">Add New Staff</a></p>
			<!-- <p><a role="button" class="btn btn-primary" type="button" href="EmployeeEdit.jsp">Edit / Delete Existing Staff</a></p>-->
			
		</div>
		<div class="jumbotron text-center" id="adminTable"></div>
	</body>
</html>