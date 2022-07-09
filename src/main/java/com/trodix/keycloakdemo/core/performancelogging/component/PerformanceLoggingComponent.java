package com.trodix.keycloakdemo.core.performancelogging.component;

import java.time.Duration;
import java.util.concurrent.TimeUnit;
import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import io.micrometer.core.instrument.MeterRegistry;

@Component
public class PerformanceLoggingComponent {

    public static final String PERFORMANCE_LOGGIN_METRIC_PREFIX = "performance-logging.";

    private final MeterRegistry meterRegistry;

    public PerformanceLoggingComponent(final MeterRegistry meterRegistry) {
        this.meterRegistry = meterRegistry;
    }

    @Async
    public void appendMetric(final ProceedingJoinPoint joinPoint, final Duration duration) {
        this.meterRegistry.timer(PERFORMANCE_LOGGIN_METRIC_PREFIX + joinPoint.getSignature().getName())
                .record(duration.toMillis(), TimeUnit.MILLISECONDS);
    }

}
