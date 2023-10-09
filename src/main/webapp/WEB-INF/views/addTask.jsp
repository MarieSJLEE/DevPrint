<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<body>
    <form>
        <div id="box">
            <div class="addForm">
                    <table id="taskTbl" class="table" width=500px;>
                        <thead>
                            <tr>
                                <th class="" scope="col">Category</th>
                                <th class="" scope="col">Work Package</th>
                                <th class="" scope="col">depth</th>
                                <th class="" scope="col">detail</th>
                                <th class="" scope="col">상태</th>
                                <th class="" scope="col">담당자</th>
                                <th class="" scope="col">시작일</th>
                                <th class="" scope="col">종료일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <select class="form-select" name="category[0]" id="categorySelect">
                                        <option value="" disabled selected> 선택</option>
                                        <c:forEach items="${categoryMap}" var="category">
                                            <option value="${category.value}">${category.value}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td><input class="form-control" type="text" name="workPackage[0]"></td>
                                <td><input class="form-control" type="text" name="depth[0]"></td>
                                <td><input class="form-control" type="text" name="detail[0]"></td>
                                <td><input class="form-control" type="text" name="status[0]"></td>
                                <td><input class="form-control" type="text" name="responsibility[0]"></td>
                                <td><input class="form-control" type="date"  name="startDate[0]" id="startDate"/></td>
                                <td><input class="form-control" type="date"  name="endDate[0]" id="endDate" /></td>
                            </tr>
                        </tbody>
                    </table>
                    <input class="form-control" type="submit" value="수정">
            </div>
        </div>
    </form>
<script>
    var cols = 0;
    var headers = ["category","workPackage","depth","detail","status","responsibility","startDate","endDate"];
    var categoryMap = JSON.parse('${categoryMapJson}');

    var categoryArray = [];

    for(var key in categoryMap){
        if(categoryMap.hasOwnProperty(key)){
            categoryArray.push(categoryMap[key]);
        }
    }
    console.log(categoryArray);

    var colData = [
        { label: "Category", name: "category" },
        { label: "Work Package", name: "workPackage" },
        { label: "depth", name: "depth" },
        { label: "detail", name: "detail" },
        { label: "상태", name: "status" },
        { label: "담당자", name: "responsibility" },
        { label: "시작일", name: "startDate" },
        { label: "종료일", name: "endDate" }
    ];

    $(document).ready(function(){
        var table = document.getElementById("taskTbl");
        var colCount = 0;
        if (table){
            var headerRow = table.querySelector("thead tr");
            if(headerRow){
                colCount = headerRow.cells.length;
                cols = colCount
            }
        }
        console.log(colCount);
    });


    function add_depth(){
        const table = document.getElementById('taskTbl');

        const newRow = table.insertRow();   // 행 추가

        // 각 셀에 데이터 추가
        for (let i = 0; i < cols; i++) {
            const newCell = newRow.insertCell(i);

            const inputElement = document.createElement('input');
            inputElement.className = 'form-control';

            if (colData[i].name == "category"){
                const selectElement = document.createElement('select');
                selectElement.className = 'form-select';
                selectElement.name = colData[i].name+'['+i+1+']';

                const option = document.createElement('option');
                option.value = "";
                option.text = "선택";
                option.disabled = true;
                option.selected = true;

                selectElement.appendChild(option);

                for (const category of categoryArray){
                   const option = document.createElement('option');
                    option.value = category;
                    option.text = category;
                    selectElement.appendChild(option);
                }
                newCell.appendChild(selectElement);
            } else {
                if(colData[i].name == "startDate" || colData[i].name == "endDate"){
                    inputElement.type = 'date';
                    inputElement.setAttribute('min',getCurrentDate());
                    inputElement.setAttribute('value',getCurrentDate());
                } else {
                inputElement.type = 'text';
                }

                inputElement.name = colData[i].name+'['+i+1+']';

                newCell.appendChild(inputElement);
            }

            console.log(i+1+"번째 열 추가됨");

        }

        console.log("행이 추가되었습니다."); // 디버깅 메시지
    }

    function delete_depth(){
        const table = document.getElementById('taskTbl');
        for(let i = 0; i<table.rows.length;i++){
            table.rows[i].deleteCell(-1);
        }
    }

    function getCurrentDate(){
        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth()+1).padStart(2,'0');
        const day = String(now.getDate()).padStart(2,'0');

        return year+"-"+month+"-"+day;
    }

    const currentDate = getCurrentDate();
    console.log(currentDate);
    document.getElementById('startDate').setAttribute('min', currentDate);
    document.getElementById('startDate').setAttribute('value', currentDate);
    document.getElementById('endDate').setAttribute('min', currentDate);
    document.getElementById('endDate').setAttribute('value', currentDate);


</script>
</body>
</html>
