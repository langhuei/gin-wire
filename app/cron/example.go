package cron

import "go.uber.org/zap"

type ExampleJob struct {
    logger *zap.Logger
}

func NewExampleJob(logger *zap.Logger) *ExampleJob {
    return &ExampleJob{
        logger: logger,
    }
}

func (j *ExampleJob) Hello() {
    j.logger.Info("hello")
}
