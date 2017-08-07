<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	
		
		<script type="text/javascript">

		$(document).ready(function(){
			var userID ='<%= session.getAttribute("userID")%>';
			console.log(userID);
		});
		</script>
		
		<%@ include file="header.jsp" %>
	</head>

	<body>	
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