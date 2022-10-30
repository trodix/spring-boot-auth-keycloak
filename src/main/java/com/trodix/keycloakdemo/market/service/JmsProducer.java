package com.trodix.keycloakdemo.market.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Component;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class JmsProducer {

    private final JmsTemplate jmsTemplate;

    @Value("${activemq.topic}")
    private String topic;

    public JmsProducer(final JmsTemplate jmsTemplate) {
        this.jmsTemplate = jmsTemplate;
    }

    public void sendMessage(final Object message) {
        try {
            final ObjectMapper objectMapper = new ObjectMapper();
            final String serializedObject = objectMapper.writeValueAsString(message);
            jmsTemplate.convertAndSend(topic, serializedObject);
            log.debug("Message sent to Topic: " + topic);
        } catch (final Exception e) {
            log.error("Recieved Exception during send Message: ", e);
        }
    }
}
