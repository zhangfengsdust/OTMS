package com.ld.otmsweb.dao.impl;

import java.util.List;

import com.ld.otmsweb.dao.Dao;
import com.ld.otmsweb.dao.TaskDao;
import com.ld.otmsweb.model.Task;

public class TaskDaoJdbcImpl extends Dao<Task> implements TaskDao{

	@Override
	public List<Task> getAll() {
		// TODO Auto-generated method stub
		String sql = "SELECT task_id id,task_organization_id organizationId,task_name name,"
				+ "task_start_time startTime,task_end_time endTime,task_weight weight,"
				+ "task_people_number peopleNumber,task_type type,task_description description,"
				+ "task_is_assigned isAssigned FROM task";
		return getForList(sql);
	}

	@Override
	public void save(Task task) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO task(task_organization_id,task_name,task_start_time,task_end_time,"
				+ "task_weight,task_people_number,task_type,task_description,task_is_assigned)"
				+ " VALUES(?,?,?,?,?,?,?,?,?)";
		update(sql,task.getOrganizationId(),task.getName(),task.getStartTime(),task.getEndTime(),task.getWeight(),
				task.getPeopleNumber(),task.getType(),task.getDescription(),task.getIsAssigned());
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM task WHERE task_id = ?";
		update(sql,id);
	}

	@Override
	public void update(Task task) {
		// TODO Auto-generated method stub
		String sql = "UPDATE task SET task_organization_id = ?,task_name = ?,task_start_time = ?,task_end_time = ?"
				+ ",task_weight = ?,task_people_number = ?,task_type = ?,task_description = ?,task_is_assigned = ?"
				+ " where task_id = ?";
		update(sql,task.getOrganizationId(),task.getName(),task.getStartTime(),task.getEndTime(),
				task.getWeight(),task.getPeopleNumber(),task.getType(),task.getDescription(),task.getIsAssigned(),task.getId());
	}

	@Override
	public Task get(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT task_id id,task_organization_id organizationId,task_name name,"
				+ "task_start_time startTime,task_end_time endTime,task_weight weight,"
				+ "task_people_number peopleNumber,task_type type,task_description description,"
				+ "task_is_assigned isAssigned FROM task WHERE task_id = ?";
		return get(sql,id);
	}


	@Override
	public void assignTask(int id) {
		// TODO Auto-generated method stub
		String sql = "UPDATE task SET task_is_assigned = ? WHERE task_id = ?";
		update(sql,1,id);
	}

	@Override
	public long getCountWithOrganization(int organizationId) {
		// TODO Auto-generated method stub
		String sql = "SELECT count(task_id) FROM task where task_organization_id = ?";
		return getValue(sql,organizationId);
	}

	@Override
	public List<Task> getAllByOrg(int organizationId) {
		// TODO Auto-generated method stub
		String sql = "SELECT task_id id,task_organization_id organizationId,task_name name,"
				+ "task_start_time startTime,task_end_time endTime,task_weight weight,"
				+ "task_people_number peopleNumber,task_type type,task_description description,"
				+ "task_is_assigned isAssigned FROM task WHERE task_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_parent_organization_id = ? OR org_id = ?)";
		return getForList(sql,organizationId,organizationId);
	}

	@Override
	public Task getByOrg(int id, int organizationId) {
		// TODO Auto-generated method stub
		String sql = "SELECT task_id id,task_organization_id organizationId,task_name name,"
				+ "task_start_time startTime,task_end_time endTime,task_weight weight,"
				+ "task_people_number peopleNumber,task_type type,task_description description,"
				+ "task_is_assigned isAssigned FROM task WHERE task_id = ? AND task_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_parent_organization_id = ? OR org_id = ?)";
		return get(sql,id,organizationId,organizationId);
	}

	@Override
	public List<Task> getByType(String taskType) {
		// TODO Auto-generated method stub
		String sql = "SELECT task_id id,task_organization_id organizationId,task_name name,"
				+ "task_start_time startTime,task_end_time endTime,task_weight weight,"
				+ "task_people_number peopleNumber,task_type type,task_description description,"
				+ "task_is_assigned isAssigned FROM task WHERE task_type = ?";
		return getForList(sql,taskType);
	}

	@Override
	public List<Task> getByTime(String time1, String time2) {
		// TODO Auto-generated method stub
		String sql = "SELECT task_id id,task_organization_id organizationId,task_name name,"
				+ "task_start_time startTime,task_end_time endTime,task_weight weight,"
				+ "task_people_number peopleNumber,task_type type,task_description description,"
				+ "task_is_assigned isAssigned FROM task WHERE task_start_time >= ? AND task_start_time <= ?";
		return getForList(sql,time1,time2);
	}

	@Override
	public List<Task> getByOrgByType(int organizationId, String taskType) {
		// TODO Auto-generated method stub
		String sql = "SELECT task_id id,task_organization_id organizationId,task_name name,"
				+ "task_start_time startTime,task_end_time endTime,task_weight weight,"
				+ "task_people_number peopleNumber,task_type type,task_description description,"
				+ "task_is_assigned isAssigned FROM task WHERE task_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_parent_organization_id = ? OR org_id = ?) "
				+ " AND task_type = ?";
		return getForList(sql,organizationId,organizationId,taskType);
	}

	@Override
	public List<Task> getByOrgByTime(int organizationId, String time1, String time2) {
		// TODO Auto-generated method stub
		String sql = "SELECT task_id id,task_organization_id organizationId,task_name name,"
				+ "task_start_time startTime,task_end_time endTime,task_weight weight,"
				+ "task_people_number peopleNumber,task_type type,task_description description,"
				+ "task_is_assigned isAssigned FROM task WHERE task_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_parent_organization_id = ? OR org_id = ?) "
				+ " AND task_start_time >= ? AND task_start_time <= ?";
		return getForList(sql,organizationId,organizationId,time1,time2);
	}

	@Override
	public List<Task> getByTypeByTime(String taskType, String time1, String time2) {
		// TODO Auto-generated method stub
		String sql = "SELECT task_id id,task_organization_id organizationId,task_name name,"
				+ "task_start_time startTime,task_end_time endTime,task_weight weight,"
				+ "task_people_number peopleNumber,task_type type,task_description description,"
				+ "task_is_assigned isAssigned FROM task WHERE task_type = ? AND "
				+ "task_start_time >= ? AND task_start_time <= ?";
		return getForList(sql,taskType,time1,time2);
	}

	@Override
	public List<Task> getByOrgByTypeByTime(int organizationId, String taskType, String time1, String time2) {
		// TODO Auto-generated method stub
		String sql = "SELECT task_id id,task_organization_id organizationId,task_name name,"
				+ "task_start_time startTime,task_end_time endTime,task_weight weight,"
				+ "task_people_number peopleNumber,task_type type,task_description description,"
				+ "task_is_assigned isAssigned FROM task WHERE task_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_parent_organization_id = ? OR org_id = ?) "
				+ " AND task_type = ? AND task_start_time >= ? AND task_start_time <= ?";
		return getForList(sql,organizationId,organizationId,taskType,time1,time2);
	}

}
