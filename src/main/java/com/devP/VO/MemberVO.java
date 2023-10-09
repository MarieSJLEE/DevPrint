package com.devP.VO;

import java.util.ArrayList;
import java.util.List;

public class MemberVO {

    public int projectId;
    public String userName;
    public String userId;
    public String email;
    public String leader;
    public String position;
    public String role;
    public String getEmail;
    private String status;
    private float progress;

    private ArrayList<MemberVO> memberVOList;
    public int getProjectId() {return projectId;}
    public void setProjectId(int projectId){this.projectId = projectId;}
    public String getUserName() {return userName;}
    public void setUserName(String userName) {this.userName = userName;}

    public String getUserId() {return userId;}
    public void setUserId(String userId) {this.userId = userId;}
    public String getEmail() {return email;}
    public void setEmail(String email) {this.email = email;}

    public String getLeader() {return leader;}
    public void setLeader(String leader) {this.leader = leader;}
    public String getPosition() {return position;}
    public void setPosition(String position) {this.position = position;}
    public String getRole() {return role;}
    public void setRole(String role) {this.role = role;}

    public String getStatus(){return status;}
    public void setStatus(String status){this.status = status;}

    public float getProgress(){return progress;}
    public void setProgress(float progress){this.progress = progress;}

    public ArrayList<MemberVO> getMemberVOList() { return memberVOList; }
    public void setMemberVOList(ArrayList<MemberVO> memberVOList) { this.memberVOList = memberVOList; }
}
