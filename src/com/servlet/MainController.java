package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import com.beans.Book;
import com.beans.MeetingRoomBooking;
import com.beans.User;
import com.google.gson.Gson;
import com.services.BookService;
import com.services.MeetingRoomService;
import com.services.UserService;
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
	
	@RequestMapping(value="/SearchBooks", method = RequestMethod.GET)
	private void searchBooks(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		// TODO Auto-generated method stub
		//System.out.println("SEARCH BOOKS");
		System.out.println("SEARCH BOOKS");
		String query = request.getParameter("query");
		boolean filterMagazine = request.getParameter("filterMagazine")!=null;
		boolean filterThesis = request.getParameter("filterThesis")!=null;
		boolean filterBook = request.getParameter("filterBook")!=null;
		
		ArrayList<Book> books = BookService.searchBooks(query, filterMagazine, filterThesis, filterBook);
		request.setAttribute("books", books);
		request.getRequestDispatcher("LibraryPage.jsp").forward(request, response);
		
		//System.out.println(books.size());
		
		PrintWriter pw = response.getWriter();
		pw.write("true");
	}

	@RequestMapping(value="/ReserverRoom", method = RequestMethod.POST)
	private void reserveRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
		MeetingRoomBooking mrb = new MeetingRoomBooking();
		mrb.setTimeStart(Integer.parseInt(request.getParameter("timeStart")));
		mrb.setTimeEnd(Integer.parseInt(request.getParameter("timeStart"))+100);
		mrb.setIdMeetingRoom(Integer.parseInt(request.getParameter("room")));
		mrb.setDate(new Date(Calendar.getInstance().getTime().getTime()));
		mrb.setIduser(1234); //TODO Change this to proper user id
		mrb.setId((int)(Math.random()*100));
		
		boolean out = MeetingRoomService.addMeetingRoomBooking(mrb);
		
		PrintWriter pw = response.getWriter();
		pw.write(out+"");
	}

	@RequestMapping(value="/BookingsInit", method = RequestMethod.GET)
	private void bookingsInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<MeetingRoomBooking> bookings = MeetingRoomService.getMeetingRoomBookings();
		request.setAttribute("bookings", bookings);
		request.getRequestDispatcher("RoomReservations.jsp").forward(request, response);
	}

	@RequestMapping(value="/ReserveBook", method = RequestMethod.POST)
	private void reserveBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
		boolean out = BookService.reserveBook(request.getParameter("idbook"));
		
		PrintWriter pw = response.getWriter();
		pw.write(out+"");
	}

	@RequestMapping(value="/LibraryInit", method = RequestMethod.GET)
	private void libraryInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Book> books = BookService.getAllBooks();
		request.setAttribute("books", books);
		request.getRequestDispatcher("LibraryPage.jsp").forward(request, response);
	}

	@RequestMapping(value="/AdminInit", method = RequestMethod.POST)
	private void adminInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ArrayList<User> admins = UserService.getAllAdmins();
		String json = new Gson().toJson(admins);
		request.setAttribute("admins", json);
		request.getRequestDispatcher("AdminPage.jsp").forward(request, response);
	}
	
	@RequestMapping(value="/Home")
	public void home(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("Home");
		response.sendRedirect("Home.jsp");
	}
	
	
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
			user.setUserType(out.get(1));
			
			setUserSessions(request, user);
			status = true;
		}
		return ""+status;
		
		
	}
	
	
	@RequestMapping(value="/Logout", method = RequestMethod.GET)
	public void logout(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		HttpSession session = request.getSession();
		System.out.println("Sign Out: "+session.getAttribute(sessionUserID));
		session.invalidate();
		response.sendRedirect("Home.jsp");
	}
	
	
	@RequestMapping(value="/Register", method = RequestMethod.POST)
	@ResponseBody
	public String register(HttpServletRequest request,@ModelAttribute("User") User newUser)throws ServletException, IOException{
		System.out.println("Register");
		
		newUser.setNewId();
		newUser.setUserType("0");
		
		boolean status=false;
		
		if(UserService.checkUser(newUser)){
			if(UserService.addUser(newUser))
				status = true;
		}
		

		if(status)
		setUserSessions(request, newUser);

		return ""+status;
	}
	
	
	public void setUserSessions(HttpServletRequest request, User user){
		
		HttpSession session;
		session = request.getSession(true);
		
		// Get session creation time.
	    Date createTime = new Date(session.getCreationTime());
	         
	    // Get last access time of this web page.
	    Date lastAccessTime = new Date(session.getLastAccessedTime());
	
        session.setAttribute("userID", user.getId());
	}
	
	
	
	@RequestMapping(value="/AddEmployee", method = RequestMethod.POST)
	public void addEmployee(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("AddEmployee");
		
		User newUser = new User();//request.getParameter("email"),request.getParameter("password"));
		newUser.setFirstName(request.getParameter("fName"));
		newUser.setMiddleName(request.getParameter("mName"));
		newUser.setLastName(request.getParameter("lName"));
		newUser.setUserType(request.getParameter("type"));
		newUser.setUserNumber(request.getParameter("idNumber"));
		newUser.setSecretQuestion(request.getParameter("sQuestion"));
		newUser.setSecretAnswer(request.getParameter("sAnswer"));
		
		boolean status=false;
		
		if(UserService.checkUser(newUser)){
			if(UserService.addUser(newUser)){
				status = true;
				System.out.println("Added");
			}
		}
		
		//setUserSessions(request, response, newUser);

		PrintWriter pw = response.getWriter();
		pw.write(status+"");
	}
	
	@RequestMapping(value="/AddBook", method = RequestMethod.POST)
	public String addBook(@ModelAttribute("Book") Book book)throws ServletException, IOException{
		System.out.println("AddBook");
		

		System.out.println(book.getId());

		Random r =new Random();
		book.setId(r.nextInt(9999));
		
		System.out.println(book.getId());

		
		boolean status=false;
		
		if(!BookService.checkBook(book.getId())){
			System.out.println("Yes");
			if(BookService.addBook(book)){
				status = true;
				System.out.println("Added");
			}
		}
		
		//setUserSessions(request, response, newUser);

		//PrintWriter pw = response.getWriter();
		return status+"";
	}
	
	@RequestMapping(value="/EditBook", method = RequestMethod.POST)
	public void editBook(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("EditBook");
		
		
		Book editedBook = new Book();
		editedBook.setId(Integer.parseInt(request.getParameter("bookid")));
		editedBook.setDds(request.getParameter("bookdds"));
		editedBook.setAuthor(request.getParameter("bookauthor"));
		editedBook.setDescription(request.getParameter("bookdescription"));
		editedBook.setName(request.getParameter("bookname"));
		editedBook.setPublisher(request.getParameter("bookpublisher"));
		editedBook.setStatus(request.getParameter("bookstatus"));
		editedBook.setYear(request.getParameter("bookyear"));
		editedBook.setType(request.getParameter("booktype"));
		boolean status=false;

		if(BookService.checkBook(editedBook.getId())){
			if(BookService.editBook(editedBook)){
				status = true;
				System.out.println("Edited");
			}
		}
		
		//setUserSessions(request, response, newUser);

		PrintWriter pw = response.getWriter();
		pw.write(status+"");
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
	public void deleteBook(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("DeleteBook");
		
		int bookid = Integer.parseInt(request.getParameter("bookid"));
		boolean status=false;

		if(BookService.checkBook(bookid)){
			if(BookService.deleteBook(bookid)){
				status = true;
				System.out.println("deleted");
			}
		}
		
		//setUserSessions(request, response, newUser);

		PrintWriter pw = response.getWriter();
		pw.write(status+"");
	}

	
	@RequestMapping(value="/EditProduct", method = RequestMethod.POST)
	public void editProduct(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("EditProduct");

		request.getSession().setAttribute("productID", request.getParameter("bookID"));

	
	}
}
