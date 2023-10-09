package com.devP.VO;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//VO(Value Object)
public class TaskVO {
	private int taskId;
	private int projectId;
    private String userId;
    private String category;
	private String workPackage;
    private int priority;
    private String depth;
    private String detail;
    private int progress;
	private String status;

    private String startdate;
    private String enddate;
    
    public int getTaskId() {
		return taskId;
	}
	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}
	public int getProjectId() {
		return projectId;
	}
	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getWorkPackage() {return workPackage;	}
	public void setWorkPackage(String workPackage) {this.workPackage = workPackage;	}
	public String getStatus() {return status;	}
	public void setStatus(String status) {this.status = status;	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public String getDepth() {
		return depth;
	}
	public void setDepth(String depth) {
		this.depth = depth;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public int getProgress() {
		return progress;
	}
	public void setProgress(int progress) {
		this.progress = progress;
	}
	public String  getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {

		this.startdate = startdate;
	}
	public String  getEnddate() {
		return enddate;
	}
	public void setEnddate(String  enddate) {
		this.enddate = enddate;
	}
}