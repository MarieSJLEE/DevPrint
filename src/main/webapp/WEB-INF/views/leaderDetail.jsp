<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel="stylesheet"  href="/resources/css/leaderDetail.css">
<%@include file="sidebar.jsp"%>
<head>
</head>
<body>
<div class="topBar">
    <%@include file="leaderTopBar.jsp" %>
</div>
<div class="container">
    <div class="leaderWrapper">
        <p class="projectName">${project.projectName}</p>
        <div class="contentsWrapper">
            <table class="btnTable">
                <tr>
                    <td>
                        <div class="leaderBtn"  onclick="location.href='manageTask.do'">
                            <p class="label">일정 및 업무 수정</p>
                        </div>
                    <td>
                </tr>
                <tr>
                    <td>
                        <div class="leaderBtn"  onclick="location.href='manageMember.do'">
                            <p class="label">멤버 추가 및 삭제</p>
                        </div>
                    <td>
                </tr>
                <tr>
                    <td>
                        <div class="leaderBtn" onclick="location.href='#'">
                            <p class="label">프로젝트 완료</p>
                        </div>
                    <td>
                </tr>
                <tr>
                    <td>
                        <div class="leaderBtn" onclick="location.href='#'">
                            <p class="label">프로젝트 삭제</p>
                        </div>
                    <td>
                </tr>
            </table>
            <div class="progressWrapper">
                <div class="progressBox">
                    <div class="projectProgress">
                        <span class="progressLabel">전체진행률</span>
                        <div class="progress">
                            <div style="width: ${project.progress}%;" class="progress-bar" />
                        </div>
                    </div>
                    <c:forEach items="${memberList}" var="member">
                        <div class="memberProgress">
                            <span>${member.userName}</span>
                            <div class="progress">
                                <div style="width:${member.progress}%;" class="progress-bar" />
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
