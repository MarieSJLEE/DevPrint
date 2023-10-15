package com.devP.Controller;

import com.devP.Service.IssueService;
import com.devP.Service.LeaderService;
import com.devP.Service.ProjectService;
import com.devP.Service.TaskService;
import com.devP.VO.MemberVO;
import com.devP.VO.ProjectGroupVO;
import com.devP.VO.ProjectVO;
import com.devP.VO.TaskVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@SessionAttributes("project")
@RequestMapping("project")
public class ProjectController {
	

    @Autowired
    private IssueService issueService;
    
        @Autowired
        private ProjectService projectService;

        @Autowired
        private TaskService taskService;

        @Autowired
        private LeaderService leaderService;

        @Autowired
        private MailController mailController;

        @Autowired
        private HttpSession session;


        //프로젝트 추가 화면
        @RequestMapping(value = "/insert.do", method = RequestMethod.GET)
        public String insertProjectView() {
            if(projectService.insertProjectView() == 200) {
                    return "insertProject";
            }else if(projectService.insertProjectView() == 405){
                    return "redirect:/login.do";
            }else{
                    return "redirect:/";
            }
        }

        
        //프로젝트 상세
        @RequestMapping(value="/detail.do", method= RequestMethod.GET)
  	    public String projectView(@RequestParam int projectId, ProjectVO vo, MemberVO member, Model model){
        model.addAttribute("menuId", "projectMenu");
            if(session.getAttribute("projectId")!=null) session.removeAttribute("projectId");
            session.setAttribute("projectId", projectId);
            vo.setProjectId(projectId);
            member.setProjectId(projectId);
            member.setUserId(session.getAttribute("id").toString());

            // 프로젝트 데이터 가져오기
            //이슈 리스트 가져오기
      	issueService.getIssuelist(projectId, model);
      	//멤버 리스트 가져오기
            model.addAttribute("project",projectService.getProject(vo));
            model.addAttribute("myData",projectService.getMyProjectData(member));
      	model.addAttribute("memberList", projectService.getProjectMemberList(projectId));
      	model.addAttribute("myTask", taskService.getTask());
      	taskService.getTaskCount(model);
  	        return "projectDetail";
      	}

        @RequestMapping(value = "/insert.do", method = RequestMethod.POST)
        public String insertProject(@ModelAttribute ProjectVO vo, MemberVO vo2, ProjectGroupVO vo3) throws Exception {
            int result = projectService.insertProject(vo, vo2, vo3);
            if(result == 200) {
                int projectId = projectService.getProjectId(vo);
                session.setAttribute("projectId",projectId);
                return "redirect: /project/insertTask.do";
            }
            else if(result == 405) return "redirect: /project/insertProject.do";
            return null;
        }
        @RequestMapping(value = "/insertTask.do", method = RequestMethod.GET)
        public String insertTaskView(TaskVO vo, Model model){
            vo.setProjectId(Integer.parseInt(session.getAttribute("projectId").toString()));
            List<String> nameList = projectService.getMemberNames(vo.getProjectId());

            model.addAttribute("categoryMap", taskService.setCategoryMap());

            int result = leaderService.getTaskDatas(vo, model);

            if(result == 200) return "insertTask";
            else {
                session.removeAttribute("projectId");
                return "redirect:/list.do";
            }
        }

        @RequestMapping(value = "/insertTask.do", method = RequestMethod.POST)
        public String insertTask(TaskVO vo){
            int result = leaderService.addTask(vo);
            if(result == 200) return "redirect:/project/insertTask.do";
            else {
                session.removeAttribute("projectId");
                return "redirect:/list.do";
            }
        }


        //프로젝트 목록
        @RequestMapping(value = "/list.do", method = RequestMethod.GET)
        public String projectList(Model model) {
             if(projectService.getProjectList(model) == 200){
                    return "projectList";
            } else if (projectService.getProjectList(model) == 405) {
                    return "login";
            }
            return null;
        }

        @RequestMapping(value="/myTask.do", method = RequestMethod.GET)
        public String myTaskView(ProjectVO project, MemberVO member, TaskVO task, Model model) throws Exception {
            model.addAttribute("menuId","taskMenu");
            int result = projectService.showTaskView(project, member, task, model);
            if(result == 200) return "task";
            else return "man";
        }


        @RequestMapping(value="/member.do", method = RequestMethod.GET)
        public String manageMemberView(MemberVO vo, HttpSession session, Model model) {
            model.addAttribute("menuId","memberMenu");
            int result = projectService.showProjectMemberList(vo, model);

            if (result == 200) return "member";
            else return "main";
        }

        //멤버 가져오기
        @RequestMapping(value="/getTeam.do", method = RequestMethod.GET)
        public String getTeamView(){
            return "member";
        }
}
