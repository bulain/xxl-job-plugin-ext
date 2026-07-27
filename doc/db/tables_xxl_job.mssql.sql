--
-- XXL-JOB
-- Copyright (c) 2015-present, xuxueli.
-- SQL Server 2012+
--

USE xxl_job;
GO

CREATE TABLE xxl_job_info
(
    id                        INT IDENTITY(100,1) NOT NULL PRIMARY KEY,
    job_group                 INT NOT NULL,
    job_desc                  NVARCHAR(255) NOT NULL,
    add_time                  DATETIME2 NULL,
    update_time               DATETIME2 NULL,
    author                    NVARCHAR(64) NULL,
    alarm_email               NVARCHAR(255) NULL,
    schedule_type             NVARCHAR(50) NOT NULL DEFAULT 'NONE',
    schedule_conf             NVARCHAR(128) NULL,
    misfire_strategy          NVARCHAR(50) NOT NULL DEFAULT 'DO_NOTHING',
    executor_route_strategy   NVARCHAR(50) NULL,
    executor_handler          NVARCHAR(255) NULL,
    executor_param            NVARCHAR(512) NULL,
    executor_block_strategy   NVARCHAR(50) NULL,
    executor_timeout          INT NOT NULL DEFAULT 0,
    executor_fail_retry_count INT NOT NULL DEFAULT 0,
    glue_type                 NVARCHAR(50) NOT NULL,
    glue_source               NVARCHAR(MAX) NULL,
    glue_remark               NVARCHAR(128) NULL,
    glue_updatetime           DATETIME2 NULL,
    child_jobid               NVARCHAR(255) NULL,
    trigger_status            TINYINT NOT NULL DEFAULT 0,
    trigger_last_time         BIGINT NOT NULL DEFAULT 0,
    trigger_next_time         BIGINT NOT NULL DEFAULT 0
);
GO

EXEC sp_addextendedproperty N'MS_Description', N'执行器主键ID', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'job_group';
EXEC sp_addextendedproperty N'MS_Description', N'作者', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'author';
EXEC sp_addextendedproperty N'MS_Description', N'报警邮件', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'alarm_email';
EXEC sp_addextendedproperty N'MS_Description', N'调度类型', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'schedule_type';
EXEC sp_addextendedproperty N'MS_Description', N'调度配置，值含义取决于调度类型', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'schedule_conf';
EXEC sp_addextendedproperty N'MS_Description', N'调度过期策略', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'misfire_strategy';
EXEC sp_addextendedproperty N'MS_Description', N'执行器路由策略', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'executor_route_strategy';
EXEC sp_addextendedproperty N'MS_Description', N'执行器任务handler', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'executor_handler';
EXEC sp_addextendedproperty N'MS_Description', N'执行器任务参数', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'executor_param';
EXEC sp_addextendedproperty N'MS_Description', N'阻塞处理策略', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'executor_block_strategy';
EXEC sp_addextendedproperty N'MS_Description', N'任务执行超时时间，单位秒', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'executor_timeout';
EXEC sp_addextendedproperty N'MS_Description', N'失败重试次数', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'executor_fail_retry_count';
EXEC sp_addextendedproperty N'MS_Description', N'GLUE类型', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'glue_type';
EXEC sp_addextendedproperty N'MS_Description', N'GLUE源代码', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'glue_source';
EXEC sp_addextendedproperty N'MS_Description', N'GLUE备注', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'glue_remark';
EXEC sp_addextendedproperty N'MS_Description', N'GLUE更新时间', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'glue_updatetime';
EXEC sp_addextendedproperty N'MS_Description', N'子任务ID，多个逗号分隔', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'child_jobid';
EXEC sp_addextendedproperty N'MS_Description', N'调度状态：0-停止，1-运行', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'trigger_status';
EXEC sp_addextendedproperty N'MS_Description', N'上次调度时间', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'trigger_last_time';
EXEC sp_addextendedproperty N'MS_Description', N'下次调度时间', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_info', N'COLUMN', N'trigger_next_time';
GO

