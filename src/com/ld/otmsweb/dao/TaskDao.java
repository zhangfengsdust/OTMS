package com.ld.otmsweb.dao;

import java.util.List;

import com.ld.otmsweb.model.Task;

public interface TaskDao {
    public List<Task> getAll();
    
    public List<Task> getAllByOrg(int organizationId);
    
    public List<Task> getByType(String taskType);
    
    public List<Task> getByTime(String time1,String time2);
    
    public List<Task> getByOrgByType(int organizationId,String taskType);
    
    public List<Task> getByOrgByTime(int organizationId,String time1,String time2);
    
    public List<Task> getByTypeByTime(String taskType,String time1,String time2);
    
    public List<Task> getByOrgByTypeByTime(int organizationId,String taskType,String time1,String time2);
    
    public void save(Task task);
    
    public void delete(int id);
    
    public void update(Task task);
    
    public Task get(int id);
    
    public Task getByOrg(int id,int organizationId);
    
    public long getCountWithOrganization(int organizationId);
    
    public void assignTask(int id);
    
}
