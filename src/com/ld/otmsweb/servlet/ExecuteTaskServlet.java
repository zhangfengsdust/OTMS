package com.ld.otmsweb.servlet;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ld.otmsweb.dao.ExecuteTaskDao;
import com.ld.otmsweb.dao.MemberDao;
import com.ld.otmsweb.dao.TaskDao;
import com.ld.otmsweb.dao.impl.ExecuteTaskDaoJdbcImpl;
import com.ld.otmsweb.dao.impl.MemberDaoJdbcImpl;
import com.ld.otmsweb.dao.impl.TaskDaoJdbcImpl;
import com.ld.otmsweb.model.ExecuteTask;
import com.ld.otmsweb.model.Member;
import com.ld.otmsweb.model.Task;

/**
 * Servlet implementation class ExecuteTaskServlet
 */
@WebServlet("/ExecuteTaskServlet")
public class ExecuteTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ExecuteTaskDao executeDao = new ExecuteTaskDaoJdbcImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExecuteTaskServlet() {
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
	
	protected void seekTasksByMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberId = Integer.parseInt(request.getParameter("id"));
		String taskType = request.getParameter("type");
		String year = request.getParameter("year");
		String half = request.getParameter("half");
		List<ExecuteTask> executeTasks;
		if("全部".equals(taskType)){
			if("全部".equals(year)){
				executeTasks = executeDao.getByMember(memberId);
			}
			else{
				String time1,time2;
				if("全年".equals(half)){
					time1 = year + "-01-01 00:00:00";
					time2 = year + "-12-31 23:59:59";
				}
				else if("上半年".equals(half)){
					time1 = year + "-01-01 00:00:00";
					time2 = year + "-06-30 23:59:59";
				}
				else{
					time1 = year + "-07-01 00:00:00";
					time2 = year + "-12-31 23:59:59";
				}
				executeTasks = executeDao.getByMemberByTime(memberId,time1,time2);
			}
		}
		else{
			if("全部".equals(year)){
				executeTasks = executeDao.getByMemberByType(memberId,taskType);
			}
			else{
				String time1,time2;
				if("全年".equals(half)){
					time1 = year + "-01-01 00:00:00";
					time2 = year + "-12-31 23:59:59";
				}
				else if("上半年".equals(half)){
					time1 = year + "-01-01 00:00:00";
					time2 = year + "-06-30 23:59:59";
				}
				else{
					time1 = year + "-07-01 00:00:00";
					time2 = year + "-12-31 23:59:59";
				}
				executeTasks = executeDao.getByMemberByTypeByTime(memberId,taskType,time1,time2);
			}
		}
		
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(executeTasks));
	}
	
	protected void seekBy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int organizationId = Integer.parseInt(request.getParameter("organizationId"));
		String taskType = request.getParameter("type");
		String year = request.getParameter("year");
		String half = request.getParameter("half");
		List<ExecuteTask> executeTasks;
		if(organizationId == 0){
			if("全部".equals(taskType)){
				if("全部".equals(year)){
					executeTasks = executeDao.getAll();
				}
				else{
					String time1,time2;
					if("全年".equals(half)){
						time1 = year + "-01-01 00:00:00";
						time2 = year + "-12-31 23:59:59";
					}
					else if("上半年".equals(half)){
						time1 = year + "-01-01 00:00:00";
						time2 = year + "-06-30 23:59:59";
					}
					else{
						time1 = year + "-07-01 00:00:00";
						time2 = year + "-12-31 23:59:59";
					}
					executeTasks = executeDao.getByTime(time1,time2);
				}
			}
			else{
				if("全部".equals(year)){
					executeTasks = executeDao.getByType(taskType);
				}
				else{
					String time1,time2;
					if("全年".equals(half)){
						time1 = year + "-01-01 00:00:00";
						time2 = year + "-12-31 23:59:59";
					}
					else if("上半年".equals(half)){
						time1 = year + "-01-01 00:00:00";
						time2 = year + "-06-30 23:59:59";
					}
					else{
						time1 = year + "-07-01 00:00:00";
						time2 = year + "-12-31 23:59:59";
					}
					executeTasks = executeDao.getByTypeByTime(taskType,time1,time2);
				}
			};
		}
		else{
			if("全部".equals(taskType)){
				if("全部".equals(year)){
					executeTasks = executeDao.getAllByOrg(organizationId);
				}
				else{
					String time1,time2;
					if("全年".equals(half)){
						time1 = year + "-01-01 00:00:00";
						time2 = year + "-12-31 23:59:59";
					}
					else if("上半年".equals(half)){
						time1 = year + "-01-01 00:00:00";
						time2 = year + "-06-30 23:59:59";
					}
					else{
						time1 = year + "-07-01 00:00:00";
						time2 = year + "-12-31 23:59:59";
					}
					executeTasks = executeDao.getByOrgByTime(organizationId,time1,time2);
				}
			}
			else{
				if("全部".equals(year)){
					executeTasks = executeDao.getByOrgByType(organizationId,taskType);
				}
				else{
					String time1,time2;
					if("全年".equals(half)){
						time1 = year + "-01-01 00:00:00";
						time2 = year + "-12-31 23:59:59";
					}
					else if("上半年".equals(half)){
						time1 = year + "-01-01 00:00:00";
						time2 = year + "-06-30 23:59:59";
					}
					else{
						time1 = year + "-07-01 00:00:00";
						time2 = year + "-12-31 23:59:59";
					}
					executeTasks = executeDao.getByOrgByTypeByTime(organizationId,taskType,time1,time2);
				}
			}
		}
		
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(executeTasks));
	}
	
	protected void seekByMemberByOrg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int organizationId = Integer.parseInt(request.getParameter("organizationId"));
		List<ExecuteTask> executeTasks;
		if(organizationId == 0){
			 executeTasks = executeDao.getByMember(memberId);
		}
		else{
			executeTasks = executeDao.getByMemberByOrg(memberId,organizationId);
		}
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(executeTasks));
	}
	
	protected void seekTasksByTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int taskId = Integer.parseInt(request.getParameter("id"));
		List<ExecuteTask> executeTasks = executeDao.getByTask(taskId);
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(executeTasks));
	}
	
	protected void seekByTaskByOrg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int taskId = Integer.parseInt(request.getParameter("taskId"));
		int organizationId = Integer.parseInt(request.getParameter("organizationId"));
		List<ExecuteTask> executeTasks;
		if(organizationId == 0){
			executeTasks = executeDao.getByTask(taskId);
		}
		else{
			executeTasks = executeDao.getByTaskByOrg(taskId,organizationId);
		}
		
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(executeTasks));
	}
	
	protected void seekAllByOrg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int organizationId = Integer.parseInt(request.getParameter("organizationId"));
		List<ExecuteTask> executeTasks;
		if(organizationId == 0){
			executeTasks = executeDao.getAll();
		}
		else{
			executeTasks = executeDao.getAllByOrg(organizationId);
		}
		
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(executeTasks));
	}
	
	protected void assess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		ExecuteTask executeTask = executeDao.getById(id);
		executeTask.setComments("完成");
		executeDao.update(executeTask);
		MemberDao memberDao = new MemberDaoJdbcImpl();
		TaskDao taskDao = new TaskDaoJdbcImpl();
		Task task = taskDao.get(executeTask.getTaskId());
		Member member = memberDao.getById(executeTask.getMemberId());
		member.setTotalWeight(member.getTotalWeight() + task.getWeight());
		memberDao.update(member);
		response.getWriter().print("true");
	}

}
