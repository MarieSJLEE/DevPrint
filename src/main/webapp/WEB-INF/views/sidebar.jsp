<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023/07/25
  Time: 3:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <link rel="stylesheet" href="/resources/css/styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/js-cookie/3.0.1/js.cookie.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<style type="text/css">
		.sidebar{
			box-shadow: 2px 2px 5px #D3D3D3;
		}
		.sidebar-link {
			transition: all .4s;
		}
		.sidebar-link:hover {
			background-color: #444;
			border-radius: 5px;
		}
		.current{
			background-color: #9932CC;
			border-radius: 7px;
			box-shadow: 2px 5px 10px #D3D3D3;
		}
		.current:hover{
			background-color: #9370DB;
			border-radius: 7px;
			box-shadow: 2px 5px 20px #D3D3D3;
			transform: translateY(-1px);
		}
		#logoLabel {
            font-style: bold;
            font-size: 24px;
            padding-left: 5px;
        }
        .logoutBtn {
            position: fixed;
            bottom: 0;
            left: 0; /* Optional: 위치를 왼쪽 끝에 고정하려면 추가 */
            //width: 100%; /* Optional: 너비를 가득 채우려면 추가 */
            //background-color: #333; /* 버튼 배경색 설정 */
            //color: #fff; /* 버튼 텍스트 색 설정 */
            padding: 10px 0; /* 버튼 패딩 설정 */
            text-align: center; /* 버튼 텍스트 가운데 정렬 설정 */
        }
	</style>
</head>
<body>
<div id = "sidebar" class="sidebar fixed-top p-3" style="width: 20%; height: 100vh">
	<div class="align-items-center">
		<a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none" id="home">
    		<img src="/resources/image/dogfootprint.png" width="15%" height="100%">
    		<span id="logoLabel">DevP</span>
		</a>
	</div>
	<hr>
    <c:choose>
        <c:when test="${projectId!=null}">
            <ul class="navbar-nav flex-column mt-4">
                <li class="nav-item">
                    <a href="/project/detail.do?projectId=" + ${ projectId } class="nav-link p-3 mb-2 sidebar-link link-dark" id="projectMenu">
                        <i class="bi bi-receipt-cutoff mx-3"></i>프로젝트
                    </a>
                </li>
                <li>
                    <a href="/project/myTask.do" class="nav-link p-3 mb-2 sidebar-link link-dark" id="taskMenu">
                        <i class="bi bi-list-task mx-3"></i></i>업무
                    </a>
                </li>
                <li>
                    <a href="/project/member.do" class="nav-link p-3 mb-2 sidebar-link link-dark" id="memberMenu">
                        <i class="bi bi-people-fill mx-3"></i>멤버
                    </a>
                </li>
                <li>
                    <a href="#" class="nav-link p-3 mb-2 sidebar-link link-dark" id="menu4">
                        <i class="bi bi-bar-chart-fill mx-3"></i>진행률
                    </a>
                </li>
                <li>
                    <a href="/issue/list.do?projectId=" + ${ projectId } class="nav-link p-3 mb-2 sidebar-link link-dark" id="issueMenu">
                        <i class="bi bi-newspaper mx-3"></i>이슈
                    </a>
                </li>
                <li>
                    <a href="#" class="nav-link p-3 mb-2 sidebar-link link-dark">
                        <i class="bi bi-check-circle-fill mx-3"></i>한 일
                    </a>
                </li>
                  <c:if test="${myData.leader==myData.userId}">
                    <li>
                        <a href="/project/leader.do?projectId=${project.projectId}" class="nav-link p-3 mb-2 sidebar-link link-dark">
                            <i class="bi bi-key mx-3"></i>리더
                        </a>
                    </li>
                  </c:if>
            </ul>
        </c:when>
        <c:otherwise>
            <ul class="navbar-nav flex-column mt-4">
                <li class="nav-item">
                    <a href="/project/list.do" class="nav-link p-3 mb-2 sidebar-link link-dark">
                        <i class="bi bi-receipt-cutoff mx-3"></i>프로젝트
                    </a>
                </li>
                <li>
                    <a href="/project/list.do" class="nav-link p-3 mb-2 sidebar-link link-dark">
                        <i class="bi bi-list-task mx-3"></i></i>업무
                    </a>
                </li>
                <li>
                    <a href="/project/list.do" class="nav-link p-3 mb-2 sidebar-link link-dark">
                        <i class="bi bi-people-fill mx-3"></i>멤버
                    </a>
                </li>
                <li>
                    <a href="#" class="nav-link p-3 mb-2 sidebar-link link-dark">
                        <i class="bi bi-bar-chart-fill mx-3"></i>진행률
                    </a>
                </li>
                <li>
                    <a href="/project/list.do" class="nav-link p-3 mb-2 sidebar-link link-dark">
                        <i class="bi bi-newspaper mx-3"></i>이슈
                    </a>
                </li>
                <li>
                    <a href="#" class="nav-link p-3 mb-2 sidebar-link link-dark">
                        <i class="bi bi-check-circle-fill mx-3"></i>한 일
                    </a>
                </li>
            </ul>
        </c:otherwise>
    </c:choose>

    <button class="btn btn-outline-success logoutBtn" type="button" onclick="location.href='/logout.do'">Logout</button>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<script>

	console.log("${menuId}");
	// 페이지가 로드될 때 호출
	window.addEventListener('load', function () {
	    // 저장된 메뉴 ID가 있을 경우 해당 메뉴에 current 클래스 추가
	    if ("${menuId}") {
	        const savedMenu = document.getElementById("${menuId}");
	        if (savedMenu) {
	            savedMenu.classList.add('current');
	        }
	    }
	});
	  var projectId = ${projectId}; // 서버에서 생성된 값으로 설정
	  var link = "/project/detail.do?projectId=" + projectId;
	  document.getElementById("projectMenu").href = link; // 링크 엘리먼트의 href 속성 설정
	  var link = "/issue/list.do?projectId=" + projectId;
	  document.getElementById("issueMenu").href = link; // 링크 엘리먼트의 href 속성 설정
    </script>
</body>
</html>
