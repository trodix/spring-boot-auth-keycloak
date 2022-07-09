package com.trodix.keycloakdemo.core.performancelogging.aspect;

import java.text.MessageFormat;
import java.time.Duration;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import com.trodix.keycloakdemo.core.performancelogging.component.PerformanceLoggingComponent;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
public class PerformanceLoggingAspect {

    private final PerformanceLoggingComponent performanceLoggingComponent;

    public PerformanceLoggingAspect(final PerformanceLoggingComponent performanceLoggingComponent) {
        this.performanceLoggingComponent = performanceLoggingComponent;
    }

    @SuppressWarnings("all")
    @Pointcut("@annotation(com.trodix.keycloakdemo.core.performancelogging.annotation.PerformanceLogging)")
    public void performanceLoggingPointCut() {}

    @Around("performanceLoggingPointCut()")
    public Object around(final ProceedingJoinPoint joinPoint) throws Throwable {

        final long startTimer = System.currentTimeMillis();

        final Object object = joinPoint.proceed();

        final long endTimer = System.currentTimeMillis();

        final Duration durationExecution = Duration.ofMillis(endTimer - startTimer);

        performanceLoggingComponent.appendMetric(joinPoint, durationExecution);

        log.info(MessageFormat.format("Method [{0}] took {1} secondes and {2} millisecondes to execute", joinPoint.getSignature().getName(),
                durationExecution.toSecondsPart(), durationExecution.toMillisPart()));

        return object;
    }

}
