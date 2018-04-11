package com.trisilco.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trisilco.model.Database;
import com.trisilco.model.Group;

/**
 * Servlet implementation class MaintainGroup
 */
@WebServlet("/MaintainGroup")
public class MaintainGroup extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MaintainGroup() {
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
		ArrayList<Group> groupList = new ArrayList<>();
		
		if (isAjax) {
			db.INIT();
			
			String[] groupID = request.getParameterValues("groupID");
			String[] groupName = request.getParameterValues("groupName");
			String[] groupDescription = request.getParameterValues("groupDescription");
			
			// Creating list of Groups to be updated
			for (int i = 0 ; i < groupID.length ; i++) {
				Group g = new Group(Integer.parseInt(groupID[i]), groupName[i], groupDescription[i]);
				
				groupList.add(g);
			}
			
			int status = db.maintainGroup(groupList);
			
			if (status == 0) {
				response.getWriter().write("ERROR_MAINTAIN_GROUP");
			} else {
				response.getWriter().write("SUCCESS_MAINTAIN_GROUP");
			}
		}
	}

}
