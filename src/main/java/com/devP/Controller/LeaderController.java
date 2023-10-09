package com.devP.Controller;

import com.devP.Service.LeaderService;
import com.devP.Service.ProjectService;
import com.devP.Service.UserService;
import com.devP.VO.*;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
//@SessionAttributes("leader")
public class LeaderController {

    @Autowired
    private UserService userService;
    @Autowired
    private LeaderService leaderService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private MailController mailController;

    @Autowired
    private HttpSession session;


    // 멤버페이지
    @ModelAttribute("positionMap")
    public Map<String, String> setRoleMap(){
        Map<String, String> roleMap = new HashMap<String, String>();
        roleMap.put("팀장","팀장");
        return roleMap;
    }

    @ModelAttribute("roleMap")
    public Map<String, String> setPositionMap(){
        Map<String, String> positionMap = new HashMap<String, String>();
        positionMap.put("FE", "FE");
        positionMap.put("BE", "BE");
        positionMap.put("Design", "Design");
        positionMap.put("Server", "Server");

        return positionMap;

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


        return categoryMap;
    }


    @RequestMapping(value="/project/leader.do", method=RequestMethod.GET)
    public String leaderDetailView(@RequestParam int projectId, ProjectVO vo, Model model){
        vo.setProjectId(projectId);
        leaderService.getLeaderView(vo, model);
        // projectService.getProjectName(vo);
        // projectService.getProjectProgress(vo);
        return "leaderDetail";
    }


    @RequestMapping(value="/project/manageMember.do", method = RequestMethod.GET)
    public String manageMemberView(MemberVO vo, Model model){
        vo.setProjectId(Integer.parseInt(session.getAttribute("projectId").toString()));
        int result = leaderService.getMemberList(vo, model);
        if (result == 200) return "manageMember";
        else return "redirect:/login.do";
    }

    @RequestMapping(value = "/project/addMember.do", method = RequestMethod.POST)
    public String addMember(String user, ProjectVO vo, MemberVO vo2, ProjectGroupVO vo3) throws Exception {
        vo3.setProjectId(Integer.parseInt(session.getAttribute("projectId").toString()));
        int result = leaderService.addMember(user, vo, vo2, vo3);
        return "redirect:/project/manageMember.do";
    }

    @RequestMapping(value="project/addProject/verify", method = RequestMethod.GET)
    public String invitedVerify(MemberVO vo, @RequestParam String token){
//        String code = token;
//        System.out.println(token);
        leaderService.invitedVerify(vo, token);

        return "redirect:/login.do";

    }

    @RequestMapping(value="/project/updateMember.do", method = RequestMethod.POST)
    public String updateMember(@ModelAttribute MemberVO memberVO, Model model){


//        for(MemberVO vo: memberVO.getMemberVOList()){
//            System.out.println(vo.getUserId());
//        }
//        if(memberVO.getMemberVOList() == null){ System.out.println("다시해");}
//        System.out.println(memberVO.getMemberVOList());
        int result = leaderService.updateMemberDatas(memberVO.getMemberVOList(), model);

        if(result == 200) return "redirect:/project/manageMember.do";
        else return "redirect:/";
    }

    @RequestMapping(value = "/project/deleteMember.do", method = RequestMethod.POST)
    public ResponseEntity<String> deleteMember(MemberVO vo, HttpServletRequest request ) throws Exception {
        try {
            String userId = request.getParameter("userId");
            int projectId = Integer.parseInt(request.getParameter("projectId"));
            System.out.println(userId);
            leaderService.deleteMember(vo, userId, projectId);

            return ResponseEntity.ok("Member deleted successfully");
        } catch (Exception e){
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred");

        }

    }
    @RequestMapping(value="/project/manageTask.do", method = RequestMethod.GET)
    public String manageTask(TaskVO vo, Model model){
        vo.setProjectId(Integer.parseInt(session.getAttribute("projectId").toString()));
        int result = leaderService.getTaskDatas(vo, model);
        if (result == 200) return "manageTask";
        else return "redirect:/";
    }
    @RequestMapping(value="project/addTask.do", method = RequestMethod.POST)
    public String addTask(TaskVO vo){
        System.out.println(vo.getCategory());
        int result = leaderService.addTask(vo);

        if(result == 200){ return "redirect:/project/manageTask.do";}
        else {return "/";}

    }

}
