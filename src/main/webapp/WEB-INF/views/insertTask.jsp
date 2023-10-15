<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/manageTask.css">
<link rel="stylesheet" href="/resources/css/task.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
<%@include file="sidebar.jsp"%>
<head>
    <title>업무관리</title>
</head>
<body>
<div class="mv-100 container">
    <div>
        <p class="projectName">
            ${projectName}
            <button class="btn btn-outline-success" type="button" onclick="location.href='list.do'">완료</button>
        </p>
    </div>
    <div class="manage-wrapper">
        <div class="addMember">
            <div class="manageTaskWrapper">
                <div class="col-auto">
                    <label class="formLabel col-form-label">업무추가</label>
                </div>
            </div>
            <div class="row">
                <form method="post" action="/project/insertTask.do">
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
                                        <td><input class="form-control startDate" type="date"  name="startdate" id="startDate"/></td>
                                        <td><input class="form-control endDate" type="date"  name="enddate" id="endDate" /></td>
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
    <div class="manage-wrapper">
        <div class="manageTaskWrapper">
            <div class="col-auto">
                <label class="formLabel col-form-label">간트차트</label>
            </div>
            <div class="wbsBox col-auto">
                <div id="chart_div"></div>
            </div>
        </div>
    </div>
    <div  class="member-wrapper">
        <div class="manageTaskWrapper">
            <div class="col-auto">
                <label class="formLabel col-form-label">업무수정</label>
            </div>
        </div>
        <div class="row">
            <form:form class="manageTask" modelAttribute="TaskVO" name="dataForm" method="post" action="/project/updateTask.do">
                <div>
                    <div class="manageForm">
                        <table class="table taskTbl">
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
                                <c:forEach items="${taskList}" var="task" varStatus="loop">
                                    <input type="hidden" name="taskVOList[${loop.index}].taskId" value="${task.taskId}">
                                    <input type="hidden" name="taskVOList[${loop.index}].projectId" value="${task.projectId}">
                                    <tr>
                                        <td>
                                            <select class="form-select" name="taskVOList[${loop.index}].category">
                                                <c:forEach items="${categoryMap}" var="category">
                                                    <option value="${category.value}"
                                                        <c:if test="${category.value eq task.category}"> selected</c:if>
                                                    >${category.value}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td><input class="form-control" type="text" name="taskVOList[${loop.index}].workPackage" value="${task.workPackage}"></td>
                                        <td><input class="form-control" type="text" name="taskVOList[${loop.index}].depth" value="${task.depth}"></td>
                                        <td><input class="form-control" type="text" name="taskVOList[${loop.index}].detail" value="${task.detail}"></td>
                                        <td><select class="form-select" name="taskVOList[${loop.index}].userId">
                                            <c:forEach items="${memberMap}" var="member">
                                                <option value="${member.key}"
                                                    <c:if test="${member.key eq task.userId}"> selected</c:if>
                                                >${member.value}</option>
                                            </c:forEach>
                                        </select></td>
                                        <td><input class="form-control startDate" type="date"  name="taskVOList[${loop.index}].startdate" value="${task.startdate}"/></td>
                                        <td><input class="form-control endDate" type="date"  name="taskVOList[${loop.index}].enddate" value="${task.enddate}"/></td>
                                        <td>
                                            <select class="form-select" name="taskVOList[${loop.index}].status" id="statusSelect">
                                                <c:forEach items="${statusMap}" var="status">
                                                    <option value="${status.value}"
                                                        <c:if test="${status.value eq task.status}"> selected</c:if>
                                                    >${status.value}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td><input class="form-control" type="text" name="taskVOList[${loop.index}].progress" value="${task.progress}"></td>
                                        <td><input class="form-control" type="button" value="삭제" onclick="deleteTask('${task.taskId}')" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <input class="form-control" type="submit" value="수정">
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>

<script src="/resources/js/manageTask.js"></script>
<script type="text/javascript">
function getCurrentDate(){
        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth()+1).padStart(2,'0');
        const day = String(now.getDate()).padStart(2,'0');

        return year+"-"+month+"-"+day;
}
$(document).ready(function(){
    const currentDate = getCurrentDate();
    document.getElementById('startDate').setAttribute('min', currentDate);
    document.getElementById('startDate').setAttribute('value', currentDate);
    document.getElementById('endDate').setAttribute('min', currentDate);
    document.getElementById('endDate').setAttribute('value', currentDate);
});
</script>
<script type="text/javascript">
var dataArray = [];

function dateDifference(a, b){
    return (b-a+1)/(1000 * 60 * 60 * 24);
}

<c:forEach items="${taskList}" var="task" varStatus="status">
    var percentage = 0;
    var startDate = new Date("${task.startdate}");
    var endDate = new Date("${task.enddate}");
    var today = new Date();
    var daysDifference = dateDifference(startDate,endDate);
    var days = dateDifference(startDate,today);
    if(days>=0){
        var dayPassed = days/daysDifference;
        percentage = Math.round(dayPassed * 100);
    } else {
        percentage = 0;
    }
    if (percentage > 100) percentage = 100;
    var datas = ["${task.taskId}","${task.detail}","${task.workPackage}",
                 startDate,endDate,null,percentage, null];

    dataArray.push(datas);
</c:forEach>


if(dataArray[0] !== null && dataArray.length>0){
    google.charts.load('current', {'packages':['gantt']});
    google.charts.setOnLoadCallback(drawChart);
}

function drawChart(){
    console.log(dataArray);

    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Task ID');
    data.addColumn('string', 'Task Name');
    data.addColumn('string', 'workPackage');
    data.addColumn('date', 'Start Date');
    data.addColumn('date', 'End Date');
    data.addColumn('number', 'Duration');
    data.addColumn('number', 'Percent Complete');
    data.addColumn('string', 'Dependencies');

    data.addRows(dataArray);

    var options = {
        height: 400,
        gantt: {
            trackHeight: 50
        }
    };

    var chart = new google.visualization.Gantt(document.getElementById('chart_div'));

    chart.draw(data, options);

}



</script>
</body>
</html>
