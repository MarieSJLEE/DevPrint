package com.devP.Mapper.Impl;


import com.devP.Mapper.Repository.TaskDAOMybatis;
import com.devP.Service.TaskService;
import com.devP.VO.TaskListVO;
import com.devP.VO.TaskVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

@Service("taskService")
public class TaskServiceImpl implements TaskService {



    @Autowired
    private TaskDAOMybatis taskDAO;

    @Autowired
    private HttpSession session;

	@Override
	@ModelAttribute("categoryMap")
	public Map<String, String> setCategoryMap() {
		Map<String, String> categoryMap = new HashMap<>();

		categoryMap.put("1", "기획");
		categoryMap.put("2", "디자인");
		categoryMap.put("3", "구현");
		categoryMap.put("4", "개발");
		categoryMap.put("5", "서버");
		categoryMap.put("6", "테스트");
		categoryMap.put("7", "완료");


		return categoryMap;
	}
	@ModelAttribute("statusMap")
	public Map<String, String> setStatusMap(){
		Map<String,String> statusMap = new HashMap<>();

		statusMap.put("1","대기");
		statusMap.put("2","진행중");
		statusMap.put("3","검토");
		statusMap.put("4","완료");

		return statusMap;
	}

	@Override
	public List<Map<String, Object>> getMyTasks() {
		List<TaskVO> voList = new ArrayList<TaskVO>();
		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			TaskVO task = new TaskVO();
			task.setUserId(session.getAttribute("id").toString());
			task.setProjectId((int) session.getAttribute("projectId"));
			voList = taskDAO.getMyTask(task);
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		for (TaskVO vo : voList) {
			Map<String, Object> result = new HashMap<>();
//    		String formattedstartDate = dateFormat.format(vo.getStartdate());
//    		String formattedendDate = dateFormat.format(vo.getEnddate());
			result.put("taskId", vo.getTaskId());
			result.put("title", vo.getDetail());
			result.put("progress", vo.getProgress());
			result.put("start", vo.getStartdate());
			result.put("end", vo.getEnddate());
			result.put("allday", true);
			resultList.add(result);
		}
		return resultList;
	}
	@Override
	public List<Map<String, Object>> getTask() {
		List<TaskVO> voList = new ArrayList<TaskVO>();
    	List<Map<String, Object>> resultList = new ArrayList<>();
    	try {
    		TaskVO task = new TaskVO();
    		task.setUserId(session.getAttribute("id").toString());
    		task.setProjectId((int) session.getAttribute("projectId"));
    		voList = taskDAO.getTask(task);
    	}catch (Exception e) {
			// TODO: handle exception
    		System.out.println(e);
		}
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    	for (TaskVO vo : voList) {
        	Map<String, Object> result = new HashMap<>();
//    		String formattedstartDate = dateFormat.format(vo.getStartdate());
//    		String formattedendDate = dateFormat.format(vo.getEnddate());
            result.put("taskId", vo.getTaskId());
            result.put("title", vo.getDetail());
            result.put("progress", vo.getProgress());
            result.put("start", vo.getStartdate());
            result.put("end", vo.getEnddate());
            result.put("allday", true);
            resultList.add(result);
		}
		return resultList;
	}

	@Override
	public List<TaskVO> getProjectTaskList(int projectId){
		return taskDAO.getProjectTaskList(projectId);
	}

	@Override
	public List<TaskVO> getMyProjectTaskList(TaskVO vo){
		return taskDAO.getMyProjectTaskList(vo);
	}
	public int getUserTaskList(Model model){
		if(session.getAttribute("id") != null) {
			String userId = (String) session.getAttribute("id");
			List<TaskListVO> vo = taskDAO.getUserTaskList(userId);

			model.addAttribute("taskList", taskDAO.getUserTaskList(userId));
			return 200;
		}else{
			return 405;
		}
	}



	@Override
	public void getTaskCount(Model model) {
		int progresscount = 0, completedcount = 0, pastcount = 0;
		List<TaskVO> voList = new ArrayList<TaskVO>();
		TaskVO task = new TaskVO();
		task.setUserId(session.getAttribute("id").toString());
		task.setProjectId((int) session.getAttribute("projectId"));
		voList = taskDAO.getTask(task);
		for (TaskVO vo: voList) {
			if(vo.getEnddate().compareTo(String.valueOf(new Date())) > 0){
				pastcount++;
			}
			else if(vo.getProgress() >= 0 && vo.getProgress() < 100) {
				progresscount++;
			}else if(vo.getProgress() == 100){
				completedcount++;
			}
		}
		model.addAttribute("pasttaskcount", pastcount);
		model.addAttribute("progresstaskcount", progresscount);
		model.addAttribute("completedtaskcount", completedcount);
	}

	public void addTask(TaskVO vo){taskDAO.insertTask(vo);}
	public void updateTask(TaskVO vo){taskDAO.updateTask(vo);}

	public void deleteTask(int taskId){taskDAO.deleteTask(taskId);}
}
