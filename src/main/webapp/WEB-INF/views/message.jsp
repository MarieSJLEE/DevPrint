<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>SSE Example</title>
</head>
<body>
<h1>Server-Sent Events (SSE) Example</h1>
<div id="messageContainer"></div>
<input type="text" id="messageInput" placeholder="Enter a message">
<button id="sendMessage">Send</button>
</body>
<script>
    const messageContainer = document.getElementById('messageContainer');
    const messageInput = document.getElementById('messageInput');
    const sendMessage = document.getElementById('sendMessage');

    const eventSource = new EventSource('/sse');

    eventSource.onmessage = function (event) {
        const newMessage = document.createElement('p');
        newMessage.textContent = event.data;
        messageContainer.appendChild(newMessage);
    };

    sendMessage.addEventListener('click', function () {
        const message = messageInput.value;
        fetch('/addMessage?message=' + message, { method: 'POST' });
    });
</script>
</html>

