package com.trodix.keycloakdemo.core.config;

import javax.jms.ConnectionFactory;
import org.apache.activemq.ActiveMQConnectionFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jms.core.JmsTemplate;

@Configuration
public class ActivemqConfig {

    @Value("${spring.activemq.broker-url}")
    private String brokerUrl;

    @Bean
    public ConnectionFactory connectionFactory() {
        final ActiveMQConnectionFactory activeMQConnectionFactory = new ActiveMQConnectionFactory();
        activeMQConnectionFactory.setBrokerURL(brokerUrl);
        return activeMQConnectionFactory;
    }

    @Bean
    public JmsTemplate jmsTemplate() {
        final JmsTemplate jmsTemplate = new JmsTemplate();
        jmsTemplate.setConnectionFactory(connectionFactory());
        jmsTemplate.setPubSubDomain(true); // enable for Pub Sub to topic. Not Required for Queue.
        return jmsTemplate;
    }

}
