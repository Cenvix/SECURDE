package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.beans.User;
import com.services.UserService;

/**
 * Servlet implementation class Controller
 */
@WebServlet(urlPatterns = {"/Controller","/Login","/Logout","/Register","/Home"})
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
		default: home(request,response); break;
		}
	}
	
	public void home(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("Home");
		response.sendRedirect("Home.jsp");
	}
	public void login(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		System.out.println("Login");
		

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

		boolean status=false;
		
		if(UserService.checkUser(newUser)){
			if(UserService.addUser(newUser))
				status = true;
		}
		
		
		PrintWriter pw = response.getWriter();
		pw.write(status+"");
		
		setUserSessions(request, response, newUser);

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

	
	


}
