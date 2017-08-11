<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>SECURDE Library</title>
		
		<%@ include file="header.jsp" %>
	</head>

	<body>

		<script type="text/javascript">
	
			$(document).ready(function(){
				var userID ='<%= session.getAttribute("userID")%>';
				console.log(userID);
			});
		</script>
	<div class="jumbotron">
			<div class="container text-center">
				<h1>ACCESS DENIED</h1>      
				<p>You do not have authority to enter this page</p>
			</div>
		</div>

		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>