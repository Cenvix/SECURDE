package com.servlet;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import com.Captcha.CaptchaSettings;
import com.beans.Book;
import com.beans.GoogleResponse;
import com.beans.MeetingRoomBooking;
import com.beans.ResponseOut;
import com.beans.Review;
import com.beans.Transaction;
import com.beans.User;
import com.google.gson.Gson;

import com.services.AuthorityCheckerService;
import com.services.BookService;
import com.services.EncryptionService;
import com.services.MeetingRoomService;
import com.services.ReviewService;
import com.services.TransactionService;
import com.services.UserService;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.sun.media.jfxmedia.logging.Logger;

/**
 * Servlet implementation class Controller
 */



@RestController
@Scope("session")
public class MainController{
	
	
	public static final String sessionUserID = "userID";
	
	private static final long serialVersionUID = 1L;
	
/*
	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String servletPath = request.getServletPath();
		
		switch(servletPath){
//		case "/Login": login(request,response); break;
//		case "/Logout": logout(request,response); break;
//		case "/Register": register(request,response); break;
//		case "/AddEmployee": addEmployee(request,response); break;
//		case "/EditBook": editBook(request,response);break;
//		case "/LibraryInit": libraryInit(request, response); break;
//		case "/AdminInit": adminInit(request, response); break;
//		case "/ReserveBook": reserveBook(request,response); break;
//		case "/BookingsInit": bookingsInit(request, response); break;
//		case "/ReserveRoom": reserveRoom(request, response); break;
//		case "/SearchBooks": searchBooks(request, response); break;
//		case "/EditProduct": editProduct(request, response); break;
//		case "/DeleteBook": deleteBook(request,response); break;
//		case "/GetBook": getBook(request,response); break;
//		case "/AddBook": addBook(request, response); break;
//		default: home(request,response); break;
		}
	}
*/
	
	//DONE - Review if time later
	@RequestMapping(value="/SearchBooks", method = RequestMethod.POST)
	@ResponseBody
	private String searchBooks(HttpServletRequest request, HttpServletResponse response,
								@RequestParam("query") String query, @RequestParam("filterMagazine") boolean magazineFilter, 
								@RequestParam("filterThesis") boolean thesisFilter, @RequestParam("filterBook") boolean bookFilter)throws ServletException, IOException{
		System.out.println("SEARCH BOOKS");

		ArrayList<Book> books = BookService.searchBooks(query, magazineFilter, thesisFilter, bookFilter);
		
		String booksJSON = new Gson().toJson(books);
		return booksJSON;
	}

	//DONE
		@RequestMapping(value="/ReserveRoom", method = RequestMethod.POST)
		@ResponseBody
		private String reserveRoom(@RequestParam("timeStart") String timeStart, @RequestParam("room") String room,@RequestParam("userID") String userID) throws IOException {
			MeetingRoomBooking mrb = new MeetingRoomBooking();
			mrb.setTimeStart(Integer.parseInt(timeStart));
			mrb.setTimeEnd(Integer.parseInt(timeStart)+100);
			mrb.setIdMeetingRoom(Integer.parseInt(room));
			mrb.setDate(new Date(Calendar.getInstance().getTime().getTime()));
			mrb.setIduser(Integer.parseInt(userID));
			mrb.setId((int)(Math.random()*100));
			
			System.out.println(mrb.getIduser());
			boolean out = false;
			if(!MeetingRoomService.checkDoubleBook(userID)){
				out = MeetingRoomService.addMeetingRoomBooking(mrb);
			}
			return out+"";
		}
		
