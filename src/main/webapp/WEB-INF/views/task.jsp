<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/task.css">
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@include file="sidebar.jsp"%>
<head>
    <title></title>
</head>
<body>
<div class="mv-100 container">
    <p class="projectName">${project.projectName}</p>
    <p class="semiTitle">업무</p>
    <div class="contentsBox">
        <p class="labelWrapper">진행률</p>
        <div class="projectProgress">
            <span class="progressLabel">전체진행률</span>
            <div class="progress">
                <div style="width: ${project.progress}%;" class="progress-bar bg-warning text-dark">${project.progress}%</div>
            </div>
        </div>
        <div class="projectProgress">
            <span class="progressLabel">${member.userName}</span>
            <div class="progress">
                <div style="width: ${member.progress}%;" class="progress-bar bg-warning text-dark">${member.progress}%</div>
            </div>
        </div>
    </div>
    <div class="contentsBox">
        <p class="labelWrapper">WBS</p>
        <div class="wbsWrapper">
            <div class="wbsBox">
                <div id="chart_div"></div>
            </div>
        </div>
    </div>
    <div class="contentsBox">
        <p class="labelWrapper">일정</p>
        <div class="taskWrapper">
            <div class="taskBox">
                <div id="">
                    <form>
                        <table class="table" width=500px;>
                            <thead>
                                <tr>
                                    <th class="col-md-2" scope="col" width="10%">No</th>
                                    <th class="col-md-4" scope="col">시작일</th>
                                    <th class="col-md-2" scope="col">종료일</th>
                                    <th class="col-md-2" scope="col">depth</th>
                                    <th class="col-md-2" scope="col">디테일</th>
                                    <th class="col-md-2" scope="col">진행률</th>
                                    <th class="col-md-2" scope="col">이슈</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${taskList}" var="task" varStatus="status">
                                    <tr>
                                        <td>${status.count}</td>
                                        <td >${task.startdate}</td>
                                        <td>${task.enddate}</td>
                                        <td>${task.depth}</td>
                                        <td>${task.detail}</td>
                                        <td>${task.progress}</td>
                                        <td>
                                            <input class="form-control" type="button" value="이슈" onclick="location.href='/issue/write.do?projectId=${project.projectId}'" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
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
    var dayPassed = dateDifference(startDate,today);
    if(dayPassed>=0){
        var dayPassed = (today-startDate+1)/(endDate-startDate+1);
        percentage = Math.round(dayPassed * 100);
    } else {
        percentage = 0;
    }
    if (percentage > 100) percentage = 100;
    var datas = ["${task.taskId}","${task.detail}","${task.workPackage}",
                 startDate,endDate,null,percentage, null];

    dataArray.push(datas);
</c:forEach>

google.charts.load('current', {'packages':['gantt']});
google.charts.setOnLoadCallback(drawChart);

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
            trackHeight: 30
        }
    };

    var chart = new google.visualization.Gantt(document.getElementById('chart_div'));

    chart.draw(data, options);

}
</script>
</body>
</html>
