<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/manageMemberStyles.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@include file="sidebar.jsp"%>
<head>
    <title>멤버관리</title>
</head>
<body>
<div class="container">
    <p class="projectName">${projectName}</p>
    <p class="semiTitle">프로젝트관리-멤버 추가/삭제</p>
    <div class="manage-wrapper">
        <div class="addMember">
            <form class="manageMemberWrapper" action="/project/addMember.do" method="post">
                <div class="addMemberLine row g-3 align-items-center">
                <div class="col-auto">
                    <label class="formLabel col-form-label"> 멤버추가</label>
                </div>
                <div class="col-auto">
                    <input type="hidden" value="${projectName}" name="projectName" />
                    <input class="formInput form-control" type="email" placeholder="devp@devp.com" name="user">
                </div>
                <div class="col-auto"><input class="form-control" type="submit" value="send"></div>
                </div>
            </form>
        </div>
    </div>
    <div  class="member-wrapper">
        <p class="manageMemberWrapper formLabel col-form-label">멤버 관리</p>
        <form:form class="manageForm" modelAttribute="MemberVO" name="dataForm" id="dataForm" method="post" action="/project/updateMember.do" >
            <table class="table" width=500px;>
                <thead>
                    <tr>
                        <th class="col-md-2" scope="col" width="10%">이름</th>
                        <th class="col-md-4" scope="col">이메일</th>
                        <th class="col-md-2" scope="col">직책</th>
                        <th class="col-md-2" scope="col">역할</th>
                        <th class="col-md-2" scope="col">상황</th>
                        <th class="col-md-2" scope="col">삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${memberList}" var="member" varStatus="loop">
                        <tr>
                            <input type="hidden" value="${projectId}" name="memberVOList[${loop.index}].projectId">
                            <input type="hidden" value="${member.userId}" name="memberVOList[${loop.index}].userId">
                            <td>${member.userName}</td>
                            <td>${member.email}</td>
                            <td>
                            <select class="form-select" name="memberVOList[${loop.index}].position" id="roleSelect">
                                <option value="" <c:if test="${empty member.position}"> selected</c:if>>
                                선택
                                </option>
                                <c:forEach items="${positionMap}" var="option">
                                <option value="${option.value}"
                                    <c:if test="${option.value eq member.position}">
                                        selected
                                    </c:if>
                                >${option.key}
                                </option>
                                </c:forEach>
                            </select>
                            </td>

                            <td>
                            <select class="form-select" name="memberVOList[${loop.index}].role" id="roleSelect">
                                <option value="" <c:if test="${empty member.role}"> selected</c:if>>
                                선택
                                </option>
                                <c:forEach items="${roleMap}" var="option">
                                <option value="${option.value}"
                                    <c:if test="${option.value eq member.role}">
                                        selected
                                     </c:if>
                                >${option.key}
                                </option>
                                </c:forEach>
                            </select>
                            </td>
                            <td>
                                <c:if test="${member.status != '1'}">
                                대기
                                </c:if>
                            </td>
                            <td>
                                <input class="form-control" type="button" value="삭제" onclick="deleteMember('${member.userId}','${projectName}', ${projectId})" />
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <input class="form-control" type="submit" value="수정">
        </form:form>
    </div>
</div>
<script src="/resources/js/manageMemberScript.js"></script>
</body>
</html>
