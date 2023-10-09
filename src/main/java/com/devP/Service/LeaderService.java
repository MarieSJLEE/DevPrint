package com.devP.Service;

import com.devP.VO.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public interface LeaderService {

    void getLeaderView(ProjectVO vo, Model model);

    int getMemberList(MemberVO vo, Model model);

    int addLeader(MemberVO vo,int projectId);

    int addMember(String members,ProjectVO vo, MemberVO vo2, ProjectGroupVO vo3) throws Exception;

    MemberVO findMember(MemberVO vo);

    void insertMember(MemberVO vo);

    void reInvited(MemberVO vo);

    int invitedVerify(MemberVO vo, String token);

    MemberVO getMemberByToken(MemberVO vo);

    void updateMemberStatus(MemberVO vo);

    int updateMemberDatas(ArrayList<MemberVO> memberVOList, Model model);

    void deleteMember(MemberVO vo, String userId, int projectId);

    int getTaskDatas(TaskVO vo, Model model);

    int addTask(TaskVO vo);
}
