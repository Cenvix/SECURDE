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

			$("#logMessage").hide();
			$("#registerMessage").hide();
			var userID ='<%= session.getAttribute("userID")%>';
			console.log(userID);
		});
		
			function login(){
				$email = $("#loginEmail").val();
				$pass = $("#loginPassword").val();
				
				if($email ==null || $email=="" ||$pass==null||$pass=="")					
					setLogMessage("Wrong Username OR Password");
				else{
					$.ajax({
			            url: 'Login',
			            data: {
			                email:$email,
			                password:$pass
			            },
			            type: 'POST',
						success:function(jsonobject){
									if(jsonobject=="true"){
										window.location = "Home";
									} else{
									setLogMessage("Wrong Username OR Password");
								   	
								}
						}
			        });
					
					
				}
			}
			
			function register(){
				
				$email = $("#registerEmail").val();
				$pass = $("#registerPassword").val();
				$passCon = $("#registerConfirm").val();
				
				if(!/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/.test($email))//REGEX for EMAILL
				{
					setRegMessage("Input Valid Email!");
				}else if(!/.{8,}$/.test($pass)){ //REGEX FOR 8 Char min
					setRegMessage("Input Password with 8 or more characters!");
				}else if($pass != $passCon){
					setRegMessage("Confirm Password does not match!");
				}else{
					
					setRegMessage("Creating account!");
					
					$.ajax({
			            url: 'Register',
			            data: {
			                email:$email,
			                password:$pass
			            },
			            type: 'POST',
						success:function(jsonobject){
							
								
									if(jsonobject=="true"){
										window.location = "Home";
									} else{
										alert("Register FAILED");
									setRegMessage("Account failed to create");
								   	
								}
						}
			        });
					
					
				}
			}
			
			function setRegMessage(mes){
				$("#registerMessage").show();
				$("#registerMessage").html(mes);
			}
			
			function setLogMessage(mes){
				$("#logMessage").show();
				$("#logMessage").html(mes);
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
		
		<div class="jumbotron">
		  <div class="container text-center">
			<h1>Welcome to SECURDE Library</h1>      
			<p>Login or Register Here</p>
		  </div>
		</div>
		
		<div class="row text-center">
			<div class="col-sm-1"></div>
			<div class="col-sm-4 text-center well" style="min-height:300px">
				<form id="login">
					<div class="col-sm-12" style="margin-bottom:30px"><h1>Login</h1></div>
					<div class="col-sm-12" style="margin-bottom:20px" id="logMessage"></div>
					<div class="col-sm-12" style="margin-bottom:20px"><input class="form-control" type="text" id="loginEmail" placeholder="Email"></input></div>
					<div class="col-sm-12" style="margin-bottom:10px"><input class="form-control" type="password" id="loginPassword" placeholder="Password"></input></div>
					<div class="col-sm-12" style="margin-bottom:20px"><a href="#">Forgot your password?</a></div>
					<div class="col-sm-12" style="margin-bottom:20px"><button type="button" class="btn btn-primary" id="loginButton" onClick="login()">Login</button></div>
				</form>
			</div>
			<div class="col-sm-2"></div>
			<div class="col-sm-4 text-center well" style="min-height:300px">
				<form id="register">
					<div class="col-sm-12" style="margin-bottom:30px"><h1>Register</h1></div>
					<div class="col-sm-12" style="margin-bottom:20px" id="registerMessage"></div>
					<div class="col-sm-12" style="margin-bottom:20px"><input class="form-control" type="text" id="registerEmail" placeholder="Email"></input></div>
					<div class="col-sm-12" style="margin-bottom:20px"><input class="form-control" type="password" id="registerPassword" placeholder="Password"></input></div>
					<div class="col-sm-12" style="margin-bottom:20px"><input class="form-control" type="password" id="registerConfirm" placeholder="Confirm Password"></input></div>
					<div class="col-sm-12" style="margin-bottom:20px"><button type="button" class="btn btn-primary" id="registerButton" onClick="register()">Register</button></div>
				</form>
			</div>
			<div class="col-sm-1"></div>
		</div>
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>