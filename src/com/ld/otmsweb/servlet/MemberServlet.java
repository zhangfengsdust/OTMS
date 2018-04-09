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
import com.ld.otmsweb.dao.ExecuteTaskDao;
import com.ld.otmsweb.dao.MemberDao;
import com.ld.otmsweb.dao.impl.ExecuteTaskDaoJdbcImpl;
import com.ld.otmsweb.dao.impl.MemberDaoJdbcImpl;
import com.ld.otmsweb.model.Member;

/**
 * Servlet implementation class MemberServlet
 */
@WebServlet("/MemberServlet")
public class MemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberDao memberDao = new MemberDaoJdbcImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberServlet() {
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
	
    protected void modifyPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	if(request.getSession().getAttribute("user") == null){
    		response.getWriter().print("false");
    		return ;
    	}
    	int id = Integer.parseInt(request.getParameter("id"));
    	String password = request.getParameter("password");
    	memberDao.modifyPassword(id, password);
    	Member user = (Member)request.getSession().getAttribute("user");
    	user.setPassword(password);
    	request.getSession().setAttribute("user", user);
    	response.getWriter().print("true");
	}

	protected void seekMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		int organizationId = Integer.parseInt(request.getParameter("organizationId"));
		Member member;
		if(organizationId == 0){
			member = memberDao.getMemberByUsername(username);
		}
		else{
			member = memberDao.getMemberByUsernameByOrg(username,organizationId);
		}
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(member));
	}
	
	protected void seek(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		Member member = memberDao.getByUsername(username);
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(member));
	}
	
	protected void seekById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Member member = memberDao.getById(id);
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(member));
	}
	
	protected void seekAdministrator(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		Member member = memberDao.getAdministratorByUsername(username);
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(member));
	}
	
	protected void seekMembers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Member> members ;
		int organizationId = Integer.parseInt(request.getParameter("organizationId"));
		if(organizationId == 0){
			members = memberDao.getAllMembers();
		}
		else{
			members = memberDao.getAllMembersByOrg(organizationId);
		}
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(members));
	}
	
	protected void seekAllByOrg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Member> members ;
		int organizationId = Integer.parseInt(request.getParameter("organizationId"));
		if(organizationId == 0){
			members = memberDao.getAll();
		}
		else{
			members = memberDao.getAllByOrg(organizationId);
		}
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(members));
	}
	
	protected void seekAdministrators(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Member> members = memberDao.getAllAdministrators();
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(members));
	}
	
	protected void addAdministrator(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		Member member = memberDao.getByUsername(username);
		Integer power = 0;
		if(member!= null ){
			power = member.getPower();
		}
		if(member != null && member.getPower() == 1){
			member.setPower(2);
			memberDao.update(member);
		}
		response.getWriter().print(power);
	}
	
	protected void setAdministrator(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Member member = memberDao.getById(id);
		member.setPower(2);
		memberDao.update(member);
		response.getWriter().print("true");
	}
	
	protected void deleteMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		memberDao.delete(id);
		ExecuteTaskDao executeTaskDao = new ExecuteTaskDaoJdbcImpl();
		executeTaskDao.deleteByMember(id);
		response.getWriter().print("true");
	}
	
	protected void deleteAdministrator(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Member member = memberDao.getById(id);
		member.setPower(1);
		memberDao.update(member);
		response.getWriter().print("true");
	}
	
	protected void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Member member = memberDao.getById(id);
		request.setAttribute("member", member);
		request.getRequestDispatcher("/WEB-INF/update-member.jsp").forward(request, response);
	}
	
	protected void updateMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String sex = request.getParameter("sex");
		if("«Î—°‘Ò".equals(sex)){
			sex = "";
		}
		String birthDate = request.getParameter("birthDate");
		String identityCard = request.getParameter("identityCard");
		if("".equals(birthDate)){
			birthDate = null;
		}
		String mobile = request.getParameter("mobile");
		Member member = memberDao.getById(id);
		member.setPassword(password);
		member.setName(name);
		member.setSex(sex);
		member.setBirthDate(birthDate);
		member.setIdentityCard(identityCard);
		member.setMobile(mobile);
		memberDao.update(member);
		response.getWriter().print("true");
	}
    
	protected void addMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String memberflag = request.getParameter("memberflag");
		HttpSession session = request.getSession();
		String Memberflag = "";
		if(session.getAttribute("memberflag") != null){
			Memberflag = session.getAttribute("memberflag").toString();
		}
		if(memberflag.equals(Memberflag)){
			
		}
		else{
			session.setAttribute("memberflag",memberflag);
			Member member = new Member();
			String username = request.getParameter("userName");
			String password = request.getParameter("passWord");
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			if("«Î—°‘Ò".equals(sex)){
				sex = "";
			}
			String birthDate = request.getParameter("birthDate");
			if("".equals(birthDate)){
				birthDate = null;
			}
			String mobile = request.getParameter("mobile");
			String identityCard = request.getParameter("identityCard");
			String academic = request.getParameter("academic");
			String department = request.getParameter("department");
			int organizationId;
			if("Œﬁ".equals(department)){
				organizationId = Integer.parseInt(academic);
			}
			else{
				organizationId = Integer.parseInt(department);
			}
			member.setUsername(username);
			member.setPassword(password);
			member.setName(name);
			member.setSex(sex);
			member.setBirthDate(birthDate);
			member.setMobile(mobile);
			member.setIdentityCard(identityCard);
			member.setOrganizationId(organizationId);
			member.setPower(1);
			member.setTotalWeight(0);
			memberDao.save(member);
		}
        
		request.getRequestDispatcher("/WEB-INF/add-member.jsp").forward(request, response);
	}
}
