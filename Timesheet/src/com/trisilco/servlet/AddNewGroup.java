package com.trisilco.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trisilco.model.Database;
import com.trisilco.model.Group;

/**
 * Servlet implementation class AddNewGroup
 */
@WebServlet("/AddNewGroup")
public class AddNewGroup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNewGroup() {
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
			String newGroupName = request.getParameter("AddGroupName");
			String newGroupDescription = request.getParameter("AddGroupDescription");
			
			db.INIT();
			
			Group newGroup = new Group(newGroupName, newGroupDescription);
			
			// If group added successfully, non-zero ID will be returned instead
			int status = db.addNewGroup(newGroup);
			
			if (status == 0) {
				response.getWriter().write("ERROR_ADD_GROUP");
			} else {
				response.getWriter().write(String.valueOf(status));
			}
			
			db.closeConnectionDB();
		}
	}

}