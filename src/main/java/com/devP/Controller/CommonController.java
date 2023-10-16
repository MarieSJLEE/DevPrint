package com.devP.Controller;

import com.devP.Service.IssueService;
import com.devP.Service.ProjectService;
import com.devP.Service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class CommonController {

    @Autowired
    private IssueService issueService;
    @Autowired
    private TaskService taskService;

    @Autowired
    private ProjectService projectService;
    @Autowired
    private HttpSession session;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String mainView(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        String userId = (String)session.getAttribute("id");
        session.setAttribute("title", logincheck(userId, request));
        session.removeAttribute("projectName");
        session.removeAttribute("projectId");

        if(session.getAttribute("id")!=null) {
            issueService.getUserIssueList(model);
            if(taskService.getUserTaskList(model) == 200) {
                return "main";
            }
            return null;
        }
        else return "login";
    }


    public String logincheck(String id, HttpServletRequest request) {

        HttpSession session = request.getSession();

        if(id != null){
            String loginSuccess = id +"님, 반갑습니다.";
            session.setAttribute("login", "로그아웃");
            return loginSuccess;
        }
        else{
            session.setAttribute("login", "로그인");
            return "로그인 후 이용하세요.";
        }
    }

    @RequestMapping(value = "/push", method = RequestMethod.GET)
    public String pushNotificationView(){
        return "pushNotification";
    }
}