CREATE TABLE xxl_job_log
(
    id                        BIGINT IDENTITY(100,1) NOT NULL PRIMARY KEY,
    job_group                 INT NOT NULL,
    job_id                    INT NOT NULL,
    executor_address          NVARCHAR(255) NULL,
    executor_handler          NVARCHAR(255) NULL,
    executor_param            NVARCHAR(512) NULL,
    executor_sharding_param   NVARCHAR(20) NULL,
    executor_fail_retry_count INT NOT NULL DEFAULT 0,
    trigger_time              DATETIME2 NULL,
    trigger_code              INT NOT NULL,
    trigger_msg               NVARCHAR(MAX) NULL,
    handle_time               DATETIME2 NULL,
    handle_code               INT NOT NULL,
    handle_msg                NVARCHAR(MAX) NULL,
    alarm_status              TINYINT NOT NULL DEFAULT 0
);
GO

EXEC sp_addextendedproperty N'MS_Description', N'执行器主键ID', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'job_group';
EXEC sp_addextendedproperty N'MS_Description', N'任务，主键ID', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'job_id';
EXEC sp_addextendedproperty N'MS_Description', N'执行器地址，本次执行的地址', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'executor_address';
EXEC sp_addextendedproperty N'MS_Description', N'执行器任务handler', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'executor_handler';
EXEC sp_addextendedproperty N'MS_Description', N'执行器任务参数', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'executor_param';
EXEC sp_addextendedproperty N'MS_Description', N'执行器任务分片参数，格式如 1/2', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'executor_sharding_param';
EXEC sp_addextendedproperty N'MS_Description', N'失败重试次数', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'executor_fail_retry_count';
EXEC sp_addextendedproperty N'MS_Description', N'调度-时间', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'trigger_time';
EXEC sp_addextendedproperty N'MS_Description', N'调度-结果', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'trigger_code';
EXEC sp_addextendedproperty N'MS_Description', N'调度-日志', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'trigger_msg';
EXEC sp_addextendedproperty N'MS_Description', N'执行-时间', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'handle_time';
EXEC sp_addextendedproperty N'MS_Description', N'执行-状态', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'handle_code';
EXEC sp_addextendedproperty N'MS_Description', N'执行-日志', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'handle_msg';
EXEC sp_addextendedproperty N'MS_Description', N'告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log', N'COLUMN', N'alarm_status';
GO

CREATE INDEX i_trigger_time ON xxl_job_log (trigger_time);
CREATE INDEX i_handle_code ON xxl_job_log (handle_code);
CREATE INDEX i_jobid_jobgroup ON xxl_job_log (job_id, job_group);
CREATE INDEX i_job_id ON xxl_job_log (job_id);
GO

CREATE TABLE xxl_job_log_report
(
    id            INT IDENTITY(100,1) NOT NULL PRIMARY KEY,
    trigger_day   DATETIME2 NULL,
    running_count INT NOT NULL DEFAULT 0,
    suc_count     INT NOT NULL DEFAULT 0,
    fail_count    INT NOT NULL DEFAULT 0,
    update_time   DATETIME2 NULL,
    CONSTRAINT i_trigger_day UNIQUE (trigger_day)
);
GO

EXEC sp_addextendedproperty N'MS_Description', N'调度-时间', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log_report', N'COLUMN', N'trigger_day';
EXEC sp_addextendedproperty N'MS_Description', N'运行中-日志数量', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log_report', N'COLUMN', N'running_count';
EXEC sp_addextendedproperty N'MS_Description', N'执行成功-日志数量', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log_report', N'COLUMN', N'suc_count';
EXEC sp_addextendedproperty N'MS_Description', N'执行失败-日志数量', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_log_report', N'COLUMN', N'fail_count';
GO

CREATE TABLE xxl_job_logglue
(
    id          INT IDENTITY(100,1) NOT NULL PRIMARY KEY,
    job_id      INT NOT NULL,
    glue_type   NVARCHAR(50) NULL,
    glue_source NVARCHAR(MAX) NULL,
    glue_remark NVARCHAR(128) NOT NULL,
    add_time    DATETIME2 NULL,
    update_time DATETIME2 NULL
);
GO

EXEC sp_addextendedproperty N'MS_Description', N'任务，主键ID', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_logglue', N'COLUMN', N'job_id';
EXEC sp_addextendedproperty N'MS_Description', N'GLUE类型', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_logglue', N'COLUMN', N'glue_type';
EXEC sp_addextendedproperty N'MS_Description', N'GLUE源代码', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_logglue', N'COLUMN', N'glue_source';
EXEC sp_addextendedproperty N'MS_Description', N'GLUE备注', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_logglue', N'COLUMN', N'glue_remark';
GO

