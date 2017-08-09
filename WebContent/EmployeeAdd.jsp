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
			var userID ='<%= session.getAttribute("userID")%>';
			console.log(userID);
			
			
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
			
			var password = document.getElementById('password');
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
		
		var captcha
		var onloadCallback = function() {
			
			
			captcha = grecaptcha.render(document.getElementById('captcha'), {'sitekey' : '6LeDJywUAAAAADtpcpPKf3jRUv9lNi4dgHo9S86A'});
			
	      };
		
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
			}else if(!/.{8,}$/.test($pass)||$('#password-strength-meter').val()<3){ //REGEX FOR 8 Char min
				alert("Password is too weak!");
			}else if($pass != $passCon){
				alert("Confirm Password does not match!");
			}else if($sQuestion==""){ //REGEX FOR 8 Char min
				alert("Input Secret Question");
			}else if($sAnswer==""){
				alert("No answer to Secret Question!");
			}else if($sAnswer != $sCAnswer){
				alert("Confirm Answer does not match!");
			}else{
				
				alert("Creating account!");
				
				$.ajax({
		            url: 'AddEmployee',
		            data: {
		            	firstName:$fName,
		            	middleName:$mName,
		            	lastName:$lName,
		            	userNumber:$idNumber,
		                email:$email,
		                password:$pass,
		                userType:$type,
		                secretQuestion:$sQuestion,
		                secretAnswer:$sAnswer,
			            grecaptcharesponse:grecaptcha.getResponse(captcha),
		            },
		            type: 'POST',
					success:function(jsonobject){
						

						jsonobject = JSON.parse(jsonobject);
							if(jsonobject.sucess){
								alert("Add Sucess!");
								window.location = "AdminInit";
							} else{
								alert(jsonobject.message);
							   	
							}
					}
		        });
				
				
			}
			grecaptcha.reset(captcha);
		}
		</script>
	</head>

	<body>
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
					<meter max="4" id="password-strength-meter"></meter>
					<p id="password-strength-text"></p>
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
					
					<div id="captcha"></div>
					
					<button class="btn btn-primary" id="submitEmployee" onclick="addEmployee()">Save</button>
				</div>
			</div>
		</div>
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
		
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>
		<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer>
	</body>
</html>