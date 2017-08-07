<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	
		
		<%@ include file="header.jsp" %>
		
		<script type="text/javascript">

		$(document).ready(function(){
			var userID ='<%= session.getAttribute("userID")%>';
			console.log(userID);
		});

		
			function addBook(){
				
				$bookdds = $("#productdds").val();
				$bookname = $("#productTitle").val();
				$bookauthor = $("#productAuthor").val();
				$bookpublisher = $("#productPublisher").val();
				$booktype = $("#productType").val();
				$bookyear = $("#productYear").val();
				
				if($("#productStatus").is(':checked'))
				$bookstatus = "Available";
				else
				$bookstatus = "Reserved";
				$bookdescription = $("#productDescription").val();
				if($bookdds == "" || $bookname=="" ||$bookauthor==""||$bookpublisher == "" ||$booktype==""||$bookyear==""||$bookstatus==""||$bookdescription=="")					
					setLogMessage("One or more fields are left blank.");
				else{
					$.ajax({
			            url: 'AddBook',
			            data: {

			              dds:$bookdds,
			              name:$bookname,
			              author:$bookauthor,
			              publisher:$bookpublisher,
			              type:$booktype,
			              year:$bookyear,
			              status:$bookstatus,
			              description:$bookdescription
			          		
			            },
			            type: 'POST',
						success:function(jsonobject){
									if(jsonobject=="true"){
										window.location = "LibraryInit";
									} else{
									setLogMessage("Book not Created");
								   	
								}
						}
			        });
					
					
				}
			}
			
			
			function setLogMessage(mes){
				$("#logMessage").show();
				$("#logMessage").html(mes);
			}
		</script>
	</head>

	<body>		
		<div class="container">
			<div class="row well">
				<div class="col-sm-4">
				
					Dewey Decimal Number:<br>
					<input class="form-control" type="text" id="productdds" placeholder="DDC" ><br>
					Title:<br>
					<input class="form-control" type="text" id="productTitle" placeholder="Title"><br>
					Author:<br>
					<input class="form-control" type="text" id="productAuthor" placeholder="Author"><br>
					Published by:<br>
					<input class="form-control" type="text" id="productPublisher" placeholder="Publisher"><br>
					Year:<br>
					<input class="form-control" type="text" id="productYear" placeholder="Year"><br>
					Available:<br>
					<input class="form-control" type="checkbox" id="productStatus" placeholder="Status"><br>
					
					Type:<br>
					<div class="form-group">
						<select class="form-control" id="productType">
							<option val="Book">Book</option>
							<option val="Magazine">Magazine</option>
							<option val="Thesis">Thesis</option>
						</select>
					</div>
				</div>
				
				<div class="col-sm-8">
					Description:<br>
					<textarea class="form-control" rows="16" id="productDescription"></textarea>
					<button type="button" class="btn btn-primary" style="width:100%;margin-top:10px" id="save" onClick="addBook()">Add!</button>
					
				</div>
			</div>
		</div>
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>