CREATE TABLE xxl_job_registry
(
    id             INT IDENTITY(100,1) NOT NULL PRIMARY KEY,
    registry_group NVARCHAR(50) NOT NULL,
    registry_key   NVARCHAR(255) NOT NULL,
    registry_value NVARCHAR(255) NOT NULL,
    update_time    DATETIME2 NULL,
    CONSTRAINT i_g_k_v UNIQUE (registry_group, registry_key, registry_value)
);
GO

CREATE TABLE xxl_job_group
(
    id           INT IDENTITY(100,1) NOT NULL PRIMARY KEY,
    app_name     NVARCHAR(64) NOT NULL,
    title        NVARCHAR(12) NOT NULL,
    address_type TINYINT NOT NULL DEFAULT 0,
    address_list NVARCHAR(MAX) NULL,
    update_time  DATETIME2 NULL
);
GO

EXEC sp_addextendedproperty N'MS_Description', N'执行器AppName', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_group', N'COLUMN', N'app_name';
EXEC sp_addextendedproperty N'MS_Description', N'执行器名称', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_group', N'COLUMN', N'title';
EXEC sp_addextendedproperty N'MS_Description', N'执行器地址类型：0=自动注册、1=手动录入', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_group', N'COLUMN', N'address_type';
EXEC sp_addextendedproperty N'MS_Description', N'执行器地址列表，多地址逗号分隔', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_group', N'COLUMN', N'address_list';
GO

CREATE TABLE xxl_job_user
(
    id         INT IDENTITY(100,1) NOT NULL PRIMARY KEY,
    username   NVARCHAR(50) NOT NULL,
    password   NVARCHAR(50) NOT NULL,
    role       TINYINT NOT NULL,
    permission NVARCHAR(255) NULL,
    CONSTRAINT i_username UNIQUE (username)
);
GO

EXEC sp_addextendedproperty N'MS_Description', N'账号', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_user', N'COLUMN', N'username';
EXEC sp_addextendedproperty N'MS_Description', N'密码', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_user', N'COLUMN', N'password';
EXEC sp_addextendedproperty N'MS_Description', N'角色：0-普通用户、1-管理员', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_user', N'COLUMN', N'role';
EXEC sp_addextendedproperty N'MS_Description', N'权限：执行器ID列表，多个逗号分割', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_user', N'COLUMN', N'permission';
GO

CREATE TABLE xxl_job_lock
(
    lock_name NVARCHAR(50) NOT NULL PRIMARY KEY
);
GO

EXEC sp_addextendedproperty N'MS_Description', N'锁名称', N'SCHEMA', N'dbo', N'TABLE', N'xxl_job_lock', N'COLUMN', N'lock_name';
GO


-- ------------------------------- init data -------------------------------

SET IDENTITY_INSERT xxl_job_group ON;
INSERT INTO xxl_job_group (id, app_name, title, address_type, address_list, update_time)
VALUES (1, N'xxl-job-executor-sample', N'示例执行器', 0, NULL, '2018-11-03 22:21:31');
SET IDENTITY_INSERT xxl_job_group OFF;
GO

SET IDENTITY_INSERT xxl_job_info ON;
INSERT INTO xxl_job_info (id, job_group, job_desc, add_time, update_time, author, alarm_email,
                          schedule_type, schedule_conf, misfire_strategy, executor_route_strategy,
                          executor_handler, executor_param, executor_block_strategy, executor_timeout,
                          executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime,
                          child_jobid)
VALUES (1, 1, N'测试任务1', '2018-11-03 22:21:31', '2018-11-03 22:21:31', N'XXL', N'',
        N'CRON', N'0 0 0 * * ? *',
        N'DO_NOTHING', N'FIRST', N'demoJobHandler', N'', N'SERIAL_EXECUTION', 0, 0, N'BEAN', N'', N'GLUE代码初始化',
        '2018-11-03 22:21:31', N'');
SET IDENTITY_INSERT xxl_job_info OFF;
GO

SET IDENTITY_INSERT xxl_job_user ON;
INSERT INTO xxl_job_user (id, username, password, role, permission)
VALUES (1, N'admin', N'e10adc3949ba59abbe56e057f20f883e', 1, NULL);
SET IDENTITY_INSERT xxl_job_user OFF;
GO

INSERT INTO xxl_job_lock (lock_name)
VALUES (N'schedule_lock');
GO