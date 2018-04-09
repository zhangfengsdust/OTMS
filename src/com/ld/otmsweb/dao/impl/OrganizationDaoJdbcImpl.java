package com.ld.otmsweb.dao.impl;

import java.util.List;

import com.ld.otmsweb.dao.Dao;
import com.ld.otmsweb.dao.OrganizationDao;
import com.ld.otmsweb.model.Organization;

public class OrganizationDaoJdbcImpl extends Dao<Organization> implements OrganizationDao{

	@Override
	public List<Organization> getAll() {
		// TODO Auto-generated method stub
		String sql = "SELECT org_id id,org_parent_organization_id parentId,org_name name FROM organization";
		return getForList(sql);
	}

	@Override
	public void save(Organization organization) {
		// TODO Auto-generated method stub
		String sql = "INSERT INTO organization(org_parent_organization_id ,org_name) VALUES(?,?)";
		update(sql,organization.getParentId(),organization.getName());
	}

	@Override
	public void delete(int id) {
		// TODO Auto-generated method stub
		String sql = "DELETE FROM organization WHERE org_id = ?";
		update(sql,id);
	}

	@Override
	public void update(Organization organization) {
		// TODO Auto-generated method stub
		String sql = "UPDATE organization SET org_parent_organization_id = ?,org_name = ? where org_id = ?";
		update(sql,organization.getParentId(),organization.getName(),organization.getId());
	}

	@Override
	public Organization get(int id) {
		// TODO Auto-generated method stub
		String sql = "SELECT org_id id,org_parent_organization_id parentId,org_name name "
				+ "FROM organization WHERE org_id = ?";
		return get(sql,id);
	}

	@Override
	public long getCountWith(int parentId) {
		// TODO Auto-generated method stub
		String sql = "SELECT count(org_id) FROM organization where org_parent_organization_id = ?";
		return getValue(sql,parentId);
	}

	@Override
	public List<Organization> getByParentId(int parentId) {
		// TODO Auto-generated method stub
		String sql = "SELECT org_id id,org_parent_organization_id parentId,org_name name "
				+ "FROM organization WHERE org_parent_organization_id = ?";
		return getForList(sql,parentId);
	}

	@Override
	public Organization getByName(String name) {
		// TODO Auto-generated method stub
		String sql = "SELECT org_id id,org_parent_organization_id parentId,org_name name "
				+ "FROM organization WHERE org_name = ?";
		return get(sql,name);
	}

}
