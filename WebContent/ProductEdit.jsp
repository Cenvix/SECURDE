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
			var bookID = '<%= session.getAttribute("productID")%>';
			
			console.log(bookID);
			initBook(bookID);
		});

		
			function initBook(bookID){
				$.ajax({
		            url: 'GetBook',
		            data: {
		              bookID:bookID
		            },
		            type: 'POST',
					success:function(jsonobject){
								if(jsonobject!=null){
									var book = (JSON.parse(jsonobject));
									
									$("#productdds").val(book.dds);
									$("#productTitle").val(book.name);
									$("#productAuthor").val(book.author);
									$("#productPublisher").val(book.publisher);

				
									$("#productYear").val(book.year);
									if(book.status=="Available")
										$("#productStatus").prop('checked',true);
									else
										$("#productStatus").prop('checked',false);
									$("#productDescription").val(book.description);
									
									$("#productType").val(book.type);
								} else{
								setLogMessage("Book Cannot be Found");
							   	
							}
					}
		        });
			}
		

			function removebook($bookid){
				$bookID = $("#productID").val();
				if($bookid==""){
					setLogMessage("Missing Parameters");
				}else{
					$.ajax({
			            url: 'DeleteBook',
			            data: {
			              bookid:$bookid
			            },
			            type: 'POST',
						success:function(jsonobject){
									if(jsonobject=="true"){
										window.location = "LibraryInit";
									} else{
									setLogMessage("Book Cannot be Found");
								   	
								}
						}
			        });
					
				}
				
			}		
			function editbook(bookID){
				$bookid = bookID;
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
				console.log($bookid);
				if($bookid == "" ||$bookdds == "" || $bookname=="" ||$bookauthor==""||$bookpublisher == "" ||$booktype==""||$bookyear==""||$bookstatus==""||$bookdescription=="")					
					setLogMessage("One or more fields are left blank.");
				else{
					$.ajax({
			            url: 'EditBook',
			            data: {

				          id:$bookid,
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
									setLogMessage("Book Cannot be Found");
								   	
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
					<textarea class="form-control" rows="16" id="productDescription">Some sort of description here about the product. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</textarea>
					<button type="button" class="btn btn-primary" style="width:100%;margin-top:10px" id="save" onClick="editbook(<%= session.getAttribute("productID")%>)">Save Changes</button>
					<button type="button" class="btn btn-danger" style="width:100%;margin-top:10px" id="delete" onClick = "removebook(<%= session.getAttribute("productID")%>)">Delete</button>
				</div>
			</div>
		</div>
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>