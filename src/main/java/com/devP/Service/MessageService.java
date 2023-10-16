package com.devP.Service;

import java.util.List;

public interface MessageService {
    void addMessage(String message);
    List<String> getAllMessages();
}
