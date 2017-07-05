<!DOCTYPE html>
<html lang="en">
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
		});
		
		function addEmployee(){
			$fName = $("#fName").val();
			$mName = $("#mName").val();
			$lName = $("#lName").val();
			
			$idNumber = $("#idNumber").val();
			$email = $("#email").val();
			
			$pass = $("#password").val();
			$passCon = $("#confirmPassword").val();
			
			$type = $("#userType").val();
			
			$sQuestion = $("#sQuestion").val();
			$sAnswer = $("#sAnswer").val();
			$sCAnswer = $("#sCAnswer").val();
			
			if($fName==""||$mName==""||$lName==""){
				alert("Input Name Input!");
			}else if($idNumber==""){
				alert("No ID Number");
			}
			else if(!/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/.test($email))//REGEX for EMAILL
			{
				alert("Input Valid Email!");
			}else if(!/.{8,}$/.test($pass)){ //REGEX FOR 8 Char min
				alert("Input Password with 8 or more characters!");
			}else if($pass != $passCon){
				alert("Confirm Password does not match!");
			}else if($sQuestion==""){ //REGEX FOR 8 Char min
				alert("Input Secret Question");
			}else if(!/.{8,}$/.test($pass)){ //REGEX FOR 8 Char min
				alert("Input Password with 8 or more characters!");
			}else if($sAnswer==""){
				alert("No answer to Secret Question!");
			}else if($sAnswer != $sCAnswer){
				alert("Confirm Answer does not match!");
			}else{
				
				alert("Creating account!");
				
				$.ajax({
		            url: 'AddEmployee',
		            data: {
		            	fName:$fName,
		            	mName:$mName,
		            	lName:$lName,
		            	idNumber:$idNumber,
		                email:$email,
		                password:$pass,
		                type:$type,
		                sQuestion:$sQuestion,
		                sAnswer:$sAnswer
		            },
		            type: 'POST',
					success:function(jsonobject){
						
							
								if(jsonobject=="true"){
									alert("Employee Added");
									window.location = "AdminPage.jsp";
								} else{
									alert("Employee Add FAILED");
							   	
							}
					}
		        });
				
				
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
						<li><a href="LibraryPage.jsp">Search Library</a></li>
						<li><a href="RoomReservations.jsp">Room Reservation</a></li>
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
		
		<div class="container" style="max-width:600px">
			<div class="row well">
				<div class="col-sm-12">
					First Name:<br>
					<input class="form-control" type="text" id="fName" placeholder="Name" value=""><br>
					Middle Name:<br>
					<input class="form-control" type="text" id="mName" placeholder="Name" value=""><br>
					Last Name:<br>
					<input class="form-control" type="text" id="lName" placeholder="Name" value=""><br>
					Email:<br>
					<input class="form-control" type="text" id="email" placeholder="Email" value=""><br>
					ID Number:<br>
					<input class="form-control" type="text" id="idNumber" placeholder="ID Number" value=""><br>
					Password:<br>
					<input class="form-control" type="password" id="password" placeholder="Password" value=""><br>
					Confirm Password:<br>
					<input class="form-control" type="password" id="confirmPassword" placeholder="Confirm Password" value=""><br>
					Secret Question:<br>
					<input class="form-control" type="text" id="sQuestion" placeholder="E.g. What is the name of my 1st Pet?" value=""><br>
					Answer:<br>
					<input class="form-control" type="password" id="sAnswer" placeholder="Answer" value=""><br>
					Confirm Answer:<br>
					<input class="form-control" type="password" id="sCAnswer" placeholder="Confirm Answer" value=""><br>
					Type:<br>
					<div class="form-group">
						<select class="form-control" id="userType">
							<option value ='1'>Library Staff</option>
							<option value ='2'>Library Manager</option>
						</select>
					</div>
					
					<button class="btn btn-primary" id="submitEmployee" onclick="addEmployee()">Save</button>
				</div>
			</div>
		</div>
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>