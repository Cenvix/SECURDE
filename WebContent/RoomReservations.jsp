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

		var bookings = [];
		
		class Booking {
			constructor(timeStart, id, room) {
				this.timeStart = timeStart;
				this.id = id;
				this.room = room;
			}
		}
		
		$(document).ready(function(){
			var userID ='<%= session.getAttribute("userID")%>';
			console.log(userID);
			
			initBookings();
			loadBookings();
		});
		
		function initBookings() {
			console.log("Initializing books");
			<c:forEach items="${bookings}" var="b">
			console.log("----------");
			console.log("${b.timeStart}");
			console.log("----------");
        	addBooking("${b.timeStart}", "${b.idUser}", "${b.idMeetingRoom}");
        	</c:forEach>
		}
		
		function addBooking() {
			var booking = new Booking(timeStart, id, room);
			bookings.push(booking);
		}
		
		function loadBookings() {
			/*
			document.getElementById('tableContainer').innerHTML = "";
			
			var result = "<h1> Meeting Rooms </h1>" +
			"<table class='table table-bordered table-condensed'>" +
			"<thead>" +
				"<tr>" +
					"<th>Room</th>" +
					"<th>9AM-10AM</th>" +
					"<th>10AM-11AM</th>" +
					"<th>11AM-12AM</th>" +
					"<th>12AM-1PM</th>" +
					"<th>1PM-2PM</th>" +
					"<th>2PM-3PM</th>" +
					"<th>3PM-4PM</th>" +
					"<th>4PM-5PM</th>" +
				"</tr>" +
			"</thead>" +
			"<tbody>" +
				"<tr>" +
					"<td>Room 1</td>" +
					"<td><button type='button' class='btn btn-primary' id='room1_0900'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room1_1000'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room1_1100'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room1_1200'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room1_1300'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room1_1400'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room1_1500'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room1_1600'>Reserve</button></td>" +
				"</tr>" +
				"<tr>" +
					"<td>Room 2</td>" +
					"<td><button type='button' class='btn btn-primary' id='room2_0900'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room2_1000'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room2_1100'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room2_1200'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room2_1300'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room2_1400'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room2_1500'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room2_1600'>Reserve</button></td>" +
				"</tr>" +
				"<tr>" +
					"<td>Room 3</td>" +
					"<td><button type='button' class='btn btn-primary' id='room3_0900'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room3_1000'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room3_1100'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room3_1200'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room3_1300'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room3_1400'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room3_1500'>Reserve</button></td>" +
					"<td><button type='button' class='btn btn-primary' id='room3_1600'>Reserve</button></td>" +
				"</tr>" +
			"</tbody>" +
			"</table>";
			*/
			
			console.log(bookings[i].timeStart);
			
			for(var i = 0; i < bookings.length; i++) {
				document.getElementById("room"+bookings[i].room+"_"+bookings[i].timeStart).innerHTML = "RESERVED";
				document.getElementById("room"+bookings[i].room+"_"+bookings[i].timeStart).disabled = true;
			}
			
			
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
		
		<!--TODO when compiling: Autogenerate Table-->
		<!--TODO when compiling: Swap reserve button for override button when library manager mode-->
		<!--TODO when compiling: Swap button out for glyphicon when library staff mode-->	
		<div class="container well" id="tableContainer">
			<h1> Meeting Rooms </h1>
			<table class="table table-bordered table-condensed">
				<thead>
					<tr>
						<th>Room</th>
						<th>9AM-10AM</th>
						<th>10AM-11AM</th>
						<th>11AM-12AM</th>
						<th>12AM-1PM</th>
						<th>1PM-2PM</th>
						<th>2PM-3PM</th>
						<th>3PM-4PM</th>
						<th>4PM-5PM</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Room 1</td>
						<td><button type="button" class="btn btn-primary" id="room1_0900">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1000">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1100">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1200">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1300">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1400">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1500">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1600">Reserve</button></td>
					</tr>
					<tr>
						<td>Room 2</td>
						<td><button type="button" class="btn btn-primary" id="room2_0900">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1000">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1100">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1200">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1300">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1400">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1500">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1600">Reserve</button></td>
					</tr>
					<tr>
						<td>Room 3</td>
						<td><button type="button" class="btn btn-primary" id="room3_0900">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1000">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1100">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1200">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1300">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1400">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1500">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1600">Reserve</button></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>