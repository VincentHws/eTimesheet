package com.trisilco.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trisilco.model.Database;
import com.trisilco.model.Project;

/**
 * Servlet implementation class AddNewProject
 */
@WebServlet("/AddNewProject")
public class AddNewProject extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddNewProject() {
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
			
			// Obtaining new project information
			String projectName = request.getParameter("ProjectName");
			String projectDescription = request.getParameter("ProjectDescription");
			int clientID = Integer.parseInt(request.getParameter("ClientID"));
			int quotedDuration = Integer.parseInt(request.getParameter("QuotedDuration"));
			float quotedProjectPrice = Float.parseFloat(request.getParameter("QuotedProjectPrice"));
			String sitDeliveryDate = request.getParameter("SITDeliveryDate");
			String uatDeliveryDate = request.getParameter("UATDeliveryDate");
			String goLiveDeliveryDate = request.getParameter("GoLiveDeliveryDate");
			int assignedProjectGroupID = Integer.parseInt(request.getParameter("AssignedProjectID"));
			
			Project newProject = new Project(projectName, projectDescription, clientID, quotedDuration, quotedProjectPrice, 
					sitDeliveryDate, uatDeliveryDate, goLiveDeliveryDate, assignedProjectGroupID);
			
			int status = db.addNewProject(newProject);
			
			if (status == 0) {
				response.getWriter().write("ERROR_ADD_PROJECT");
			} else {
				response.getWriter().write(status);
			}
		}
		
		db.closeConnectionDB();
	}
}
