package com.trisilco.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trisilco.model.Database;
import com.trisilco.model.User;

/**
 * Servlet implementation class AddUser
 */
@WebServlet("/AddNewUser")
public class AddNewUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNewUser() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
		Database db = new Database();
		
		if (isAjax) {
			
			db.INIT();
			
			ArrayList<Integer> groupID_int = new ArrayList<>();
			
			String username = request.getParameter("AddUser_Username");
			String password = request.getParameter("AddUser_Password");
			String email = request.getParameter("AddUser_Email");
			String[] groupID = request.getParameterValues("AddUser_Group");
			
			for (int i = 0 ; i < groupID.length ; i++) {
				groupID_int.add(Integer.parseInt(groupID[i]));
			}
			
			User newUser = new User(username, password, email, groupID_int);

			int row = db.addNewUser(newUser, groupID_int);
			
			if (row == 0) {
				response.getWriter().write("ERROR_ADD_USER");
			} else {
				response.getWriter().write("SUCCESS_ADD_USER");
			}	
		}
		
		db.closeConnectionDB();
	}
}
