package com.devP.Controller;

import com.devP.Service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class MessageController {
    @Autowired
    private MessageService messageService;

    @GetMapping(value = "/sse", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public List<String> sse() {
        return messageService.getAllMessages();
    }

    @PostMapping("/addMessage")
    public void addMessage(String message) {
        messageService.addMessage(message);
    }

    @RequestMapping(value = "/message.do", method = RequestMethod.GET)
    public String messageView(){
        return "message";
    }
}
