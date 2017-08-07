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
		</script>

		

		<div class="jumbotron">
			<div class="container text-center">
				<h1>Welcome to SECURDE Library</h1>      
				<p>Some library with half-decent security protocols</p>
			</div>
		</div>
		  
		<div class="container-fluid bg-3 text-center">    
			<h3>Featured Books</h3><br>
			<div class="row">
				<div class="col-sm-3">
					<p id="sampleBookTitle1">Book Something</p>
				</div>
				<div class="col-sm-3"> 
					<p id="sampleBookTitle2">Book Something</p>
				</div>
				<div class="col-sm-3"> 
					<p id="sampleBookTitle3">Book Something</p>
				</div>
				<div class="col-sm-3">
					<p id="sampleBookTitle4">Book Something</p>
				</div>
			</div>
		</div><br>

		<div class="container-fluid bg-3 text-center">    
			<div class="row">
				<div class="col-sm-3">
					<p id="sampleBookTitle5">Book Something</p>
				</div>
				<div class="col-sm-3"> 
					<p id="sampleBookTitle6">Book Something</p>
				</div>
				<div class="col-sm-3"> 
					<p id="sampleBookTitle7">Book Something</p>
				</div>
				<div class="col-sm-3">
					<p id="sampleBookTitle8">Book Something</p>
				</div>
			</div>
		</div><br><br>

		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>