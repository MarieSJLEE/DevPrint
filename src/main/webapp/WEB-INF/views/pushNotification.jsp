<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023/10/09
  Time: 4:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
  <script>
    // 전역변수 설정
    var socket  = null;
    $(document).ready(function(){
      // 웹소켓 연결
      sock = new SockJS("<c:url value="/echo-ws"/>");
      socket = sock;

      // 데이터를 전달 받았을때
      sock.onmessage = onMessage;
    });

    // toast생성 및 추가
    function onMessage(evt){
      var data = evt.data;
      // toast
      let toast = "<div class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
      toast += "<div class='toast-header'><i class='fas fa-bell mr-2'></i><strong class='mr-auto'>알림</strong>";
      toast += "<small class='text-muted'>just now</small><button type='button' class='ml-2 mb-1 close' data-dismiss='toast' aria-label='Close'>";
      toast += "<span aria-hidden='true'>&times;</span></button>";
      toast += "</div> <div class='toast-body'>" + data + "</div></div>";
      $("#msgStack").append(toast);   // msgStack div에 생성한 toast 추가
      $(".toast").toast({"animation": true, "autohide": false});
      $('.toast').toast('show');
    };

    $('#notifySendBtn').click(function(e){
        let modal = $('.modal-content').has(e.target);
        let type = '70';
        let target = modal.find('.modal-body input').val();
        let content = modal.find('.modal-body textarea').val();
        let url = '${contextPath}/member/notify.do';
        // 전송한 정보를 db에 저장
        $.ajax({
            type: 'post',
            url: '${contextPath}/member/saveNotify.do',
            dataType: 'text',
            data: {
                target: target,
                content: content,
                type: type,
                url: url
            },
            success: function(){    // db전송 성공시 실시간 알림 전송
                // 소켓에 전달되는 메시지
                // 위에 기술한 EchoHandler에서 ,(comma)를 이용하여 분리시킨다.
                socket.send("관리자,"+target+","+content+","+url);
            }
        });
        modal.find('.modal-body textarea').val('');	// textarea 초기화
    });
  </script>
</head>
<body>
<div id="msgStack">아아아</div>
<button id="notifySendBtn">버튼</button>
</body>
