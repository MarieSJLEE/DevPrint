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
    <title>업무관리</title>
</head>
<body>
<div class="container">
    <p class="projectName">${projectName}</p>
    <p class="semiTitle">업무 수정</p>
    <div class="manage-wrapper">
        <div class="addMember">
            <div class="manageMemberWrapper">
                <div class="col-auto">
                    <label class="formLabel col-form-label">업무추가</label>
                </div>
            </div>
            <div class="row">
                <form method="post" action="/project/addTask.do">
                    <div id="box">
                        <div class="addForm">
                            <table id="taskTbl" class="table" width=500px;>
                                <thead>
                                    <tr>
                                        <th class="" scope="col">Category</th>
                                        <th class="" scope="col">Work Package</th>
                                        <th class="" scope="col">depth</th>
                                        <th class="" scope="col">detail</th>
                                        <th class="" scope="col">담당자</th>
                                        <th class="" scope="col">시작일</th>
                                         <th class="" scope="col">종료일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <select class="form-select" name="category" id="categorySelect">
                                                <option value="" disabled selected> 선택</option>
                                                <c:forEach items="${categoryMap}" var="category">
                                                    <option value="${category.value}">${category.value}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td><input class="form-control" type="text" name="workPackage"></td>
                                        <td><input class="form-control" type="text" name="depth"></td>
                                        <td><input class="form-control" type="text" name="detail"></td>
                                        <td><select class="form-select" name="responsibility" id="responsibilitySelect">
                                            <option value="" disabled selected> 선택</option>
                                            <c:forEach items="${memberMap}" var="member">
                                                <option value="${member.value}">${member.value}</option>
                                            </c:forEach>
                                        </select></td>
                                        <td><input class="form-control" type="date"  name="startdate" id="startDate"/></td>
                                        <td><input class="form-control" type="date"  name="enddate" id="endDate" /></td>
                                    </tr>
                                </tbody>
                            </table>
                            <input class="form-control" type="submit" value="추가">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div  class="member-wrapper">
        <div class="manageMemberWrapper">
            <div class="col-auto">
                <label class="formLabel col-form-label">업무추가</label>
            </div>
        </div>
        <div class="row">
            <form class="manageTask"  method="post" action="/project/addTask.do">
                <div>
                    <div class="addForm">
                        <table class="table" width=500px;>
                            <thead>
                                <tr>
                                    <th class="" scope="col">Category</th>
                                    <th class="" scope="col">Work Package</th>
                                    <th class="" scope="col">depth</th>
                                    <th class="" scope="col">detail</th>
                                    <th class="" scope="col">담당자</th>
                                    <th class="" scope="col">시작일</th>
                                    <th class="" scope="col">종료일</th>
                                    <th class="" scope="col">상태</th>
                                    <th class="" scope="col">진행률</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${taskList}" var="task" varStatus="status">
                                    <tr>
                                        <td>
                                            <select class="form-select" name="category">
                                                <c:forEach items="${categoryMap}" var="category">
                                                    <option value="${category.value}"
                                                        <c:if test="${category.value eq task.category}"> selected</c:if>
                                                    >${category.value}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td><input class="form-control" type="text" name="workPackage" value="${task.workPackage}"></td>
                                        <td><input class="form-control" type="text" name="depth" value="${task.depth}"></td>
                                        <td><input class="form-control" type="text" name="detail" value="${task.detail}"></td>
                                        <td><select class="form-select" name="responsibility">
                                            <option value="" disabled selected> 선택</option>
                                            <c:forEach items="${memberMap}" var="member">
                                                <option value="${member.value}"
                                                    <c:if test="${member.key eq task.userId}"> selected</c:if>
                                                >${member.value}</option>
                                            </c:forEach>
                                        </select></td>
                                        <td><input class="form-control" type="date"  name="startdate" value="${task.startdate}"/></td>
                                        <td><input class="form-control" type="date"  name="enddate" value="${task.enddate}"/></td>
                                        <td><input class="form-control" type="text" name="status" value="${task.status}"></td>
                                        <td><input class="form-control" type="text" name="progress" value="${task.progress}"></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <input class="form-control" type="submit" value="수정">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="/resources/js/addTask.js"></script>
<script>
</script>
</body>
</html>
