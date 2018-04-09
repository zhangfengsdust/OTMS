package com.ld.otmsweb.dao;

import java.util.List;

import com.ld.otmsweb.model.ExecuteTask;

public interface ExecuteTaskDao {
    public List<ExecuteTask> getAll();
    
    public void save(ExecuteTask executeTask);
    
    public void delete(int memberId,int taskId);
    
    public void deleteByMember(int memberId);
    
    public void deleteByTask(int taskId);
    
    public void update(ExecuteTask executeTask);
    
    public ExecuteTask get(int memberId,int taskId);
    
    public ExecuteTask getById(int id);
    
    public List<ExecuteTask> getByMember(int memberId);
    
    public List<ExecuteTask> getByMemberByType(int memberId,String taskType);
    
    public List<ExecuteTask> getByMemberByTime(int memberId,String time1,String time2);
    
    public List<ExecuteTask> getByMemberByTypeByTime(int memberId,String taskType,String time1,String time2);
    
    public List<ExecuteTask> getByTask(int taskId);
    
    public int getCountWith(String name);
    
    public List<ExecuteTask> getByMemberByOrg(int memberId,int organizationId);
    
    public List<ExecuteTask> getByTaskByOrg(int taskId,int organizationId);
    
    public List<ExecuteTask> getAllByOrg(int organizationId);
    
    public List<ExecuteTask> getByType(String taskType);
    
    public List<ExecuteTask> getByTime(String time1,String time2);
    
    public List<ExecuteTask> getByOrgByType(int organizationId,String taskType);
    
    public List<ExecuteTask> getByOrgByTime(int organizationId,String time1,String time2);
    
    public List<ExecuteTask> getByTypeByTime(String taskType,String time1,String time2);
    
    public List<ExecuteTask> getByOrgByTypeByTime(int organizationId,String taskType,String time1,String time2);
}
