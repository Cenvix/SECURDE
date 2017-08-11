<!DOCTYPE html>
<html lang="en">
  <head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	
		
		<%@ include file="header.jsp" %>
	
		<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>
		
		<script type="text/javascript">
		
		
		
		$(document).ready(function(){

			$("#logMessage").hide();
			$("#registerMessage").hide();
			var userID ='<%= session.getAttribute("userID")%>';
			if(parseInt('<%= session.getAttribute("attemps")%>')>=3){
				
				setLogMessage("Wrong Username OR Password");
			}
			
			
			/******************************************************************************
			PASSWORD STUFF
			*******************************************************************************/
			var strength = {
					  0: "Worst",
					  1: "Bad",
					  2: "Weak",
					  3: "Good",
					  4: "Strong"
					}
			
			var password = document.getElementById('registerPassword');
			var meter = document.getElementById('password-strength-meter');
			var text = document.getElementById('password-strength-text');

			password.addEventListener('input', function() {
			  var val = password.value;
			  var result = zxcvbn(val);

			  // Update the password strength meter
			  meter.value = result.score;

			  // Update the text indicator
			  if (val !== "") {
			    text.innerHTML = "Strength: " + strength[result.score]; 
			  } else {
			    text.innerHTML = "";
			  }
			});
			
		});
		
		var regCap,logCap,attemps;
		var onloadCallback = function() {
			
			
			regCap = grecaptcha.render(document.getElementById('regCap'), {'sitekey' : '6LeDJywUAAAAADtpcpPKf3jRUv9lNi4dgHo9S86A'});
			if(parseInt('<%= session.getAttribute("attemps")%>')>=3){
				logCap = grecaptcha.render(document.getElementById('logCap'), {'sitekey' : '6LeDJywUAAAAADtpcpPKf3jRUv9lNi4dgHo9S86A'});
				
			}
	      };
	      
	      
		
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
			                password:$pass,
			                grecaptcharesponse:grecaptcha.getResponse(logCap)
			            },
			            type: 'POST',
						success:function(jsonobject){
								jsonobject = JSON.parse(jsonobject);
									if(jsonobject.sucess){
										window.location = "Home";
									} else{
										alert(jsonobject.message);
										window.location = "LoginPage";
								}
						
						},
			            error: function(){
						    alert('Something went wrong! Please try again');
						}
			            
			        });
					
					
				}

				
			}
			
			function register(){
				
				
				$fName = $("#registerFName").val();
				$mName = $("#registerMName").val();
				$lName = $("#registerLName").val();
				$idNumber = $("#registerIDNumber").val();
				$email = $("#registerEmail").val();
				$pass = $("#registerPassword").val();
				$passCon = $("#registerConfirmPassword").val();
				

				
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
				}else if(!/.{8,}$/.test($pass)||$('#password-strength-meter').val()<3){ //REGEX FOR 8 Char min
					alert("Your password is too weak!");
				}else if($pass != $passCon){
					alert("Confirm Password does not match!");
				}else if($sQuestion==""){ //REGEX FOR 8 Char min
					alert("Input Secret Question");
				}else if($sAnswer==""){
					alert("No answer to Secret Question!");
				}else if($sAnswer != $sCAnswer){
					alert("Confirm Answer does not match!");
				}else{
					
					setRegMessage("Creating account!");
					
					$.ajax({
			            url: 'Register',
			            data: {
			            	firstName:$fName,
			            	middleName:$mName,
			            	lastName:$lName,
			            	userNumber:$idNumber,
			                email:$email,
			                password:$pass,
			                secretQuestion:$sQuestion,
			                secretAnswer:$sAnswer,
				            grecaptcharesponse:grecaptcha.getResponse(regCap),
			            },
			            type: 'POST',
						success:function(jsonobject){
							jsonobject = JSON.parse(jsonobject);
								//console.log(jsonobject);
									if(jsonobject.sucess){
										window.location = "Home";
									} else{
									alert(jsonobject.message);
								   	
								}
						},
			            error: function(){
						    alert('Something went wrong! Please try again');
						}
			        });
					
					
				}
				grecaptcha.reset(regCap);

				//console.log(grecaptcha.getResponse(regCap));
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
					<div class="col-sm-12" style="margin-bottom:20px"><a href="ForgotPassword">Forgot your password?</a></div>
					<div class="col-sm-12" id="logCap"></div><br>
					<div class="col-sm-12" style="margin-bottom:20px"><button type="button" class="btn btn-primary" id="loginButton" onClick="login()">Login</button></div>
				</form>
			</div>
			<div class="col-sm-2"></div>
			<div class="col-sm-4 text-center well" style="min-height:300px">
				<form id="register">
					<div class="col-sm-12" style="margin-bottom:30px"><h1>Register</h1></div>
					<div class="col-sm-12" style="margin-bottom:20px" id="registerMessage"></div>
					
					First Name
					<input class="form-control" type="text" id="registerFName" placeholder="First Name" value=""><br>
					
					Middle Name
					<input class="form-control" type="text" id="registerMName" placeholder="Middle Name" value=""><br>
					
					Last Name
					<input class="form-control" type="text" id="registerLName" placeholder="Last Name" value=""><br>
					
					Email
					<input class="form-control" type="text" id="registerEmail" placeholder="Email" value=""><br>
					
					ID Number
					<input class="form-control" type="text" id="registerIDNumber" placeholder="ID Number" value=""><br>
					
					Password
					<input class="form-control col-sm-1" type="password" id="registerPassword" placeholder="Password" value=""><br>
					<meter max="4" id="password-strength-meter"></meter>
					<p id="password-strength-text"></p>
					
					
					Confirm Password
					<input class="form-control" type="password" id="registerConfirmPassword" placeholder="Confirm Password" value=""><br>
					
					
					
					Secret Question
					<input class="form-control" type="text" id="sQuestion" placeholder="E.g. What is the name of my 1st Pet?" value=""><br>
					
					Answer
					<input class="form-control" type="password" id="sAnswer" placeholder="Answer" value=""><br>
					
					Confirm Answer
					<input class="form-control" type="password" id="sCAnswer" placeholder="Confirm Answer" value=""><br>
					
					<div id="regCap"></div>
					
        			<span id="captchaError" class="alert alert-danger col-sm-4" style="display:none"></span><br>
					
					<div class="col-sm-12" style="margin-bottom:20px"><button type="button" class="btn btn-primary" id="registerButton" onClick="register()">Register</button></div>
					
				</form>
			</div>
			<div class="col-sm-1"></div>
		</div>
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>
	
		
	</body>
</html>