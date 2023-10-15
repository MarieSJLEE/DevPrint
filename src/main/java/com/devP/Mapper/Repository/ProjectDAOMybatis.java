package com.devP.Mapper.Repository;

import com.devP.VO.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import java.util.List;
@Repository
public class ProjectDAOMybatis {

    @Autowired
    private SqlSessionTemplate mybatis;

    public int insertProject(ProjectVO vo, MemberVO vo2, ProjectGroupVO vo3) {
        return mybatis.insert("ProjectDAO.insertProject", vo);
    }

    public int getProjectId(ProjectVO vo) {
        return mybatis.selectOne("ProjectDAO.getProjectId", vo);
    }

    public ProjectVO getProject(ProjectVO vo) {
        return mybatis.selectOne("ProjectDAO.getProject", vo);
    }

    public String getProjectName(int projectId) {
        return mybatis.selectOne("ProjectDAO.getProjectName", projectId);
    }

    public int getProjectProgress(ProjectVO vo) {
        return mybatis.selectOne("ProjectDAO.getProjectProgress", vo);
    }

    public List<ProjectListVO> getProjectList(String userId) {
        return mybatis.selectList("ProjectDAO.getProjectList", userId);
    }

    public List<String> getMemberNames(int projectId){return mybatis.selectList("ProjectDAO.getMemberNames", projectId);}

}
