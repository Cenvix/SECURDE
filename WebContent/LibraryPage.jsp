<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	
		
		<%@ include file="header.jsp" %>
		
		<script type="text/javascript">
		var books = [];

		$(document).ready(function(){
			var userID ='<%= session.getAttribute("userID")%>';
			console.log(userID);
			
			if(canUserModify()) {
				document.getElementById('addBookContainer').innerHTML = "<div class='well'><button type='button' class='btn btn-primary' style='width:100%;' id='save' onclick='addProduct()'>Add a Book!</button></div>";
			}
			
			initBooks();
			loadBooks();
		});
		
		class Book {
			constructor(name, publisher, author, id, status) {
				this.name = name;
				this.publisher = publisher;
				this.author = author;
				this.id = id;
				this.status = status;
			};
		}
		
		function addProduct(){
			window.location = "AddProduct";
		}
		
		function addBook(name, publisher, author, id, status) {
			var book = new Book(name, publisher, author, id, status);
			books.push(book);
		}
		
		function canUserModify(){
			if("${userType}" == "1" || "${userType}" == "2") {
				return true;
			}
			
			return false;
		}
		
		function viewProduct(id) {
			document.getElementById("invisFormContainer").innerHTML = "<form id='invisForm' action='ViewProduct' method='post'><input type='hidden' name='bookID' value='"+id+"''></form>";
			document.getElementById("invisForm").submit();
		}
		
		function initBooks(){
			books = [];
			console.log("Initializing books");
			<c:forEach items="${books}" var="b">
        	addBook("${b.name}", "${b.publisher}", "${b.author}", "${b.id}", "${b.status}");
        	</c:forEach>
        	
        }
		
		function loadBooks() {
			document.getElementById('resultsContainer').innerHTML = "";
			var results = "";
			
			for(var i = 0; i < books.length; i++) {
				results += "<div class='row'>" +
								"<div class='col-sm-9'>" +
									"<div class='well' style='min-height:157px'>" +
										"<h3 id='productTitle_" + books[i].id + "'>" + books[i].name + "</h3>" +
										"<label>Author: </label> <span id='productAuthor_" + books[i].id + "'>" + books[i].author + "</span><br>" +
										"<label>Publisher: </label><span id='productPublisher_" + books[i].id + "'>" + books[i].publisher + "</span>" +
									"</div>" +
								"</div>" +
								"<div class='col-sm-3 well'>" +
									"<button type='button' class='btn btn-primary libraryButtons' style='width:100%' onclick='viewProduct("+books[i].id+")'>View</button>";
									
				if(books[i].status == "Reserved") {
					results += 		"<button type='button' class='btn btn-primary libraryButtons' style='width:100%' id='reserve_" + books[i].id + "' disabled='true'>RESERVED</button>";
									
				}
				else {
					results += 		"<button type='button' class='btn btn-primary libraryButtons' style='width:100%' id='reserve_" + books[i].id + "' onclick='reserveBook("+books[i].id+")'>Reserve</button>";	
				}
				
				if(canUserModify()) {
					results +=		"<button type='button' class='btn btn-info libraryButtons' style='width:100%' id='edit_" + books[i].id + "' onclick='editBook("+books[i].id+")'>Edit</button>";
				}
				
				results += "</div> </div>";
			}
			
			document.getElementById('resultsContainer').innerHTML = results;
		}
		
		function editBook(id){
			$.ajax({
                url: 'EditProduct',
                data: {
                    bookID: id
                },
                type: 'POST',
				success:function(jsonobject){
						window.location = "ProductEdit.jsp";
					}
            });
		}
		
		
		function reserveBook(id) {
			$.ajax({
                url: 'ReserveBook',
                data: {
                    idbook: id
                },
                type: 'POST',
				success:function(jsonobject){
					
							if(jsonobject=="true"){
	   		            	 	document.getElementById("reserve_"+id).innerHTML="RESERVED";
	   		               		document.getElementById("reserve_"+id).disabled=true;
							} else
								alert("Reservation Failed");
						   	
						}
            });
		}
		
		function searchBooks() {
			$.ajax({
                url: 'SearchBooks',
                data: {
                	query: document.getElementById("searchQuery").value,
                    filterMagazine: $('filterMagazine').is(':checked'),
					filterThesis: $('filterThesis').is(':checked'),
					filterBook: $('filterBook').is(':checked')
                },
                type: 'POST',
                success:function(jsonobject){
					
					if(jsonobject=="true"){
						initBooks();
		            	loadBooks();
					} else {
						alert("Search Failed");
					initBooks();
					loadBooks();
					}
				   	
				}
            });
			
		}
		</script>
	</head>
	
	<body>
		<div class="container">    
		  <div class="row">
			<div class="col-sm-3">
				<form action="SearchBooks" method="post" class="well">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Search" id="searchQuery" name="query">
						<div class="input-group-btn">
							<button class="btn btn-default" type="submit" id="searchSubmit">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
					</div>
					
					<div style="margin-left:50px">
						<div class="checkbox">
							<label><input type="checkbox" value="filterBook" id="filterBook" name="filterBook">Book</label>
						</div>
						<div class="checkbox">
							<label><input type="checkbox" value="filterMagazine" id="filterMagazine" name="filterMagazine">Magazine</label>
						</div>
						<div class="checkbox disabled">
							<label><input type="checkbox" value="filterThesis" id="filterThesis" name="filterThesis">Thesis</label>
						</div>
					</div>
				</form>
				
				<div id="addBookContainer"></div>
			</div>
			
			<!--TODO when we compile everything: Automate generation of search results-->
			<!--TODO when we compile everything: Make edit button dependent on user authorization-->
			<div class="col-sm-9" id="resultsContainer"></div>
					
		  </div>
		</div>
		
		<div id="invisFormContainer" style="visibiliy:false"></div>
	  
	  
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>