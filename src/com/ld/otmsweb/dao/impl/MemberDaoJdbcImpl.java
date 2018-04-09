package com.ld.otmsweb.dao.impl;

import java.util.List;

import com.ld.otmsweb.dao.Dao;
import com.ld.otmsweb.dao.MemberDao;
import com.ld.otmsweb.model.Member;

public class MemberDaoJdbcImpl extends Dao<Member> implements MemberDao{

	@Override
	public List<Member> getAll() {
		// TODO Auto-generated method stub
		String sql = "SELECT mem_id id,mem_username username,mem_password password,mem_name name"
				+ ",mem_sex sex,mem_birth_date birthDate,mem_mobile mobile,mem_identity_card identityCard,"
				+ "mem_organization_id organizationId,mem_power power,mem_total_weight totalWeight FROM member";
		return getForList(sql);
	}

	@Override
	public void save(Member member) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO member(mem_username ,mem_password ,mem_name "
				+ ",mem_sex ,mem_birth_date ,mem_mobile ,mem_identity_card ,"
				+ "mem_organization_id ,mem_power ,mem_total_weight) VALUES"
				+ "(?,?,?,?,?,?,?,?,?,?)";
		update(sql,member.getUsername(),member.getPassword(),member.getName(),
				member.getSex(),member.getBirthDate(),member.getMobile(),member.getIdentityCard(),
				member.getOrganizationId(),member.getPower(),member.getTotalWeight());
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM member WHERE mem_id = ?";
		update(sql,id);
	}

	@Override
	public void update(Member member) {
		// TODO Auto-generated method stub
		String sql = "UPDATE member SET mem_password = ?,mem_name = ?"
				+ ",mem_sex = ?,mem_birth_date = ?,mem_mobile = ?,mem_identity_card = ?,"
				+ "mem_organization_id = ?,mem_power = ?,mem_total_weight = ? where mem_id = ?";
		update(sql,member.getPassword(),member.getName(),member.getSex(),member.getBirthDate(),member.getMobile()
				,member.getIdentityCard(),member.getOrganizationId(),member.getPower(),member.getTotalWeight(),member.getId());
	}

	@Override
	public Member getById(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT mem_id id,mem_username username,mem_password password,mem_name name"
				+ ",mem_sex sex,mem_birth_date birthDate,mem_mobile mobile,mem_identity_card identityCard,"
				+ "mem_organization_id organizationId,mem_power power,mem_total_weight totalWeight FROM member WHERE mem_id = ?";
		return get(sql,id);
	}

	@Override
	public Member getByUsername(String username) {
		// TODO Auto-generated method stub
		String sql = "SELECT mem_id id,mem_username username,mem_password password,mem_name name"
				+ ",mem_sex sex,mem_birth_date birthDate,mem_mobile mobile,mem_identity_card identityCard,"
				+ "mem_organization_id organizationId,mem_power power,mem_total_weight totalWeight FROM member WHERE mem_username = ?";
		return get(sql,username);
	}
	
	@Override
	public long getCountWith(String name) {
		// TODO Auto-generated method stub
		String sql = "SELECT count(mem_id) FROM member where mem_name = ?";
		return getValue(sql,name);
	}

	@Override
	public void setAdministrator(int id) {
		// TODO Auto-generated method stub
		String sql = "UPDATE member SET mem_power = ? WHERE mem_id = ?";
		update(sql, 2, id);
	}

	@Override
	public void modifyPassword(int id, String password) {
		// TODO Auto-generated method stub
		String sql = "UPDATE member SET mem_password = ? where mem_id = ?";
		update(sql,password,id);
	}

	@Override
	public long getCountWithOrganization(int organizationId) {
		// TODO Auto-generated method stub
		String sql = "SELECT count(mem_id) FROM member where mem_organization_id = ?";
		return getValue(sql,organizationId);
	}

	@Override
	public Member getAdministratorByUsername(String username) {
		// TODO Auto-generated method stub
		String sql = "SELECT mem_id id,mem_username username,mem_password password,mem_name name"
				+ ",mem_sex sex,mem_birth_date birthDate,mem_mobile mobile,mem_identity_card identityCard,"
				+ "mem_organization_id organizationId,mem_power power,mem_total_weight totalWeight FROM member WHERE mem_username = ? AND mem_power = ?";
		return get(sql,username,2);
	}

	@Override
	public List<Member> getAllAdministrators() {
		// TODO Auto-generated method stub
		String sql = "SELECT mem_id id,mem_username username,mem_password password,mem_name name"
				+ ",mem_sex sex,mem_birth_date birthDate,mem_mobile mobile,mem_identity_card identityCard,"
				+ "mem_organization_id organizationId,mem_power power,mem_total_weight totalWeight FROM member WHERE mem_power = ?";
		return getForList(sql,2);
	}

	@Override
	public Member getMemberByUsername(String username) {
		// TODO Auto-generated method stub
		String sql = "SELECT mem_id id,mem_username username,mem_password password,mem_name name"
				+ ",mem_sex sex,mem_birth_date birthDate,mem_mobile mobile,mem_identity_card identityCard,"
				+ "mem_organization_id organizationId,mem_power power,mem_total_weight totalWeight FROM member WHERE mem_username = ? AND mem_power = ?";
		return get(sql,username,1);
	}

	@Override
	public List<Member> getAllMembers() {
		// TODO Auto-generated method stub
		String sql = "SELECT mem_id id,mem_username username,mem_password password,mem_name name"
				+ ",mem_sex sex,mem_birth_date birthDate,mem_mobile mobile,mem_identity_card identityCard,"
				+ "mem_organization_id organizationId,mem_power power,mem_total_weight totalWeight FROM member WHERE mem_power = ?";
		return getForList(sql,1);
	}

	@Override
	public Member getMemberByUsernameByOrg(String username,int organizationId) {
		// TODO Auto-generated method stub
		String sql = "SELECT mem_id id,mem_username username,mem_password password,mem_name name"
				+ ",mem_sex sex,mem_birth_date birthDate,mem_mobile mobile,mem_identity_card identityCard,"
				+ "mem_organization_id organizationId,mem_power power,mem_total_weight totalWeight FROM member WHERE mem_username = ? AND mem_power = ? AND mem_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_parent_organization_id = ? OR org_id = ?)";
		return get(sql,username,1,organizationId,organizationId);
	}

	@Override
	public List<Member> getAllMembersByOrg(int organizationId) {
		// TODO Auto-generated method stub
		String sql = "SELECT mem_id id,mem_username username,mem_password password,mem_name name"
				+ ",mem_sex sex,mem_birth_date birthDate,mem_mobile mobile,mem_identity_card identityCard,"
				+ "mem_organization_id organizationId,mem_power power,mem_total_weight totalWeight FROM member WHERE mem_power = ? AND mem_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_parent_organization_id = ? OR org_id = ?)";
		return getForList(sql,1,organizationId,organizationId);
	}

	@Override
	public List<Member> getAllByOrg(int organizationId) {
		// TODO Auto-generated method stub
		String sql = "SELECT mem_id id,mem_username username,mem_password password,mem_name name"
				+ ",mem_sex sex,mem_birth_date birthDate,mem_mobile mobile,mem_identity_card identityCard,"
				+ "mem_organization_id organizationId,mem_power power,mem_total_weight totalWeight FROM member WHERE mem_organization_id IN"
				+ "(SELECT org_id FROM organization WHERE org_parent_organization_id = ? OR org_id = ?)";
		return getForList(sql,organizationId,organizationId);
	}

}
