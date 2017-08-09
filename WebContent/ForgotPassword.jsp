<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		
		<%@ include file="header.jsp" %>
	</head>

	<body>
		<script type="text/javascript">
			$(document).ready(function(){
				var userID ='<%= session.getAttribute("userID")%>';
				console.log(userID);
			});
			
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
				
				$.ajax({
		            url: 'ForgotPasswordAnswer',
		            data: {
		                email: email,
		                answer: answer,
		                newPass: newPass
		            },
		            type: 'POST',
					success:function(jsonobject){
						jsonobject = JSON.parse(jsonobject);
						if(jsonobject.sucess){
							window.location = "Home";
						} else{
							alert(jsonobject.message);
							window.location = "LoginPage.jsp";
						}
					}
		        });
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
					<input type="text" class="form-control" id="newPassword">
					<button type="button" class="btn btn-primary" id="submitAnswer" style="margin-top:10px" onclick="submitAnswer()">Submit</button>
				</div>
			</div>
		</div>
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>