		//DONE
				@RequestMapping(value="/RemoveRoom", method = RequestMethod.POST)
				@ResponseBody
				private String removeRoom(@RequestParam("timeStart") String timeStart, @RequestParam("room") String room) throws IOException {
				
					boolean out = false;
					out = MeetingRoomService.removeMeetingRoomBooking(Integer.parseInt(timeStart), Integer.parseInt(room));
					
					return out+"";
				}
	//DONE
	@RequestMapping(value="/AddProduct", method = RequestMethod.GET)
	private void productAddInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getSession().getAttribute("userType")!=null) {
			int type = Integer.parseInt(request.getSession().getAttribute("userType").toString());
			
			if(AuthorityCheckerService.isManager(type) || AuthorityCheckerService.isStaff(type)) {
				response.sendRedirect("ProductAdd.jsp");
			}
			else {
				response.sendRedirect("AccessDenied.jsp");
			}
		}
		else {
			response.sendRedirect("AccessDenied.jsp");
		}
	}

	@RequestMapping(value="/Bookings", method = RequestMethod.GET)
	private void bookingsInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<MeetingRoomBooking> bookings = MeetingRoomService.getMeetingRoomBookings();
		request.setAttribute("bookings", bookings);
		if(request.getSession().getAttribute("userType")!=null){
			request.getRequestDispatcher("RoomReservations.jsp").forward(request, response);
		}else{
			request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
			
		}

	}

	
	@RequestMapping(value="/ReserveBook", method = RequestMethod.POST)
	@ResponseBody
	private String reserveBook(@RequestParam("idbook")String idbook, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		Transaction t = new Transaction();
		boolean out = false;
		boolean transaction = false;
		Book book = BookService.getBook(Integer.parseInt(idbook));
		t.setIdBook(book.getId());
		t.setIdUser(Integer.parseInt(request.getSession().getAttribute("userID").toString()));
		t.setStatus("borrowed");
		//borrow date 
		
		if(request.getSession().getAttribute("userID") != null) {
			System.out.println("ReserveBook");
			out = BookService.reserveBook(idbook);
			transaction = TransactionService.addTransaction(t);
			System.out.println(transaction);
		}
		else
			request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
		
		return out+"";
	}

	@RequestMapping(value="/Library", method = RequestMethod.GET)
	private void libraryInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		if(request.getSession().getAttribute("userID")==null){
			request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
		}
		else {
			ArrayList<Book> books = BookService.getAllBooks();
			
			request.setAttribute("books", books);
			request.getRequestDispatcher("LibraryPage.jsp").forward(request, response);
		}
		
}
	
	@RequestMapping(value="/ViewProduct", method = RequestMethod.POST)
	private void viewProduct(@RequestParam("bookID") int id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	//private void viewProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("VIEWING PRODUCT");
		if(request.getSession().getAttribute("userID")==null){
			request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
		}
		else {
			Book product = BookService.getBook(id);
			String productJSON = new Gson().toJson(product);
			
			ArrayList<Review> reviews = ReviewService.getBookReviews(id);
			String reviewsJSON = new Gson().toJson(reviews);
			
			ArrayList<String> names = new ArrayList();
			boolean isDone=false;
			
			User myUser = UserService.getUser((Integer)(request.getSession().getAttribute("userID")));
			for(int i = 0; i < reviews.size(); i++) {
				User user = UserService.whoseUserNumber(reviews.get(i).getUserID());
				names.add(user.getFirstName() + " " + user.getLastName());
				System.out.println(myUser.getUserNumber()+" "+reviews.get(i).getUserID());
				if(myUser.getUserNumber().equals(reviews.get(i).getUserID()+""))
					isDone =true;
			}
			String namesJSON = new Gson().toJson(names);
			
			request.setAttribute("bookJSON", productJSON);
			request.setAttribute("reviewsJSON", reviewsJSON);
			request.setAttribute("namesJSON", namesJSON);
			request.setAttribute("isDone", new Gson().toJson(isDone));
			request.getRequestDispatcher("ProductPage.jsp").forward(request, response);
		}
	}

	@RequestMapping(value="/AdminInit", method = RequestMethod.GET)
	private void adminInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		if(request.getSession().getAttribute("userID") != null) {
			if(AuthorityCheckerService.isAdmin(Integer.parseInt(request.getSession().getAttribute("userType").toString()))) {
				ArrayList<User> admins = UserService.getAllAdmins();
				String json = new Gson().toJson(admins);
				request.setAttribute("admins", json);
				request.getRequestDispatcher("AdminPage.jsp").forward(request, response);
			}
			else
				request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);
		}
		else
			request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);
	}
	
	@RequestMapping(value="/AddEmployees", method = RequestMethod.GET)
	private void employeeAddInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getSession().getAttribute("userType")!=null) {
			int type = Integer.parseInt(request.getSession().getAttribute("userType").toString());
			
			if(AuthorityCheckerService.isAdmin(type)) {
				request.getRequestDispatcher("EmployeeAdd.jsp").forward(request, response);
			}
			else {
				request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);
			}
		}
		else {
			request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);
		}
	}
	
	@RequestMapping(value="/Home")
	public void home(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("Home");
		if(request.getSession().getAttribute("userType")!=null) {
			int type = Integer.parseInt(request.getSession().getAttribute("userType").toString());
			
			if(AuthorityCheckerService.isAdmin(type)) {
				request.getRequestDispatcher("AdminInit").forward(request, response);
			}
			else if(AuthorityCheckerService.isManager(type)) {
				request.getRequestDispatcher("ManagementPage.jsp").forward(request, response);
			}
			else {
				request.getRequestDispatcher("Home.jsp").forward(request, response);
			}
		}
		else {
			request.getRequestDispatcher("Home.jsp").forward(request, response);
		}
	}
	
	//DONE
	@RequestMapping(value="/Login", method = RequestMethod.POST)
	@ResponseBody
	public String login(HttpServletRequest request,	@RequestParam("email") String email,
													@RequestParam("password") String password,
													@RequestParam("grecaptcharesponse") String cap ){
		System.out.println("Login");
		
		Pattern p = Pattern.compile("([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})");
		Matcher m = p.matcher(email);
		boolean validEmail = m.matches();

		User user = new User();
		user.setEmail(email);
		user.setPassword(password);
		ResponseOut resp = new ResponseOut();
		
			if((Integer)request.getSession().getAttribute("attemps")==null)
			setAttempsSessions(request,1);
			else
				setAttempsSessions(request, (Integer)request.getSession().getAttribute("attemps")+1);
			

			if(validEmail) {
			ArrayList<String> out = UserService.loginUser(user);
			
			if((Integer)request.getSession().getAttribute("attemps")>3){
				if(this.processCaptcha(request, cap)){
					if(out.size()>0){
						user.setId(Integer.parseInt(out.get(0)));
						
						setUserSessions(request, user);
						resp.setSucess(true);
					}else{
						resp.setMessage("Wrong Username or Password");
					}
				}else
					resp.setMessage("Please verify your humanity");
			}else{
				if(out.size()>0){
					user.setId(Integer.parseInt(out.get(0)));
					
					setUserSessions(request, user);
					resp.setSucess(true);
				}else{
					resp.setMessage("Wrong Username or Password");
				}
			}
		}
		else {
			resp.setMessage("Invalid Email");
		}
		
		return new Gson().toJson(resp);

	}
	
	//DONE
	@RequestMapping(value="/Logout", method = RequestMethod.GET)
	public void logout(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		HttpSession session = request.getSession();
		System.out.println("Sign Out: "+session.getAttribute(sessionUserID));
		session.invalidate();
		response.sendRedirect("Home.jsp");
	}
	
	
	//DONE
	@RequestMapping(value="/Register", method = RequestMethod.POST)
	@ResponseBody
	public String register(HttpServletRequest request, @ModelAttribute("User") User newUser,@RequestParam("grecaptcharesponse") String cap )throws ServletException, IOException{
		System.out.println("Register");
		//System.out.println(cap);
		newUser.setNewId();
		newUser.setUserType("0");
		
		boolean validEmail;
		boolean validPass;
		boolean isMissingInput;
		
		Pattern p = Pattern.compile("([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5})");
		Matcher m = p.matcher(newUser.getEmail());
		validEmail = m.matches();
		
		p = Pattern.compile(".{8,}");
		m = p.matcher(newUser.getPassword());
		validPass = m.matches();
		
		isMissingInput = newUser.getFirstName().equals("") || newUser.getLastName().equals("") || newUser.getEmail().equals("") || newUser.getPassword().equals("")
				|| newUser.getSecretQuestion().equals("") || newUser.getSecretAnswer().equals("") || newUser.getUserNumber().equals("") || newUser.getUserType().equals("");
		
		ResponseOut out = new ResponseOut();
		
		if(validEmail && validPass && !isMissingInput) {
			EncryptionService encode = new EncryptionService();
			newUser.setPassword(encode.encryptPass(newUser.getPassword()));
			newUser.setSecretAnswer(encode.encryptPass(newUser.getSecretAnswer()));
			
			if(this.processCaptcha(request, cap)){
				if(UserService.checkUser(newUser)){
					if(UserService.addUser(newUser)){
						out.setSucess(true);
					}else
						out.setMessage("Check the ID Number or Email, Account might exist already");
				}else
					out.setMessage("Check the ID Number or Email, Account might exist already");
			}else
				out.setMessage("Please Verify that you are a person");
		}
		else
			out.setMessage("One or more of your entries is invalid, try again");
		
		if(out.isSucess())
		setUserSessions(request, newUser);

		return new Gson().toJson(out);
	}
	
	
	public void setUserSessions(HttpServletRequest request, User user){
		
		HttpSession session;
		
		session = request.getSession();

		// Get session creation time.
	    Date createTime = new Date(session.getCreationTime());
	         
	    // Get last access time of this web page.
	    Date lastAccessTime = new Date(session.getLastAccessedTime());
	    User sessionUser = UserService.getUser(user.getId());
	    

        session.setAttribute("userID", sessionUser.getId());
        session.setAttribute("userType", sessionUser.getUserType());
        session.setAttribute("userNumber", sessionUser.getUserNumber());
        session.setAttribute("userFirstName", sessionUser.getFirstName());
        session.setAttribute("userLastName", sessionUser.getLastName());
        
	}

	
	
	public void setAttempsSessions(HttpServletRequest request, int a){
		
		HttpSession session;
		session = request.getSession();
		
		// Get session creation time.
	    Date createTime = new Date(session.getCreationTime());
	         
	    // Get last access time of this web page.
	    Date lastAccessTime = new Date(session.getLastAccessedTime());
	   session.setAttribute("attemps", a);
	}
	
	
	public boolean processCaptcha(HttpServletRequest request,String cap){
		CaptchaSettings captchaSettings = new CaptchaSettings();
		RestTemplate rest = new RestTemplate();
		System.out.println(request.getRemoteAddr());
        URI verifyUri = URI.create(String.format(
                "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s&remoteip=%s",
                captchaSettings.getSecret(), cap, request.getRemoteAddr()));
       
              GoogleResponse googleResponse = rest.getForObject(verifyUri, GoogleResponse.class);
       
              return googleResponse.isSuccess();
	}
	
	
	@RequestMapping(value="/AddEmployee", method = RequestMethod.POST)
	@ResponseBody
	public String addEmployee(@ModelAttribute("User") User newUser, HttpServletRequest request, HttpServletResponse response,@RequestParam("grecaptcharesponse") String cap )throws ServletException, IOException{
		System.out.println("AddEmployee");
		ResponseOut status = new ResponseOut();
		
		
		if(request.getSession().getAttribute("userID") != null) {
			if(AuthorityCheckerService.isAdmin(Integer.parseInt(request.getSession().getAttribute("userType").toString()))) {
				EncryptionService encode = new EncryptionService();
				newUser.setPassword(encode.encryptPass(newUser.getPassword()));
				newUser.setSecretAnswer(encode.encryptPass(newUser.getSecretAnswer()));
				
				if(processCaptcha(request, cap)){
					if(UserService.checkUser(newUser)){
						if(UserService.addUser(newUser)){
							status.setSucess(true);
							System.out.println("Added");
						}else
							status.setMessage("Check the ID Number or Email, Account might exist already");
					}else
						status.setMessage("Check the ID Number or Email, Account might exist already");
				}else{
					status.setMessage("Verify your Humanity");
				}
			}
			else
				request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);
		}
		else
			request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);

		return new Gson().toJson(status);
	}
	
	//DONE
	@RequestMapping(value="/AddBook", method = RequestMethod.POST)
	@ResponseBody
	public String addBook(@ModelAttribute("Book") Book book, HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("AddBook");
		boolean status=false;

		if(request.getSession().getAttribute("userID") != null) {
			int type = Integer.parseInt(request.getSession().getAttribute("userType").toString());
			if(AuthorityCheckerService.isManager(type) || AuthorityCheckerService.isStaff(type)) {
				Random r =new Random();
				book.setId(r.nextInt(9999));
				
				if(!BookService.checkBook(book.getId())){
					if(BookService.addBook(book)){
						status = true;
					}
				}
			}
			else
				request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);
		}
		else
			request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);
		
		return status+"";
	}
	
	
	//DONE
	@RequestMapping(value="/EditBook", method = RequestMethod.POST)
	@ResponseBody
	public String editBook(@ModelAttribute("Book") Book editedBook, HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("EditBook");
		
		boolean status=false;

		if(request.getSession().getAttribute("userID") != null) {
			int type = Integer.parseInt(request.getSession().getAttribute("userType").toString());
			if(AuthorityCheckerService.isManager(type) || AuthorityCheckerService.isStaff(type)) {
				if(BookService.checkBook(editedBook.getId())){
					if(BookService.editBook(editedBook)){
						status = true;
						System.out.println("Edited");
					}
				}
			}
			else
				request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);
		}
		else
			request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);
		
		
		
		//setUserSessions(request, response, newUser);

		return status +"";
	}

	@RequestMapping(value="/GetBook", method = RequestMethod.POST)
	public void getBook(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("GetBook");
		int bookid = Integer.parseInt(request.getParameter("bookID"));
		
		Book book = null;
		
		if(BookService.checkBook(bookid)){
			book = BookService.getBook(bookid);
				System.out.println("Got");
			
		}

		PrintWriter pw = response.getWriter();
		pw.write(new Gson().toJson(book));
	}
		
	@RequestMapping(value="/DeleteBook", method = RequestMethod.POST)
	@ResponseBody
	public String deleteBook(@RequestParam("bookid") int bookid, HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("DeleteBook");
		
		boolean status=false;
		
		if(request.getSession().getAttribute("userID") != null) {
			int type = Integer.parseInt(request.getSession().getAttribute("userType").toString());
			if(AuthorityCheckerService.isManager(type) || AuthorityCheckerService.isStaff(type)) {
				if(BookService.checkBook(bookid)){
					if(BookService.deleteBook(bookid)){
						status = true;
						System.out.println("deleted");
					}
				}
			}
			else
				request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);
		}
		else
			request.getRequestDispatcher("AccessDenied.jsp").forward(request, response);
		
		//setUserSessions(request, response, newUser);

		return(status+"");
	}
	
	@RequestMapping(value="/SubmitReview", method=RequestMethod.POST)
	@ResponseBody
	public String submitReview(@ModelAttribute("review") Review r,
								HttpServletRequest request, HttpServletResponse response) {
		
		System.out.println("SUBMITTING REVIEW");
		
		boolean isSuccess = ReviewService.addReview(r);
		
		return ""+isSuccess;
	}
	
	@RequestMapping(value="/ForgotPassword", method=RequestMethod.GET)
	public void forgotPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("ForgotPassword.jsp").forward(request, response);
	}

	@RequestMapping(value="/ForgotPasswordEmail", method=RequestMethod.POST)
	@ResponseBody
	public String forgotPasswordEmail(@RequestParam("email") String email, HttpServletRequest request, HttpServletResponse response) {
		boolean isSuccess = false;
		
		User user = UserService.whoseEmail(email);
		request.setAttribute("userQuestion", user.getSecretQuestion());
		isSuccess = true;
		
		return ""+user.getSecretQuestion();
	}
	
	@RequestMapping(value="/ForgotPasswordAnswer", method=RequestMethod.POST)
	@ResponseBody
	public String forgotPasswordAnswer(	@RequestParam("email") String email, 
										@RequestParam("answer") String answer, 
										@RequestParam("newPass") String newPass,
										@RequestParam("grecaptcharesponse") String cap,
										HttpServletRequest request,
										HttpServletResponse response) {
		
		ResponseOut resp = new ResponseOut();
		
		User user = UserService.whoseEmail(email);
		user.setSecretAnswer(answer);
		
		if(this.processCaptcha(request, cap)){
		ArrayList<String> out = UserService.loginUserSecret(user);
			if(out.size()>0){

				EncryptionService encode = new EncryptionService();
				
				user.setId(Integer.parseInt(out.get(0)));

				user.setPassword(encode.encryptPass(newPass));
				
				UserService.passwordChange(user.getPassword(), user.getId());
				
				setUserSessions(request, user);
				resp.setSucess(true);
			}else{
				resp.setMessage("Wrong Answer");
			}
		}else{
			resp.setMessage("Verify yourself earthling!");
		}
		
		
		return new Gson().toJson(resp);
	}
	
	@RequestMapping(value="/LoginPage", method=RequestMethod.GET)
	public void loginPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("LoginPage.jsp").forward(request, response);
	}
//	@RequestMapping(value="/EditProduct", method = RequestMethod.POST)
//	public void editProduct(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
//		System.out.println("EditProduct");
//
//		request.getSession().setAttribute("productID", request.getParameter("bookID"));
//
//	
//	}

}
