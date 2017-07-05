package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.beans.Book;
import com.beans.MeetingRoomBooking;
import com.beans.User;
import com.google.gson.Gson;
import com.services.BookService;
import com.services.MeetingRoomService;
import com.services.UserService;

/**
 * Servlet implementation class Controller
 */

@WebServlet(urlPatterns = {	"/Controller",
							"/Login",
							"/Logout",
							"/Register",
							"/Home",
							"/AddEmployee",
							"/EditBook",
							"/DeleteBook",
							"/LibraryInit",
							"/ReserveBook",
							"/BookingsInit",
							"/AdminInit",
							"/ReserveRoom",
							"/EditProduct",
							"/GetBook"
							})

public class Controller extends HttpServlet {
	
	
	public static final String sessionUserID = "userID";
	
	private static final long serialVersionUID = 1L;
	
	
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}
	
	
	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String servletPath = request.getServletPath();
		
		switch(servletPath){
		case "/Login": login(request,response); break;
		case "/Logout": logout(request,response); break;
		case "/Register": register(request,response); break;
		case "/AddEmployee": addEmployee(request,response); break;
		case "/EditBook": editBook(request,response);break;
		case "/LibraryInit": libraryInit(request, response); break;
		case "/AdminInit": adminInit(request, response); break;
		case "/ReserveBook": reserveBook(request,response); break;
		case "/BookingsInit": bookingsInit(request, response); break;
		case "/ReserveRoom": reserveRoom(request, response); break;
		case "/EditProduct": editProduct(request, response); break;
		case "/DeleteBook": deleteBook(request,response); break;
		case "/GetBook": getBook(request,response); break;
		default: home(request,response); break;
		}
	}
	
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

	private void bookingsInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<MeetingRoomBooking> bookings = MeetingRoomService.getMeetingRoomBookings();
		request.setAttribute("bookings", bookings);
		request.getRequestDispatcher("RoomReservations.jsp").forward(request, response);
	}

	private void reserveBook(HttpServletRequest request, HttpServletResponse response) throws IOException {
		boolean out = BookService.reserveBook(request.getParameter("idbook"));
		
		PrintWriter pw = response.getWriter();
		pw.write(out+"");
	}

	private void libraryInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<Book> books = BookService.getAllBooks();
		request.setAttribute("books", books);
		request.getRequestDispatcher("LibraryPage.jsp").forward(request, response);
	}

	private void adminInit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ArrayList<User> admins = UserService.getAllAdmins();
		String json = new Gson().toJson(admins);
		request.setAttribute("admins", json);
		request.getRequestDispatcher("AdminPage.jsp").forward(request, response);
	}
	
	public void home(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("Home");
		response.sendRedirect("Home.jsp");
	}
	
	public void login(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("Login");

		User user = new User(request.getParameter("email"),request.getParameter("password"));
		ArrayList<String> out = UserService.loginUser(user);
		
		boolean status = false;
		
		if(out.size()>0){
			user.setId(Integer.parseInt(out.get(0)));
			user.setUserType(out.get(1));
			
			setUserSessions(request, response, user);
			status = true;
		}
		PrintWriter pw = response.getWriter();
		pw.write(status+"");
	}
	
	public void logout(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		HttpSession session = request.getSession();
		System.out.println("Sign Out: "+session.getAttribute(sessionUserID));
		session.invalidate();
		response.sendRedirect("Home.jsp");
	}
	
	public void register(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("Register");
		
		
		User newUser = new User(request.getParameter("email"),request.getParameter("password"));
		newUser.setFirstName(request.getParameter("fName"));
		newUser.setMiddleName(request.getParameter("mName"));
		newUser.setLastName(request.getParameter("lName"));
		newUser.setUserNumber(request.getParameter("idNumber"));
		newUser.setSecretQuestion(request.getParameter("sQuestion"));
		newUser.setSecretAnswer(request.getParameter("sAnswer"));
		
		
		boolean status=false;
		
		if(UserService.checkUser(newUser)){
			if(UserService.addUser(newUser))
				status = true;
		}
		
		
		setUserSessions(request, response, newUser);

		PrintWriter pw = response.getWriter();
		pw.write(status+"");
	}
	
	public void setUserSessions(HttpServletRequest request, HttpServletResponse response, User user)throws ServletException, IOException{
		
		HttpSession session;
		session = request.getSession(true);
		
		// Get session creation time.
	    Date createTime = new Date(session.getCreationTime());
	         
	    // Get last access time of this web page.
	    Date lastAccessTime = new Date(session.getLastAccessedTime());
	
        session.setAttribute("userID", user.getId());
	}
	
	
	
	public void addEmployee(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("AddEmployee");
		
		User newUser = new User(request.getParameter("email"),request.getParameter("password"));
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

	
	
	public void editProduct(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("EditProduct");

		request.getSession().setAttribute("productID", request.getParameter("bookID"));

	
	}

}
