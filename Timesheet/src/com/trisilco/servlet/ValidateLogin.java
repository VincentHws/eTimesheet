package com.trisilco.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trisilco.model.Customer;
import com.trisilco.model.DailyTask;
import com.trisilco.model.Database;
import com.trisilco.model.Group;
import com.trisilco.model.User;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * Servlet implementation class ValidateLogin
 */
@WebServlet(description = "This servlet is to validate login by comparing the user entered credentials against the stored credentials", urlPatterns = { "/Home" })
public class ValidateLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidateLogin() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd;
		
		Database db = new Database();
		db.INIT();
		
		String username = (String) request.getParameter("text_login_username");
		String password = (String) request.getParameter("text_login_password");
		String months[] = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
		ArrayList<String> tempMonth = new ArrayList<>();
		String loginStatus;
		
		// User ID will be returned as login status if no error occurs
		loginStatus = db.doLogin(username, password);
		
		// If login status is not equal to any error code
		if (loginStatus != "USER_NOT_EXIST" && loginStatus != "CREDENTIAL_MISMATCH" && loginStatus != "SQL_EXCEPTION") {
			List<DailyTask> dailyTask = db.retreivePreviousEntry(Integer.valueOf(loginStatus));
			List<DailyTask> draft_dailyTask = db.retrieveDraftEntry(Integer.valueOf(loginStatus));
			List<String> projectName = db.loadRelatedProject(Integer.valueOf(loginStatus));
			List<String> taskType = db.loadTaskType();
			List<String> userGroup = db.loadUserGroup(loginStatus);
			User userDetails = db.loadUserDetails(Integer.parseInt(loginStatus));
			
			// TODO only admin has to load list of user groups
			List<Group> allGroups = db.loadAllGroups();
			List<Customer> allCustomers = db.loadAllCustomer();
			List<User> allUsers = db.loadAllUsers();
			
			// Only loading month before or equals to current month
			for (int i = 0; i <= Calendar.getInstance().get(Calendar.MONTH); i++) {
				tempMonth.add(months[i]);
			}
			
			request.setAttribute("months", tempMonth);
			request.setAttribute("userDetails", userDetails);
			request.setAttribute("userGroup", userGroup);
			request.setAttribute("taskType", taskType);
			request.setAttribute("projectName", projectName);
			request.setAttribute("draft_dailyTask", draft_dailyTask);
			request.setAttribute("dailyTask", dailyTask);
			
			// TODO only admin need to have request containing allGroups
			request.setAttribute("allGroups", allGroups);
			request.setAttribute("allCustomers", allCustomers);
			request.setAttribute("allUsers", allUsers);
			
			// Setting parameters to session object
			// TODO to determine whether session object is needed at all
			HttpSession session = createHTTPSession(request, Integer.parseInt(loginStatus));
			
			rd = request.getRequestDispatcher("/JSPs/HomePage.jsp");
		} else {
			request.setAttribute("status", loginStatus);
			
			rd = request.getRequestDispatcher("/JSPs/Login.jsp");
		}
		
		db.closeConnectionDB();
		rd.forward(request, response);
	}

	public HttpSession createHTTPSession(HttpServletRequest request, int loginStatus) {
		// Creating Session Object
		HttpSession session = request.getSession();
		
		session.setAttribute("userID", loginStatus);
		
		return session;
	}
}
