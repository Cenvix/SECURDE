<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	
		
		<%@ include file="header.jsp" %>
		
		<script type="text/javascript">

		$(document).ready(function(){
			var userID ='<%= session.getAttribute("userID")%>';
			console.log(userID);
			
			init();
		});
		
		function init() {
			document.getElementById("name").innerHTML = "${userFirstName} ${userLastName}";
		}
		</script>
	</head>

	<body>
		
		
		<div class="jumbotron text-center">
			<h1>Welcome</h1>
			<h3 style="margin-bottom:20px"> Manager <span id="name"></span></h3>
		</div>
		
		<div class="text-center">
			<p><a role="button" class="btn btn-primary" type="button" href="AddProductInit">Add New Book</a></p>
			<p><a role="button" class="btn btn-primary" type="button" href="LibraryInit">Edit / Delete Existing Book</a></p>
			<p><a role="button" class="btn btn-primary" type="button" href="BookingsInit">Check Meeting Rooms</a></p>
		</div>
	</body>
</html>