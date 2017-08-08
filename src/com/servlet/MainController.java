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
import com.beans.User;
import com.google.gson.Gson;
import com.octo.captcha.Captcha;
import com.octo.captcha.service.CaptchaServiceException;
import com.services.AuthorityCheckerService;
import com.services.BookService;
import com.services.EncryptionService;
import com.services.MeetingRoomService;
import com.services.ReviewService;
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
	private void searchBooks(HttpServletRequest request, HttpServletResponse response,
								@RequestParam("query") String query, @RequestParam("filterMagazine") String magazineFilter, 
								@RequestParam("filterThesis") String thesisFilter, @RequestParam("filterBook") String bookFilter)throws ServletException, IOException{
		System.out.println("SEARCH BOOKS");
		
		boolean filterMagazine = thesisFilter != null;
		boolean filterThesis = magazineFilter != null;
		boolean filterBook = bookFilter != null;

		ArrayList<Book> books = BookService.searchBooks(query, filterMagazine, filterThesis, filterBook);
		
		request.setAttribute("books", books);
		request.getRequestDispatcher("LibraryPage.jsp").forward(request, response);
		
		PrintWriter pw = response.getWriter();
		pw.write("true");
	}

	//DONE
	@RequestMapping(value="/ReserveRoom", method = RequestMethod.POST)
	@ResponseBody
	private String reserveRoom(@RequestParam("timeStart") String timeStart, @RequestParam("room") String room) throws IOException {
		MeetingRoomBooking mrb = new MeetingRoomBooking();
		mrb.setTimeStart(Integer.parseInt(timeStart));
		mrb.setTimeEnd(Integer.parseInt(timeStart)+100);
		mrb.setIdMeetingRoom(Integer.parseInt(room));
		mrb.setDate(new Date(Calendar.getInstance().getTime().getTime()));
		mrb.setIduser(1234); //TODO Change this to proper user id
		mrb.setId((int)(Math.random()*100));
		
		boolean out = MeetingRoomService.addMeetingRoomBooking(mrb);
		
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
		request.getRequestDispatcher("RoomReservations.jsp").forward(request, response);
	}

	
	@RequestMapping(value="/ReserveBook", method = RequestMethod.POST)
	@ResponseBody
	private String reserveBook(@RequestParam("idbook")String idbook) throws IOException {
		System.out.println("ReserveBook");
		boolean out = BookService.reserveBook(idbook);
		
		return out+"";
	}

	@RequestMapping(value="/Library", method = RequestMethod.GET)
	private void libraryInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Book> books = BookService.getAllBooks();
		request.setAttribute("books", books);
		request.getRequestDispatcher("LibraryPage.jsp").forward(request, response);
	}
	
	@RequestMapping(value="/ViewProduct", method = RequestMethod.POST)
	private void viewProduct(@RequestParam("bookID") int id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	//private void viewProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("VIEWING PRODUCT");
		
		Book product = BookService.getBook(id);
		String productJSON = new Gson().toJson(product);
		
		ArrayList<Review> reviews = ReviewService.getBookReviews(id);
		String reviewsJSON = new Gson().toJson(reviews);
		
		ArrayList<String> names = new ArrayList();
		for(int i = 0; i < reviews.size(); i++) {
			User user = UserService.getUser(reviews.get(i).getUserID());
			names.add(user.getFirstName() + " " + user.getLastName());
		}
		String namesJSON = new Gson().toJson(names);
		
		request.setAttribute("bookJSON", productJSON);
		request.setAttribute("reviewsJSON", reviewsJSON);
		request.setAttribute("namesJSON", namesJSON);
		request.getRequestDispatcher("ProductPage.jsp").forward(request, response);
	}

	@RequestMapping(value="/AdminInit", method = RequestMethod.GET)
	private void adminInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ArrayList<User> admins = UserService.getAllAdmins();
		String json = new Gson().toJson(admins);
		request.setAttribute("admins", json);
		request.getRequestDispatcher("AdminPage.jsp").forward(request, response);
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
													@RequestParam("password") String password){
		System.out.println("Login");

		User user = new User();
		user.setEmail(email);
		user.setPassword(password);
		ArrayList<String> out = UserService.loginUser(user);
		
		boolean status = false;
		
		if(out.size()>0){
			user.setId(Integer.parseInt(out.get(0)));
			
			setUserSessions(request, user);
			status = true;
		}
		return ""+status;
		
		
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
	public String register(HttpServletRequest request,@ModelAttribute("User") User newUser,@RequestParam("grecaptcharesponse") String cap )throws ServletException, IOException{
		System.out.println("Register");
		System.out.println(cap);
		newUser.setNewId();
		newUser.setUserType("0");
		
		
		
		EncryptionService encode = new EncryptionService();
		newUser.setPassword(encode.encryptPass(newUser.getPassword()));
		newUser.setSecretAnswer(encode.encryptPass(newUser.getSecretAnswer()));
		
		ResponseOut out = new ResponseOut();
		
		if(this.processCaptcha(request, cap)){
			if(UserService.checkUser(newUser)){
				if(UserService.addUser(newUser)){
					out.setSucess(true);
				}else
					out.setMessage("ID Number or Email is already Taken");
			}
			//new Gson().toJson(book)
		}else
			out.setMessage("Please Verify your Humanity");
	
		

		if(out.isSucess())
		setUserSessions(request, newUser);

		return new Gson().toJson(out);
	}
	
	
	public void setUserSessions(HttpServletRequest request, User user){
		
		HttpSession session;
		session = request.getSession(true);
		
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
	public String addEmployee(@ModelAttribute("User") User newUser)throws ServletException, IOException{
		System.out.println("AddEmployee");
		
		

		EncryptionService encode = new EncryptionService();
		newUser.setPassword(encode.encryptPass(newUser.getPassword()));
		newUser.setSecretAnswer(encode.encryptPass(newUser.getSecretAnswer()));
		
		
		boolean status=false;
		
		if(UserService.checkUser(newUser)){
			if(UserService.addUser(newUser)){
				status = true;
				System.out.println("Added");
			}
		}
		
		//setUserSessions(request, response, newUser);

		return(status+"");
	}
	
	//DONE
	@RequestMapping(value="/AddBook", method = RequestMethod.POST)
	@ResponseBody
	public String addBook(@ModelAttribute("Book") Book book)throws ServletException, IOException{
		System.out.println("AddBook");
		

		System.out.println(book.getId());

		Random r =new Random();
		book.setId(r.nextInt(9999));
		
		System.out.println(book.getId());

		
		boolean status=false;
		
		if(!BookService.checkBook(book.getId())){
			
			if(BookService.addBook(book)){
				status = true;
			}
		}
		
		//setUserSessions(request, response, newUser);

		//PrintWriter pw = response.getWriter();
		return status+"";
	}
	
	
	//DONE
	@RequestMapping(value="/EditBook", method = RequestMethod.POST)
	@ResponseBody
	public String editBook(@ModelAttribute("Book") Book editedBook)throws ServletException, IOException{
		System.out.println("EditBook");
		
		boolean status=false;

		if(BookService.checkBook(editedBook.getId())){
			if(BookService.editBook(editedBook)){
				status = true;
				System.out.println("Edited");
			}
		}
		
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
	public String deleteBook(@RequestParam("bookid") int bookid)throws ServletException, IOException{
		System.out.println("DeleteBook");
		
		boolean status=false;

		if(BookService.checkBook(bookid)){
			if(BookService.deleteBook(bookid)){
				status = true;
				System.out.println("deleted");
			}
		}
		
		//setUserSessions(request, response, newUser);

		return(status+"");
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
