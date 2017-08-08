<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<%@ include file="header.jsp" %>
		
		<script type="text/javascript">

		$(document).ready(function(){
			var userID = '<%= session.getAttribute("userID")%>';
			console.log(userID);
			
			console.log("PRODUCT PAGE");
			init();
		});
		
		function init() {
			initBook();
			initReviews();
		}
		
		function initBook() {
			var book = (JSON.parse('${bookJSON}'));
			
			document.getElementById("productAuthor").innerHTML = book.author;
			document.getElementById("productTitle").innerHTML = book.name;
			document.getElementById("productType").innerHTML = book.type;
			document.getElementById("productPublisher").innerHTML = book.publisher;
			document.getElementById("productID").innerHTML = book.id;
			document.getElementById("productDesc").innerHTML = book.description;
		}
		
		function initReviews() {
			console.log("INIT REVIEWS");
			var reviews = (JSON.parse('${reviewsJSON}'));
			var names = (JSON.parse('${namesJSON}'));
			var results = "";
			
			for(var i = 0; i < reviews.length; i++) {
				results += "<div class='row'>" +
								"<div class='well'>" +
									"<h3>" + reviews[i].rating + "/5    by <span id='reviewerName"+i+"'>"+ names[i] +"</span></h3>" +
										"<p id='review"+i+"'>" + reviews[i].review + "</p>" +
								"</div>" + 
							"</div>";
			}
			
			document.getElementById("reviewContainer").innerHTML = results;
		}
		
		function submitReview() {
			var reviewScore = document.getElementById("reviewScore").value;
			var review = document.getElementById("review").value;
			var bookID = document.getElementById("productID").innerHTML;
			var userNumber = ${userNumber};
			
			$.ajax({
	            url: 'SubmitReview',
	            data: {
	                reviewScore: reviewScore,
	                review: review,
	                userNumber: userNumber,
	                bookID: bookID
	            },
	            type: 'POST',
				success:function(jsonobject){
					if(jsonobject=="true") {
						var newReview = "<div class='row'>" +
											"<div class='well'>" +
											"<h3>" + reviewScore + "/5    by <span id='reviewerNameNew'> ${userFirstName} ${userLastName}</span></h3>" +
												"<p id='newReview'>" + review + "</p>" +
											"</div>" + 
										"</div>";
						
						document.getElementById("reviewContainer").innerHTML = newReview + document.getElementById("reviewContainer").innerHTML;
					}
					else
						alert("Review was not submitted, please try again");
				}
	        });
		}
		</script>
	</head>

	<body>

		
		<div class="container">
			<div class="row">
				<h2 id="productTitle"></h2>
			</div>
			<div class="row">
				<div class="col-sm-3">
					<div class="well" style="min-height:200px">
						<p>Author: <span id="productAuthor"></span></p>
						<p>Published by:  <span id="productPublisher"></span></p>
						<p>Type:  <span id="productType"></span></p>
						<p>DDC: <span id="productID"></span></p>
					</div>
					<div class="well">
						<button type="button" class="btn btn-primary" style="width:100%" id="reserve">Reserve a Copy</button>
					</div>
				</div>
				
				<div class="col-sm-9">
					<div class="well" style="min-height:300px">
						<h3>Description:</h3>
						<p id="productDesc"></p>
					</div>
				</div>
			</div>
		</div>
		
		<div class="container">
			<div class="row well">
				<div class="col-sm-12">
					<c:choose>
					  	<c:when test="${empty userID}">
					    	<h1>Write your review:</h1>
							<span>Score: <input type="number" name="quantity" min="1" max="5" style="max-width:50px" disabled></span>
							<textarea class="form-control" rows="5" id="review" style="margin-top:10px" disabled>Please login to submite review</textarea>
							<div style="margin-top:5px">
								<button type="button" class="btn btn-primary" id="submitReview" disabled>Submit Review</button>
							</div>
					  	</c:when>
					  	<c:otherwise>
					  		<h1>Write your review:</h1>
							<span>Score: <input id="reviewScore" type="number" name="quantity" min="1" max="5" style="max-width:50px"></span>
							<textarea class="form-control" rows="5" id="review" style="margin-top:10px"></textarea>
							<div style="margin-top:5px">
								<button type="button" class="btn btn-primary" id="submitReview" onclick="submitReview()">Submit Review</button>
							</div>
					  	</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			<!--TODO when we compile everything: automate reviews-->
			<div id = reviewContainer></div>
		</div>
	
	
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="js/bootstrap.min.js"></script>
	</body>
</html>