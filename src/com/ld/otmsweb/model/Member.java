package com.ld.otmsweb.model;

import java.util.Random;

public class Member implements Comparable<Member>{
    private int id;
    private String username;
    private String password;
    private String name;
    private String sex;
    private String birthDate;
    private String mobile;
    private String identityCard;
    private int organizationId;
    private int power;
    private double totalWeight;
    private double compareWeight;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirthDate() {
		return birthDate;
	}
	public void setBirthDate(String birthDate) {
		this.birthDate = birthDate;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getIdentityCard() {
		return identityCard;
	}
	public void setIdentityCard(String identityCard) {
		this.identityCard = identityCard;
	}
	public int getOrganizationId() {
		return organizationId;
	}
	public void setOrganizationId(int organizationId) {
		this.organizationId = organizationId;
	}
	public int getPower() {
		return power;
	}
	public void setPower(int power) {
		this.power = power;
	}
	public double getTotalWeight() {
		return totalWeight;
	}
	public void setTotalWeight(double totalWeight) {
		this.totalWeight = totalWeight;
	}
	
	public double getCompareWeight() {
		return compareWeight;
	}
	public void setCompareWeight(double compareWeight) {
		this.compareWeight = compareWeight;
	}
	@Override
	public int compareTo(Member o) {
		double i = this.getCompareWeight() - o.getCompareWeight();
		if(i < 0){
			return -1;
		}
		else if(i > 0){
			return 1;
		}
		else if(i == 0){
			Random random = new Random();
			int r = random.nextInt(2);
			if(r == 0){
				return -1;
			}
			else if(r == 1){
				return 1;
			}
		}
		return 0;
	}
}
