package com.ld.otmsweb.servlet;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Collections;
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
import com.ld.otmsweb.dao.TaskDao;
import com.ld.otmsweb.dao.impl.ExecuteTaskDaoJdbcImpl;
import com.ld.otmsweb.dao.impl.MemberDaoJdbcImpl;
import com.ld.otmsweb.dao.impl.TaskDaoJdbcImpl;
import com.ld.otmsweb.model.ExecuteTask;
import com.ld.otmsweb.model.Member;
import com.ld.otmsweb.model.Task;

/**
 * Servlet implementation class TaskServlet
 */
@WebServlet("/TaskServlet")
public class TaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    TaskDao taskDao = new TaskDaoJdbcImpl(); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TaskServlet() {
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
	
	protected void deleteTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		taskDao.delete(id);
		ExecuteTaskDao executeTaskDao = new ExecuteTaskDaoJdbcImpl();
		executeTaskDao.deleteByTask(id);
		response.getWriter().print("true");
	}
	
	protected void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Task task = taskDao.get(id);
		request.setAttribute("task", task);
		request.getRequestDispatcher("/WEB-INF/update-task.jsp").forward(request, response);
	}
	
	protected void updateTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String name = request.getParameter("name");
		int peopleNumber = Integer.parseInt(request.getParameter("peopleNumber"));
		String startTime = request.getParameter("startTime");
		if("".equals(startTime)){
			startTime = null;
		}
		String endTime = request.getParameter("endTime");
		if("".equals(endTime)){
			endTime = null;
		}
		String type = request.getParameter("type");
		Double weight = Double.parseDouble(request.getParameter("weight"));
		String description = request.getParameter("description");
		Task task = taskDao.get(id);
		task.setName(name);
		task.setPeopleNumber(peopleNumber);
		task.setStartTime(startTime);
		task.setEndTime(endTime);
		task.setType(type);
		task.setWeight(weight);
		task.setDescription(description);
		taskDao.update(task);
		response.getWriter().print("true");
		
	}
	
	protected void assignTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Task task = taskDao.get(id);
		String taskType = task.getType();
		MemberDao memberDao = new MemberDaoJdbcImpl();
		ExecuteTaskDao executeTaskDao = new ExecuteTaskDaoJdbcImpl();
		List<Member> members = memberDao.getAllByOrg(task.getOrganizationId());
		
		if(members == null || members.size() < task.getPeopleNumber()){
			response.getWriter().print("false");
			return ;
		}
		for(Member member:members){
			member.setCompareWeight(0);
			List<ExecuteTask> executeTasks = executeTaskDao.getByMemberByType(member.getId(),taskType);
			for(ExecuteTask executeTask:executeTasks){
				if("完成".equals(executeTask.getComments())){
					Task _task = taskDao.get(id);
					member.setCompareWeight(member.getCompareWeight() + _task.getWeight());
				}
			}
		}
		Collections.sort(members);
		task.setIsAssigned(1);
		taskDao.update(task);
		for(int i = 0;i < task.getPeopleNumber();i++){
			ExecuteTask executeTask = new ExecuteTask();
			executeTask.setMemberId(members.get(i).getId());
			executeTask.setTaskId(task.getId());
			executeTask.setComments("未完成");
			executeTaskDao.save(executeTask);
		}
		response.getWriter().print("true");
		
	}
	
	protected void seekTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		int organizationId = Integer.parseInt(request.getParameter("organizationId"));
		Task task ;
		if(organizationId == 0){
			task = taskDao.get(id);
		}
		else{
			task = taskDao.getByOrg(id, organizationId);
		}
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(task));
	}
	
	protected void seekById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Task task = taskDao.get(id);
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(task));
	}
	
	protected void seekTasks(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int organizationId = Integer.parseInt(request.getParameter("organizationId"));
		List<Task> tasks ;
		if(organizationId == 0){
			tasks = taskDao.getAll();
		}
		else{
			tasks = taskDao.getAllByOrg(organizationId);
		}
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(tasks));
	}
	
	protected void seekTasksBy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int organizationId = Integer.parseInt(request.getParameter("organizationId"));
		String taskType = request.getParameter("type");
		String year = request.getParameter("year");
		String half = request.getParameter("half");
		List<Task> tasks ;
		if(organizationId == 0){
			if("全部".equals(taskType)){
				if("全部".equals(year)){
					tasks = taskDao.getAll();
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
					tasks = taskDao.getByTime(time1,time2);
				}
			}
			else{
				if("全部".equals(year)){
					tasks = taskDao.getByType(taskType);
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
					tasks = taskDao.getByTypeByTime(taskType,time1,time2);
				}
			};
		}
		else{
			if("全部".equals(taskType)){
				if("全部".equals(year)){
					tasks = taskDao.getAllByOrg(organizationId);
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
					tasks = taskDao.getByOrgByTime(organizationId,time1,time2);
				}
			}
			else{
				if("全部".equals(year)){
					tasks = taskDao.getByOrgByType(organizationId,taskType);
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
					tasks = taskDao.getByOrgByTypeByTime(organizationId,taskType,time1,time2);
				}
			}
		}
		
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("text/javascript");
		response.getWriter().print(mapper.writeValueAsString(tasks));
	}
	
	protected void addTask(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String taskflag = request.getParameter("taskflag");
		HttpSession session = request.getSession();
		String Taskflag = "";
		if(session.getAttribute("taskflag") != null){
			Taskflag = session.getAttribute("taskflag").toString();
		}
		if(taskflag.equals(Taskflag)){
			
		}
		else{
			session.setAttribute("taskflag",taskflag);
			Task task = new Task();
			String name = request.getParameter("name");
			int peopleNumber = Integer.parseInt(request.getParameter("peopleNumber"));
			String startTime = request.getParameter("startTime");
			if("".equals(startTime)){
				startTime = null;
			}
			String endTime = request.getParameter("endTime");
			if("".equals(endTime)){
				endTime = null;
			}
			String type = request.getParameter("type");
			Double weight = Double.parseDouble(request.getParameter("weight"));
			String description = request.getParameter("description");
			String academic = request.getParameter("academic");
			String department = request.getParameter("department");
			int organizationId;
			if("无".equals(department)){
				organizationId = Integer.parseInt(academic);
			}
			else{
				organizationId = Integer.parseInt(department);
			}
			task.setName(name);
			task.setPeopleNumber(peopleNumber);
			task.setStartTime(startTime);
			task.setEndTime(endTime);
			task.setType(type);
			task.setWeight(weight);
			task.setDescription(description);
			task.setOrganizationId(organizationId);
			task.setIsAssigned(0);
			taskDao.save(task);
		}
		
		request.getRequestDispatcher("/WEB-INF/add-task.jsp").forward(request, response);
	}
}
