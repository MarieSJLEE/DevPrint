package com.devP.Mapper.Impl;


import com.devP.Mapper.Repository.TaskDAOMybatis;
import com.devP.Service.TaskService;
import com.devP.VO.TaskListVO;
import com.devP.VO.TaskVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

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
}
