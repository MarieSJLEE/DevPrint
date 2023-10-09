package com.devP.Controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.devP.Service.TaskService;

@Controller
@RequestMapping("task")
public class TaskController {
	

	@Autowired
	private TaskService taskService;


	private String toJson(Object object){
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			return objectMapper.writeValueAsString(object);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
			return "{}";
		}
	}

	@ModelAttribute("categoryMap")
	public Map<String, String> setCategoryMap(Model model){
		Map<String,String> categoryMap = new HashMap<>();

		categoryMap.put("1","기획");
		categoryMap.put("2","디자인");
		categoryMap.put("3","구현");
		categoryMap.put("4","개발");
		categoryMap.put("5","서버");
		categoryMap.put("6","테스트");
		categoryMap.put("7","완료");

		String categoryMapJson = toJson(categoryMap);
		model.addAttribute("categoryMapJson", categoryMapJson);

		return categoryMap;
	}


	//업무 가져오기
    @RequestMapping(value="/getTask.do", method= RequestMethod.GET, produces="application/json;charset=UTF-8")
    @ResponseBody
	    public List<Map<String, Object>> getTask(){
	    return taskService.getTask();
  	}

	@RequestMapping(value="/getMyTasks.do", method= RequestMethod.GET, produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<Map<String, Object>> getMyTask(){ return taskService.getMyTasks(); }


	// 업무 추가 뷰
	@RequestMapping(value = "/insertTask.do", method = RequestMethod.GET)
	public String addTask(){ return "addTask"; }
}
