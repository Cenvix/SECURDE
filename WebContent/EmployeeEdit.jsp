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
						<li><a href="LibraryInit">Search Library</a></li>
						<li><a href="BookingsInit">Room Reservation</a></li>
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
					Name:<br>
					<input class="form-control" type="text" id="productID" placeholder="Name" value=""><br>
					Email:<br>
					<input class="form-control" type="text" id="productTitle" placeholder="Email" value=""><br>
					Password:<br>
					<input class="form-control" type="password" id="productAuthor" placeholder="Password" value=""><br>
					Confirm Password:<br>
					<input class="form-control" type="password" id="productPublisher" placeholder="Confirm Password" value=""><br>
					Type:<br>
					<div class="form-group">
						<select class="form-control" id="productType">
							<option>Library Staff</option>
							<option>Library Manager</option>
						</select>
					</div>
					
					<button class="btn btn-primary" id="submitEmployee">Save</button>
				</div>
			</div>
		</div>
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>