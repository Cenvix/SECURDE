<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
<<<<<<< HEAD:WebContent/WEB-INF/EmployeeEdit.jsp
	
		<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
	
=======
		<%@ include file="header.jsp" %>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>
		
>>>>>>> f98712ae690ba1a77d576ea6320782f1e2d0050c:WebContent/EmployeeEdit.jsp
		<script type="text/javascript">
			$(document).ready(function(){
				var userID ='<%= session.getAttribute("userID")%>';
				console.log(userID);
				
				initEmployee();
				
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

		$(document).ready(function(){
			var userID ='<%= session.getAttribute("userID")%>';
			console.log(userID);
		});
		
		var captcha
		var onloadCallback = function() {
			
			
			captcha = grecaptcha.render(document.getElementById('captcha'), {'sitekey' : '6LeDJywUAAAAADtpcpPKf3jRUv9lNi4dgHo9S86A'});
			
	      };
					  // Update the text indicator
					  if (val !== "") {
					    text.innerHTML = "Strength: " + strength[result.score]; 
					  } else {
					    text.innerHTML = "";
					  }
					});
			});
			
			var employee;
			
			function initEmployee() {
				var jsonobject = '${employeeJSON}';
				employee = (JSON.parse(jsonobject));
				
				document.getElementById("firstName").value = employee.firstName;
				document.getElementById("lastName").value = employee.lastName;
				document.getElementById("middleName").value = employee.middleName;
				document.getElementById("email").value = employee.email;
				document.getElementById("userType").value = employee.userType;
			}
			
			function employeeEdit() {
				var firstName = document.getElementById("firstName").value;
				var middleName = document.getElementById("middleName").value;
				var lastName = document.getElementById("lastName").value;
				var email = document.getElementById("email").value;
				var userType = document.getElementById("userType").value;
				
				var password = document.getElementById("password").value;
				var confirmPassword = document.getElementById("confirmPassword").value;
				var question = document.getElementById("question").value;
				var answer = document.getElementById("answer").value;
				var confirmAnswer = document.getElementById("confirmAnswer").value;
				
				var isPasswordChanged = password != "";
				var isQuestionChanged = question != "";
				var isAnswerChanged = answer != "";
				
				var isDelete = document.getElementById('delete').checked
				
				if(firstName==""||middleName==""||lastName==""){
					alert("Input Name Input!");
				}
				else if(!/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/.test(email)) {
					alert("Input Valid Email!");
				}
				else if((!/.{8,}$/.test(password)||$('#password-strength-meter').val()<3) && isPasswordChanged){ //REGEX FOR 8 Char min
					alert("Your password is too weak!");
				}
				else if((password != confirmPassword) && isPasswordChanged){
					alert("Confirm Password does not match!");
				}
				else if((answer != confirmAnswer) && isAnswerChanged){
					alert("Confirm Answer does not match!");
				}
				else{
					if(!isPasswordChanged) {
						password = null;
					}
					if(!isQuestionChanged) {
						question = null;
					}
					if(!isAnswerChanged) {
						answer = null;
					}
					
					$.ajax({
			            url: 'EmployEdit',
			            data: {
			            	firstName:firstName,
			            	middleName:middleName,
			            	lastName:lastName,
			            	userNumber:employee.userNumber,
			                email:email,
			                password: password,
			                secretQuestion: question,
			                secretAnswer: answer,
			                id: employee.id,
			                userType: userType,
			                isDelete: isDelete,
			                isPasswordChanged: isPasswordChanged,
			                isQuestionChanged: isQuestionChanged, 
			                isAnswerChanged: isAnswerChanged
			            },
			            type: 'POST',
						success:function(jsonobject){
							jsonobject = JSON.parse(jsonobject);
							if(jsonobject == true){
								window.location = "Home";
							} 
							else {
								alert(jsonobject.message);
							}
						}
			        });
				}
			}
		</script>
	</head>

	<body>	
		<div class="container" style="max-width:600px">
			<div class="row well">
				<div class="col-sm-12">
					First Name
					<input class="form-control" type="text" id="firstName" placeholder="First Name" value=""><br>
					Middle Name
					<input class="form-control" type="text" id="middleName" placeholder="Middle Name" value=""><br>
					Last Name
					<input class="form-control" type="text" id="lastName" placeholder="Last Name" value=""><br>
					Email
					<input class="form-control" type="text" id="email" placeholder="Email" value=""><br>
					Password
					<input class="form-control col-sm-1" type="password" id="password" placeholder="Password" value=""><br>
					<meter max="4" id="password-strength-meter"></meter>
					<p id="password-strength-text"></p>
					Confirm Password
					<input class="form-control" type="password" id="confirmPassword" placeholder="Confirm Password" value=""><br>
					Secret Question
					<input class="form-control" type="text" id="question" placeholder="E.g. What is the name of my 1st Pet?" value=""><br>
					Answer
					<input class="form-control" type="password" id="answer" placeholder="Answer" value=""><br>
					Confirm Answer
					<input class="form-control" type="password" id="confirmAnswer" placeholder="Confirm Answer" value=""><br>
					Type:<br>
					<div class="form-group">
						<select class="form-control" id="userType">
							<option value="1">Library Staff</option>
							<option value="2">Library Manager</option>
							<option value="3">Admin</option>
						</select>
					</div>
					<label><input type="checkbox" value="delete" id="delete" name="delete">Delete Employee</label>
					
					<button class="btn btn-primary" id="submitEmployee" onclick="employeeEdit()">Save</button>
				</div>
			</div>
		</div>
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>

		
		<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer>

		<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.2.0/zxcvbn.js"></script>

	</body>
</html>