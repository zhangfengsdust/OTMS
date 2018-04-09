package com.ld.otmsweb.dao;

import java.util.List;

import com.ld.otmsweb.model.Organization;

public interface OrganizationDao {
    public List<Organization> getAll();
    
    public void save(Organization organization);
    
    public void delete(int id);
    
    public void update(Organization organization);
    
    public Organization get(int id);
    
    public Organization getByName(String name);
    
    public long getCountWith(int parentId);
    
    public List<Organization> getByParentId(int parentId);
}
