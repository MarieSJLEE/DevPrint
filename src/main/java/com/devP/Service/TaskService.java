package com.devP.Service;


import java.util.List;
import java.util.Map;

import com.devP.VO.TaskListVO;
import com.devP.VO.TaskVO;
import org.springframework.ui.Model;

public interface TaskService {
	List<Map<String, Object>> getTask();

	List<Map<String, Object>> getMyTasks();

	List<TaskVO> getProjectTaskList(int projectId);

	List<TaskVO> getMyProjectTaskList(TaskVO vo);

	int getUserTaskList(Model model);

	void getTaskCount(Model model);

	void addTask(TaskVO vo);
}
