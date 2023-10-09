<%@include file="sidebar.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/insertProject.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<body>
<div class="mw-100 min-vw-90 min-vh-100 container">
    <div class="mx-5">
        <div class="main-text">새로운 프로젝트</div>
        <div class="ml-auto project-form">
        <form method="post" action="/project/insert.do" >
            <br>
            <div class="row mb-3">
                <label for="projectName" class="col-sm-2 col-form-label">프로젝트</label>
                <div class="col-sm-10">
                    <input name="projectName" type="text" class="form-control" id="projectName">
                </div>
            </div>
            <br>
            <c:set var="ymd" value="<%=new java.util.Date()%>" />
            <div class="row mb-3">
                <label for="startDate" class="col-sm-2 col-form-label">시작일</label>
                <div class="col-sm-10">
                    <input name="startDate" type="text" class="form-control" value="<fmt:formatDate value="${ymd}" pattern="yyyy-MM-dd" /> " id="startDate">
                </div>
            </div>
            <br>
            <div class="row mb-3">
                <label for="endDate" class="col-sm-2 col-form-label">종료일</label>
                <div class="col-sm-10">
                    <input name="endDate" type="text" class="form-control" id="endDate">
                </div>
            </div>
            <br>
            <div class="row mb-3">
                <label for="addMember" class="col-sm-2 col-form-label">멤버추가</label>
    <%--            <form class="manageMemberWrapper" action="/project/addMember.do" method="post">--%>
                    <div class="col-sm-10" id="addMember">
                        <input class="formInput form-control" placeholder="devp@devp.com" name="email">
                    </div>
    <%--                <div class="col-auto"><input class="form-control" type="submit" value="send"></div>--%>
    <%--            </form>--%>
            </div>
            <div class="manage-wrapper">
                <div class="addMember">
    <%--                <form class="manageMemberWrapper" action="/project/addMember.do" method="post">--%>
                        <div class="addMemberLine row g-3 align-items-center">
    <%--                    </div>--%>
                    </form>
                </div>
            </div>
            <br>
            <div class="row mb-3">
                <label for="script" class="col-sm-2 col-form-label">설명</label>
                <div class="col-sm-10">
                    <textarea name="script" class="form-control" id="script"></textarea>
                </div>
            </div>
            <br>
            <div class="row mb-3">
                <label for="addMember" class="col-sm-2 col-form-label">일정 및 업무 분배</label>
                <!-- <jsp:include page="/WEB-INF/views/addTask.jsp"/> -->
                <jsp:include page="/WEB-INF/views/addWbsFile.jsp"/>
            </div>
            <br>
    <%--        <div class="col mb-3">--%>
    <%--            <label class="col-sm-2 col-form-label input-border">시작일</label>--%>
    <%--            <input name="startDate" class="col-sm-10" value="<fmt:formatDate value="${ymd}" pattern="yyyy-MM-dd" />">--%>
    <%--        </div><br>--%>
    <%--        <div class="row mb-3">--%>
    <%--            <label class="col-sm-2 col-form-label input-border">설명</label>--%>
    <%--            <br>--%>
    <%--            <textarea name="script" class="col-sm-10"></textarea>--%>
    <%--        </div>--%>
    <%--        <br>--%>
            <button type="submit" class="col-sm-12">프로젝트 추가</button>
        </form>
        </div>
</div>
</div>
</body>
</html>