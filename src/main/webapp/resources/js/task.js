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