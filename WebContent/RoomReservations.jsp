<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		
		<%@ include file="header.jsp" %>
		
		
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
			var userType ='<%= session.getAttribute("userType")%>';
			console.log(userID);
			
			initBookings();
			loadBookings();
			if(userType != "0"){
				for(var i = 0; i < bookings.length; i++) {
					document.getElementById("room"+bookings[i].room+"_"+bookings[i].timeStart).disabled = false;
				}
			}
		});
		
		function initBookings() {
			console.log("Initializing books");
			<c:forEach items="${bookings}" var="b">
			console.log("----------");
			console.log("${b}");
			console.log("----------");
        	addBooking("${b.timeStart}", "${b.idUser}", "${b.idMeetingRoom}");
        	</c:forEach>
		}
		
		function addBooking(timeStart, id, room) {
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
			
			for(var i = 0; i < bookings.length; i++) {
				console.log(bookings[i].timeStart);
				document.getElementById("room"+bookings[i].room+"_"+bookings[i].timeStart).innerHTML = "RESERVED";
				document.getElementById("room"+bookings[i].room+"_"+bookings[i].timeStart).disabled = true;
			}
		}
		
		function createReservation(room, timeStart) {
			var userID ='<%= session.getAttribute("userID")%>';

			var userType ='<%= session.getAttribute("userType")%>';
			
			if(userType == "0"){			
				$.ajax({
	                url: 'ReserveRoom',
	                data: {
	                    room: room,
	                    timeStart: timeStart,
	                    userID: userID
	                },
	                type: 'POST',
					success:function(jsonobject){
						
								if(jsonobject=="true"){
		   		            	 	document.getElementById("room"+room+"_"+timeStart).innerHTML="RESERVED";
		   		               		document.getElementById("room"+room+"_"+timeStart).disabled=true;
								} else
									alert("Reservation Failed");
							   	
							}
	            });
			}else{

				$.ajax({
	                url: 'RemoveRoom',
	                data: {
	                    room: room,
	                    timeStart: timeStart
	                },
	                type: 'POST',
					success:function(jsonobject){
						
								if(jsonobject=="true"){
		   		            	 	document.getElementById("room"+room+"_"+timeStart).innerHTML="Reserve";
								} else
									alert("Reservation Wot");
							   	
							}
	            });
			}
		
		}
		</script>
	</head>

	<body>


		
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
						<td><button type="button" class="btn btn-primary" id="room1_0900" onclick="createReservation(1, 0900)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1000" onclick="createReservation(1, 1000)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1100" onclick="createReservation(1, 1100)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1200" onclick="createReservation(1, 1200)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1300" onclick="createReservation(1, 1300)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1400" onclick="createReservation(1, 1400)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1500" onclick="createReservation(1, 1500)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room1_1600" onclick="createReservation(1, 1600)">Reserve</button></td>
					</tr>
					<tr>
						<td>Room 2</td>
						<td><button type="button" class="btn btn-primary" id="room2_0900" onclick="createReservation(2, 0900)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1000" onclick="createReservation(2, 1000)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1100" onclick="createReservation(2, 1100)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1200" onclick="createReservation(2, 1200)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1300" onclick="createReservation(2, 1300)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1400" onclick="createReservation(2, 1400)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1500" onclick="createReservation(2, 1500)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room2_1600" onclick="createReservation(2, 1600)">Reserve</button></td>
					</tr>
					<tr>
						<td>Room 3</td>
						<td><button type="button" class="btn btn-primary" id="room3_0900" onclick="createReservation(3, 0900)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1000" onclick="createReservation(3, 1000)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1100" onclick="createReservation(3, 1100)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1200" onclick="createReservation(3, 1200)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1300" onclick="createReservation(3, 1300)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1400" onclick="createReservation(3, 1400)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1500" onclick="createReservation(3, 1500)">Reserve</button></td>
						<td><button type="button" class="btn btn-primary" id="room3_1600" onclick="createReservation(3, 1600)">Reserve</button></td>
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