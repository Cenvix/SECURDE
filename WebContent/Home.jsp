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
	</head>

	<body>

		<script type="text/javascript">
	
			$(document).ready(function(){
				var userID ='<%= session.getAttribute("userID")%>';
				console.log(userID);
			});
		</script>

		<nav class="navbar navbar-inverse">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>                        
					</button>
					<a class="navbar-brand" href="Home">SECURDE Library</a>
				</div>
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav">
						<li class="active"><a href="Home">Home</a></li>
						<li><a href="Library">Search Library</a></li>
						<li><a href="Bookings">Room Reservation</a></li>
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