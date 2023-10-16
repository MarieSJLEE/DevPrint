package com.devP.Mapper.Impl;

import com.devP.Mapper.Repository.MessageDAOMybatis;
import com.devP.Service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {

    @Autowired
    private MessageDAOMybatis messageDAO;

    @Override
    public void addMessage(String message) {
        messageDAO.addMessage(message);
    }

    @Override
    public List<String> getAllMessages() {
        return messageDAO.getMessages();
    }
}
