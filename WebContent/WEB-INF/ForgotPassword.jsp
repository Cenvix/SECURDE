<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		
		<%@ include file="header.jsp" %>
		<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>
		
	</head>

	<body>
		<script type="text/javascript">
			$(document).ready(function(){
				var userID ='<%= session.getAttribute("userID")%>';
		
				
				
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
				
				var password = document.getElementById('newPassword');
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
			
			
			var regCap;
			var onloadCallback = function() {
				
				
				regCap = grecaptcha.render(document.getElementById('regCap'), {'sitekey' : '6LeDJywUAAAAADtpcpPKf3jRUv9lNi4dgHo9S86A'});
				
			  };
		    
			
			function submitEmail() {
				var email = document.getElementById("email").value;
				
				$.ajax({
		            url: 'ForgotPasswordEmail',
		            data: {
		                email: email
		            },
		            type: 'POST',
					success:function(jsonobject) {
						document.getElementById("QAContainer").style.visibility = "visible";
						document.getElementById("question").innerHTML = "Security Question: " + jsonobject;
					}
		        });
			}
			
			function submitAnswer() {
				var email = document.getElementById("email").value;
				var answer = document.getElementById("answer").value;
				var newPass = document.getElementById("newPassword").value;
				var passCon = document.getElementById("confirmPassword").value;
				
				if(!/.{8,}$/.test(newPass)||$('#password-strength-meter').val()<3){ //REGEX FOR 8 Char min
					alert("Your password is too weak!");
				}else if(newPass != passCon){
					alert("Confirm Password does not match!");
				}else{
					$.ajax({
			            url: 'ForgotPasswordAnswer',
			            data: {
			                email: email,
			                answer: answer,
			                newPass: newPass,
				            grecaptcharesponse:grecaptcha.getResponse(regCap)
			            },
			            type: 'POST',
						success:function(jsonobject){
							jsonobject = JSON.parse(jsonobject);
							if(jsonobject.sucess){
								window.location = "Home";
							} else{
								alert(jsonobject.message);
							}
						}
			        });
				}

				grecaptcha.reset(regCap);
			}
		</script>

		<div class="container">
			<div class="row well">
				<div class="col-sm-12">
					<h3>Enter your email: </h3>
					<input type="text" class="form-control" id="email">
					<button type="button" class="btn btn-primary" id="submitEmail" style="margin-top:10px" onclick="submitEmail()">Submit</button>
				</div>
			</div>
	
			<div class="row well" id="QAContainer" style="visibility:hidden">
				<div class="col-sm-12">
					<h4 id="question"></h4>
					<textarea id="answer" class="form-control" rows="5"></textarea>
					<h4>Enter new password to set:</h4>
					<input type="password" class="form-control" id="newPassword">
					<meter max="4" id="password-strength-meter"></meter>
					<p id="password-strength-text"></p>
					<h4>Confirm new password:</h4>
					<input type="password" class="form-control" id="confirmPassword">
					<br>
					<div id="regCap"></div>
					
        			<span id="captchaError" class="alert alert-danger col-sm-4" style="display:none"></span><br>
					
					<button type="button" class="btn btn-primary" id="submitAnswer" style="margin-top:10px" onclick="submitAnswer()">Submit</button>
				</div>
			</div>
		</div>
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>

		
	</body>
</html>