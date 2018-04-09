package com.ld.otmsweb.dao.impl;

import java.util.List;

import com.ld.otmsweb.dao.Dao;
import com.ld.otmsweb.dao.ExecuteTaskDao;
import com.ld.otmsweb.model.ExecuteTask;

public class ExecuteTaskDaoJdbcImpl extends Dao<ExecuteTask> implements ExecuteTaskDao{

	@Override
	public List<ExecuteTask> getAll() {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask";
		return getForList(sql);
	}

	@Override
	public void save(ExecuteTask executeTask) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO executetask(et_member_id,et_task_id,et_comments) VALUES(?,?,?)";
		update(sql,executeTask.getMemberId(),executeTask.getTaskId(),executeTask.getComments());
	}

	@Override
	public void delete(int memberId,int taskId) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM executetask WHERE et_member_id = ? and et_task_id = ?";
		update(sql,memberId,taskId);
	}

	@Override
	public void update(ExecuteTask executeTask) {
		// TODO Auto-generated method stub
		String sql = "UPDATE executetask SET et_comments = ? WHERE et_id = ?";
		update(sql,executeTask.getComments(),executeTask.getId());
	}

	@Override
	public ExecuteTask get(int memberId,int taskId) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask "
				+ "WHERE et_member_id = ? AND er_task_id = ?";
		return get(sql,memberId,taskId);
	}

	@Override
	public int getCountWith(String name) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void deleteByMember(int memberId) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM executetask WHERE et_member_id = ?";
		update(sql,memberId);
	}

	@Override
	public void deleteByTask(int taskId) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM executetask WHERE et_task_id = ?";
		update(sql,taskId);
	}

	@Override
	public List<ExecuteTask> getByMember(int memberId) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask"
				+ " WHERE et_member_id = ?";
		return getForList(sql,memberId);
	}

	@Override
	public List<ExecuteTask> getByTask(int taskId) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask"
				+ " WHERE et_task_id = ?";
		return getForList(sql,taskId);
	}

	@Override
	public List<ExecuteTask> getByMemberByOrg(int memberId, int organizationId) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask"
				+ " WHERE et_member_id = ? AND et_member_id IN(SELECT mem_id FROM member WHERE mem_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_id = ? OR org_parent_organization_id = ?))";
		return getForList(sql,memberId,organizationId,organizationId);
	}

	@Override
	public List<ExecuteTask> getByTaskByOrg(int taskId, int organizationId) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask"
				+ " WHERE et_task_id = ? AND et_task_id IN(SELECT task_id FROM task WHERE task_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_id = ? OR org_parent_organization_id = ?))";
		return getForList(sql,taskId,organizationId,organizationId);
	}

	@Override
	public List<ExecuteTask> getAllByOrg(int organizationId) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask "
				+ "WHERE et_task_id IN(SELECT task_id FROM task WHERE task_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_id = ? OR org_parent_organization_id = ?))";
		return getForList(sql,organizationId,organizationId);
	}

	@Override
	public ExecuteTask getById(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask "
				+ "WHERE et_id = ?";
		return get(sql,id);
	}

	@Override
	public List<ExecuteTask> getByMemberByType(int memberId, String taskType) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask"
				+ " WHERE et_member_id = ? AND et_task_id IN(SELECT task_id FROM task WHERE task_type = ?)";
		return getForList(sql,memberId,taskType);
	}

	@Override
	public List<ExecuteTask> getByMemberByTime(int memberId, String time1, String time2) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask"
				+ " WHERE et_member_id = ? AND et_task_id IN(SELECT task_id FROM task WHERE task_start_time >= ? AND task_start_time <= ?)";
		return getForList(sql,memberId,time1,time2);
	}

	@Override
	public List<ExecuteTask> getByMemberByTypeByTime(int memberId, String taskType, String time1, String time2) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask"
				+ " WHERE et_member_id = ? AND et_task_id IN(SELECT task_id FROM task WHERE task_type = ? AND "
				+ " task_start_time >= ? AND task_start_time <= ?)";
		return getForList(sql,memberId,taskType,time1,time2);
	}

	@Override
	public List<ExecuteTask> getByType(String taskType) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask "
				+ "WHERE et_task_id IN(SELECT task_id FROM task WHERE task_type = ?)";
		return getForList(sql,taskType);
	}

	@Override
	public List<ExecuteTask> getByTime(String time1, String time2) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask "
				+ "WHERE et_task_id IN(SELECT task_id FROM task WHERE task_start_time >= ? AND task_start_time <= ?)";
		return getForList(sql,time1,time2);
	}

	@Override
	public List<ExecuteTask> getByOrgByType(int organizationId, String taskType) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask "
				+ "WHERE et_task_id IN(SELECT task_id FROM task WHERE task_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_id = ? OR org_parent_organization_id = ?) "
				+ " AND task_type = ?)";
		return getForList(sql,organizationId,organizationId,taskType);
	}

	@Override
	public List<ExecuteTask> getByOrgByTime(int organizationId, String time1, String time2) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask "
				+ "WHERE et_task_id IN(SELECT task_id FROM task WHERE task_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_id = ? OR org_parent_organization_id = ?)"
				+ " AND task_start_time >= ? AND task_start_time <= ?)";
		return getForList(sql,organizationId,organizationId,time1,time2);
	}

	@Override
	public List<ExecuteTask> getByTypeByTime(String taskType, String time1, String time2) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask"
				+ " WHERE et_task_id IN(SELECT task_id FROM task WHERE task_type = ? AND "
				+ " task_start_time >= ? AND task_start_time <= ?)";
		return getForList(sql,taskType,time1,time2);
	}

	@Override
	public List<ExecuteTask> getByOrgByTypeByTime(int organizationId, String taskType, String time1, String time2) {
		// TODO Auto-generated method stub
		String sql = "SELECT et_id id,et_member_id memberId,et_task_id taskId,et_comments comments FROM executetask "
				+ "WHERE et_task_id IN(SELECT task_id FROM task WHERE task_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_id = ? OR org_parent_organization_id = ?) AND "
				+ "task_type = ? AND task_start_time >= ? AND task_start_time <= ?)";
		return getForList(sql,organizationId,organizationId,taskType,time1,time2);
	}

}
