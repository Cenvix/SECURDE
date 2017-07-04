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
		var books = [];

		$(document).ready(function(){
			var userID ='<%= session.getAttribute("userID")%>';
			console.log(userID);
			
			initBooks();
			loadBooks();
		});
		
		class Book {
			constructor(name, publisher, author, id) {
				this.name = name;
				this.publisher = publisher;
				this.author = author;
				this.id = id;
			};
		}
		
		function addBook(name, publisher, author, id) {
			var book = new Book(name, publisher, author, id);
			books.push(book);
		}
		
		function initBooks(){
			console.log("Initializing books");
			<c:forEach items="${books}" var="b">
        	addBook("${b.name}", "${b.publisher}", "${b.author}", "${b.id}");
        	</c:forEach>
        	
        }
		
		function loadBooks() {
			document.getElementById('resultsContainer').innerHTML = "";
			var results = "";
			
			for(var i = 0; i < books.length; i++) {
				console.log(results);
				results += "<div class='row'>" +
								"<div class='col-sm-10'>" +
									"<div class='well'>" +
										"<a href='ProductPage.jsp'><h3 id='productTitle_" + books[i].id + "'>" + books[i].name + "</h3></a>" +
										"<label>Author: </label> <span id='productAuthor_" + books[i].id + "'>" + books[i].author + "</span><br>" +
										"<label>Publisher: </label><span id='productPublisher_" + books[i].id + "'>" + books[i].publisher + "</span>" +
									"</div>" +
								"</div>" +
								"<div class='col-sm-2 well'>" +
									"<button type='button' class='btn btn-primary libraryButtons' style='width:100%' id='reserve_" + books[i].id + "'>Reserve</button>" +
									"<button type='button' class='btn btn-info libraryButtons' style='width:100%' id='edit_" + books[i].id + "'>Edit</button>" +
								"</div>" + 
							"</div>";
			}
			
			document.getElementById('resultsContainer').innerHTML = results;
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
		  
		<div class="container">    
		  <div class="row">
			<div class="col-sm-3 well">
				<div class="input-group">
					<input type="text" class="form-control" placeholder="Search" id="searchQuery">
					<div class="input-group-btn">
						<button class="btn btn-default" type="submit" id="searchSubmit">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</div>
				
				<div style="margin-left:50px">
					<div class="checkbox">
						<label><input type="checkbox" value="" id="filterBook">Book</label>
					</div>
					<div class="checkbox">
						<label><input type="checkbox" value="" id="filterMagazine">Magazine</label>
					</div>
					<div class="checkbox disabled">
						<label><input type="checkbox" value="" id="filterThesis">Thesis</label>
					</div>
				</div>
			</div>
			
			<!--TODO when we compile everything: Automate generation of search results-->
			<!--TODO when we compile everything: Make edit button dependent on user authorization-->
			<div class="col-sm-9" id="resultsContainer">
				<div class="row">
					<div class="col-sm-10">
						<div class="well">
							<a href="ProductPage.jsp"><h3 id="productTitle1">Book Something Something 1</h3></a>
							<label>Author: </label> <span id="productAuthor2"> Some Guy 2</span><br>
							<label>Publisher: </label><span id="productPublisher1"> Some People 1</span>
						</div>
					</div>
					<div class="col-sm-2 well">
						<button type="button" class="btn btn-primary libraryButtons" style="width:100%" id="reserve1">Reserve</button>
						<button type="button" class="btn btn-info libraryButtons" style="width:100%" id="edit1">Edit</button>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10">
						<div class="well">
							<a href="ProductPage.jsp"><h3 id="productTitle2">Book Something Something 2</h3></a>
							<label>Author: </label> <span id="productAuthor2"> Some Guy 2</span><br>
							<label>Publisher: </label><span id="productPublisher1"> Some People 1</span>
						</div>
					</div>
					<div class="col-sm-2 well">
						<button type="button" class="btn btn-primary libraryButtons" id="reserve2">Reserve</button>
						<button type="button" class="btn btn-info libraryButtons" id="edit2">Edit</button>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10">
						<div class="well">
							<a href="ProductPage.jsp"><h3 id="productTitle3">Book Something Something 3</h3></a>
							<label>Author: </label> <span id="productAuthor2"> Some Guy 2</span><br>
							<label>Publisher: </label><span id="productPublisher1"> Some People 1</span>
						</div>
					</div>
					<div class="col-sm-2 well">
						<button type="button" class="btn btn-primary libraryButtons" id="reserve3">Reserve</button>
						<button type="button" class="btn btn-info libraryButtons" id="edit3">Edit</button>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-10">
						<div class="well">
							<a href="ProductPage.jsp"><h3 id="productTitle4">Book Something Something 4</h3></a>
							<label>Author: </label> <span id="productAuthor2"> Some Guy 2</span><br>
							<label>Publisher: </label><span id="productPublisher1"> Some People 1</span>
						</div>
					</div>
					<div class="col-sm-2 well">
						<button type="button" class="btn btn-primary libraryButtons" id="reserve4">Reserve</button>
						<button type="button" class="btn btn-info libraryButtons" id="edit4">Edit</button>
					</div>
				</div>     
			</div>
		  </div>
		</div>
	  
	  
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>