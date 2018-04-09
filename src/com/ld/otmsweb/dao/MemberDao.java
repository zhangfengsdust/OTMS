package com.ld.otmsweb.dao;

import java.util.List;

import com.ld.otmsweb.model.Member;

public interface MemberDao {
	
    public List<Member> getAll();
    
    public void save(Member member);
    
    public void delete(int id);
    
    public void modifyPassword(int id,String password);
    
    public void update(Member member);
    
    public Member getById(int id);
    
    public Member getByUsername(String username);
    
    public long getCountWith(String name);
    
    public long getCountWithOrganization(int organizationId);
    
    public void setAdministrator(int id);
    
    public Member getAdministratorByUsername(String username);
    
    public List<Member> getAllAdministrators();
    
    public Member getMemberByUsername(String username);
    
    public Member getMemberByUsernameByOrg(String username,int organizationId);
    
    public List<Member> getAllMembers();
    
    public List<Member> getAllMembersByOrg(int organizationId);
    
    public List<Member> getAllByOrg(int organizationId);
    
}
