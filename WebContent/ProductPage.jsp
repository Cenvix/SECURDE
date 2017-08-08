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
			
			console.log("PRODUCT PAGE");
			initBook();
		});
		
		function initBook() {
			var book = (JSON.parse('${bookJSON}'));
			
			document.getElementById("productAuthor").innerHTML = book.author;
			document.getElementById("productTitle").innerHTML = book.name;
			document.getElementById("productType").innerHTML = book.type;
			document.getElementById("productPublisher").innerHTML = book.publisher;
			document.getElementById("productID").innerHTML = book.id;
			document.getElementById("productDesc").innerHTML = book.description;
			
		}
		</script>
	</head>

	<body>

		
		<div class="container">
			<div class="row">
				<h2 id="productTitle">BOOK TITLE</h2>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<div class="well" style="min-height:200px">
						<p>Author: <span id="productAuthor"></span></p>
						<p>Published by:  <span id="productPublisher">Some people</span></p>
						<p>Type:  <span id="productType">Book</span></p>
						<p>DDC: <span id="productID">123412341234</span></p>
					</div>
					<div class="well">
						<button type="button" class="btn btn-primary" style="width:100%" id="reserve">Reserve a Copy</button>
					</div>
				</div>
				
				<div class="col-sm-9">
					<div class="well" style="min-height:300px">
						<h3>Description:</h3>
						<p id="productDesc">
						Some sort of description here about the product. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
						Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
						Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
						</p>
					</div>
				</div>
			</div>
		</div>
		
		<div class="container">
			<div class="row well">
				<div class="col-sm-12">
					<h1>Write your review:</h1>
					<textarea class="form-control" rows="5" id="review"></textarea>
					<div style="margin-top:5px">
						<button type="button" class="btn btn-primary" id="submitReview">Submit Review</button>
					</div>
				</div>
			</div>
			
			<!--TODO when we compile everything: automate reviews-->
			<div class="row">
				<div class="well">
					<p>Review Title     by <span id="reviewerName1">that guy</span></p>
					<p id="review1">Review Content Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
				</div>
			</div>
			<div class="row">
				<div class="well">
					<p>Review Title     by <span id="reviewerName2">that guy</span></p>
					<p id="review2">Review Content Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
				</div>
			</div>
			<div class="row">
				<div class="well">
					<p>Review Title     by <span id="reviewerName3">that guy</span></p>
					<p id="review3">Review Content Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
				</div>
			</div>
			<div class="row">
				<div class="well">
					<p>Review Title     by <span id="reviewerName4">that guy</span></p>
					<p id="review4">Review Content Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
				</div>
			</div>
		</div>
	
	
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>