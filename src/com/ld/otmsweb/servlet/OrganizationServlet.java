package com.ld.otmsweb.servlet;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.otmsweb.dao.MemberDao;
import com.ld.otmsweb.dao.OrganizationDao;
import com.ld.otmsweb.dao.TaskDao;
import com.ld.otmsweb.dao.impl.MemberDaoJdbcImpl;
import com.ld.otmsweb.dao.impl.OrganizationDaoJdbcImpl;
import com.ld.otmsweb.dao.impl.TaskDaoJdbcImpl;
import com.ld.otmsweb.model.Organization;

/**
 * Servlet implementation class OrganizationServlet
 */
@WebServlet("/OrganizationServlet")
public class OrganizationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    OrganizationDao organizationDao = new OrganizationDaoJdbcImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public OrganizationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String action = request.getParameter("action");
        try{
        	Method method = getClass().getDeclaredMethod(action,HttpServletRequest.class,HttpServletResponse.class);
        	method.invoke(this, request,response);
        }catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	protected void addOrganization(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String organizationflag = request.getParameter("organizationflag");
		HttpSession session = request.getSession();
		String Organizationflag = "";
		if(session.getAttribute("organizationflag") != null){
			Organizationflag = session.getAttribute("organizationflag").toString();
		}
		if(organizationflag.equals(Organizationflag)){
			
		}
		else{
			session.setAttribute("organizationflag",organizationflag);
			Organization organization = new Organization();
			String name = request.getParameter("name");
			String academic = request.getParameter("academic");
			int parentId;
			if("нч".equals(academic)){
				parentId = 0;
			}
			else{
				parentId = Integer.parseInt(academic);
			}
			organization.setName(name);
			organization.setParentId(parentId);
			organizationDao.save(organization);
		}
		request.getRequestDispatcher("/WEB-INF/add-organization.jsp").forward(request, response);
	}
	
	protected void seekOrganization(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Organization organization = organizationDao.get(id);
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(organization));
	}
	
	protected void seekOrganizationByName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		Organization organization = organizationDao.getByName(name);
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(organization));
	}
	
	protected void seekOrganizations(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int parentId = Integer.parseInt(request.getParameter("parentId"));
		List<Organization> organizations = organizationDao.getByParentId(parentId);
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(organizations));
	}
	
	protected void seekAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Organization> organizations = organizationDao.getAll();
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(organizations));
	}
	
	protected void deleteOrganization(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		long count = (long)organizationDao.getCountWith(id);
		if(count == 0){
			MemberDao memberDao = new MemberDaoJdbcImpl();
			TaskDao taskDao = new TaskDaoJdbcImpl();
			long peopleCount = (long)memberDao.getCountWithOrganization(id);
			long taskCount = (long)taskDao.getCountWithOrganization(id);
			if(peopleCount > 0){
				response.getWriter().print("2");
			}
			else if(taskCount >0 ){
				response.getWriter().print("3");
			}
			else{
				organizationDao.delete(id);
				response.getWriter().print("0");
			}
			
			
		}
		else if(count>0){
			response.getWriter().print("1");
		}
	}
	
	protected void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Organization organization = organizationDao.get(id);
		request.setAttribute("organization", organization);
		request.getRequestDispatcher("/WEB-INF/update-organization.jsp").forward(request, response);
	}
	
	protected void updateOrganization(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		int parentId = Integer.parseInt(request.getParameter("parentId"));
		String name = request.getParameter("name");
		Organization organization = new Organization();
		organization.setId(id);
		organization.setName(name);
		organization.setParentId(parentId);
		organizationDao.update(organization);
		response.getWriter().print("true");
	}

}
