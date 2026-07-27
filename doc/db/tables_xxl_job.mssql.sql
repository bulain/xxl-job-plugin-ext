--
-- XXL-JOB
-- Copyright (c) 2015-present, xuxueli.
-- SQL Server 2012+
--

IF DB_ID('xxl_job') IS NULL
    CREATE DATABASE xxl_job;
GO

USE xxl_job;
GO

-- —————————————————————— job group and registry ——————————————————

CREATE TABLE xxl_job_group
(
    id           INT            NOT NULL IDENTITY(100,1),
    app_name     NVARCHAR(64)   NOT NULL,
    title        NVARCHAR(12)   NOT NULL,
    address_type TINYINT        NOT NULL DEFAULT 0,
    address_list NVARCHAR(MAX),
    update_time  DATETIME2      DEFAULT NULL,
    PRIMARY KEY (id)
);

EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_group',
    @name = N'ms_description', @value = N'执行器'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_group',
    @level2type = N'column', @level2name = N'id',
    @name = N'ms_description', @value = N'执行器主键ID'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_group',
    @level2type = N'column', @level2name = N'app_name',
    @name = N'ms_description', @value = N'执行器AppName'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_group',
    @level2type = N'column', @level2name = N'title',
    @name = N'ms_description', @value = N'执行器名称'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_group',
    @level2type = N'column', @level2name = N'address_type',
    @name = N'ms_description', @value = N'执行器地址类型：0=自动注册、1=手动录入'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_group',
    @level2type = N'column', @level2name = N'address_list',
    @name = N'ms_description', @value = N'执行器地址列表，多地址逗号分隔'
    ;

CREATE TABLE xxl_job_registry
(
    id             INT           NOT NULL IDENTITY(100,1),
    registry_group NVARCHAR(50)  NOT NULL,
    registry_key   NVARCHAR(255) NOT NULL,
    registry_value NVARCHAR(255) NOT NULL,
    update_time    DATETIME2     DEFAULT NULL,
    PRIMARY KEY (id),
    CONSTRAINT i_g_k_v UNIQUE (registry_group, registry_key, registry_value)
);

EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_registry',
    @name = N'ms_description', @value = N'客户端注册'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_registry',
    @level2type = N'column', @level2name = N'id',
    @name = N'ms_description', @value = N'注册主键ID'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_registry',
    @level2type = N'column', @level2name = N'registry_group',
    @name = N'ms_description', @value = N'注册组'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_registry',
    @level2type = N'column', @level2name = N'registry_key',
    @name = N'ms_description', @value = N'注册主键'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_registry',
    @level2type = N'column', @level2name = N'registry_value',
    @name = N'ms_description', @value = N'注册值'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_registry',
    @level2type = N'column', @level2name = N'update_time',
    @name = N'ms_description', @value = N'更新时间'
    ;

-- —————————————————————— job info ——————————————————

CREATE TABLE xxl_job_info
(
    id                        INT            NOT NULL IDENTITY(100,1),
    job_group                 INT            NOT NULL,
    job_desc                  NVARCHAR(255)  NOT NULL,
    add_time                  DATETIME2      DEFAULT NULL,
    update_time               DATETIME2      DEFAULT NULL,
    author                    NVARCHAR(64)   DEFAULT NULL,
    alarm_email               NVARCHAR(255)  DEFAULT NULL,
    schedule_type             NVARCHAR(50)   NOT NULL DEFAULT 'NONE',
    schedule_conf             NVARCHAR(128)  DEFAULT NULL,
    misfire_strategy          NVARCHAR(50)   NOT NULL DEFAULT 'DO_NOTHING',
    executor_route_strategy   NVARCHAR(50)   DEFAULT NULL,
    executor_handler          NVARCHAR(255)  DEFAULT NULL,
    executor_param            NVARCHAR(512)  DEFAULT NULL,
    executor_block_strategy   NVARCHAR(50)   DEFAULT NULL,
    executor_timeout          INT            NOT NULL DEFAULT 0,
    executor_fail_retry_count INT            NOT NULL DEFAULT 0,
    glue_type                 NVARCHAR(50)   NOT NULL,
    glue_source               NVARCHAR(MAX),
    glue_remark               NVARCHAR(128)  DEFAULT NULL,
    glue_updatetime           DATETIME2      DEFAULT NULL,
    child_jobid               NVARCHAR(255)  DEFAULT NULL,
    trigger_status            TINYINT        NOT NULL DEFAULT 0,
    trigger_last_time         BIGINT         NOT NULL DEFAULT 0,
    trigger_next_time         BIGINT         NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);

EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @name = N'ms_description', @value = N'任务信息表'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'id',
    @name = N'ms_description', @value = N'任务主键ID'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'job_group',
    @name = N'ms_description', @value = N'执行器主键ID'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'job_desc',
    @name = N'ms_description', @value = N'任务描述'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'add_time',
    @name = N'ms_description', @value = N'创建时间'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'update_time',
    @name = N'ms_description', @value = N'更新时间'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'author',
    @name = N'ms_description', @value = N'作者'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'alarm_email',
    @name = N'ms_description', @value = N'报警邮件'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'schedule_type',
    @name = N'ms_description', @value = N'调度类型'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'schedule_conf',
    @name = N'ms_description', @value = N'调度配置，值含义取决于调度类型'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'misfire_strategy',
    @name = N'ms_description', @value = N'调度过期策略'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'executor_route_strategy',
    @name = N'ms_description', @value = N'执行器路由策略'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'executor_handler',
    @name = N'ms_description', @value = N'执行器任务handler'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'executor_param',
    @name = N'ms_description', @value = N'执行器任务参数'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'executor_block_strategy',
    @name = N'ms_description', @value = N'阻塞处理策略'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'executor_timeout',
    @name = N'ms_description', @value = N'任务执行超时时间，单位秒'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'executor_fail_retry_count',
    @name = N'ms_description', @value = N'失败重试次数'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'glue_type',
    @name = N'ms_description', @value = N'GLUE类型'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'glue_source',
    @name = N'ms_description', @value = N'GLUE源代码'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'glue_remark',
    @name = N'ms_description', @value = N'GLUE备注'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'glue_updatetime',
    @name = N'ms_description', @value = N'GLUE更新时间'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'child_jobid',
    @name = N'ms_description', @value = N'子任务ID，多个逗号分隔'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'trigger_status',
    @name = N'ms_description', @value = N'调度状态：0-停止，1-运行'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'trigger_last_time',
    @name = N'ms_description', @value = N'上次调度时间'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_info',
    @level2type = N'column', @level2name = N'trigger_next_time',
    @name = N'ms_description', @value = N'下次调度时间'
    ;

CREATE TABLE xxl_job_logglue
(
    id          INT           NOT NULL IDENTITY(100,1),
    job_id      INT           NOT NULL,
    glue_type   NVARCHAR(50)  DEFAULT NULL,
    glue_source NVARCHAR(MAX),
    glue_remark NVARCHAR(128) NOT NULL,
    add_time    DATETIME2     DEFAULT NULL,
    update_time DATETIME2     DEFAULT NULL,
    PRIMARY KEY (id)
);

EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_logglue',
    @name = N'ms_description', @value = N'GLUE任务'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_logglue',
    @level2type = N'column', @level2name = N'id',
    @name = N'ms_description', @value = N'GLUE主键ID'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_logglue',
    @level2type = N'column', @level2name = N'job_id',
    @name = N'ms_description', @value = N'任务，主键ID'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_logglue',
    @level2type = N'column', @level2name = N'glue_type',
    @name = N'ms_description', @value = N'GLUE类型'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_logglue',
    @level2type = N'column', @level2name = N'glue_source',
    @name = N'ms_description', @value = N'GLUE源代码'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_logglue',
    @level2type = N'column', @level2name = N'glue_remark',
    @name = N'ms_description', @value = N'GLUE备注'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_logglue',
    @level2type = N'column', @level2name = N'add_time',
    @name = N'ms_description', @value = N'创建时间'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_logglue',
    @level2type = N'column', @level2name = N'update_time',
    @name = N'ms_description', @value = N'更新时间'
    ;

-- —————————————————————— job log and report ——————————————————

CREATE TABLE xxl_job_log
(
    id                        BIGINT         NOT NULL IDENTITY(100,1),
    job_group                 INT            NOT NULL,
    job_id                    INT            NOT NULL,
    executor_address          NVARCHAR(255)  DEFAULT NULL,
    executor_handler          NVARCHAR(255)  DEFAULT NULL,
    executor_param            NVARCHAR(512)  DEFAULT NULL,
    executor_sharding_param   NVARCHAR(20)   DEFAULT NULL,
    executor_fail_retry_count INT            NOT NULL DEFAULT 0,
    trigger_time              DATETIME2      DEFAULT NULL,
    trigger_code              INT            NOT NULL,
    trigger_msg               NVARCHAR(MAX),
    handle_time               DATETIME2      DEFAULT NULL,
    handle_code               INT            NOT NULL,
    handle_msg                NVARCHAR(MAX),
    alarm_status              TINYINT        NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);

CREATE INDEX I_trigger_time ON xxl_job_log (trigger_time);
CREATE INDEX I_handle_code ON xxl_job_log (handle_code);
CREATE INDEX I_jobid_jobgroup ON xxl_job_log (job_id, job_group);
CREATE INDEX I_job_id ON xxl_job_log (job_id);

EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @name = N'ms_description', @value = N'调度日志'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'id',
    @name = N'ms_description', @value = N'调度主键ID'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'job_group',
    @name = N'ms_description', @value = N'执行器主键ID'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'job_id',
    @name = N'ms_description', @value = N'任务，主键ID'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'executor_address',
    @name = N'ms_description', @value = N'执行器地址，本次执行的地址'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'executor_handler',
    @name = N'ms_description', @value = N'执行器任务handler'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'executor_param',
    @name = N'ms_description', @value = N'执行器任务参数'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'executor_sharding_param',
    @name = N'ms_description', @value = N'执行器任务分片参数，格式如 1/2'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'executor_fail_retry_count',
    @name = N'ms_description', @value = N'失败重试次数'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'trigger_time',
    @name = N'ms_description', @value = N'调度-时间'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'trigger_code',
    @name = N'ms_description', @value = N'调度-结果'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'trigger_msg',
    @name = N'ms_description', @value = N'调度-日志'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'handle_time',
    @name = N'ms_description', @value = N'执行-时间'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'handle_code',
    @name = N'ms_description', @value = N'执行-状态'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'handle_msg',
    @name = N'ms_description', @value = N'执行-日志'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log',
    @level2type = N'column', @level2name = N'alarm_status',
    @name = N'ms_description', @value = N'告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败'
    ;

CREATE TABLE xxl_job_log_report
(
    id            INT       NOT NULL IDENTITY(100,1),
    trigger_day   DATETIME2 DEFAULT NULL,
    running_count INT       NOT NULL DEFAULT 0,
    suc_count     INT       NOT NULL DEFAULT 0,
    fail_count    INT       NOT NULL DEFAULT 0,
    update_time   DATETIME2 DEFAULT NULL,
    PRIMARY KEY (id),
    CONSTRAINT i_trigger_day UNIQUE (trigger_day)
);

EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log_report',
    @name = N'ms_description', @value = N'调度报告'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log_report',
    @level2type = N'column', @level2name = N'id',
    @name = N'ms_description', @value = N'调度报告主键ID'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log_report',
    @level2type = N'column', @level2name = N'trigger_day',
    @name = N'ms_description', @value = N'调度-时间'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log_report',
    @level2type = N'column', @level2name = N'running_count',
    @name = N'ms_description', @value = N'运行中-日志数量'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log_report',
    @level2type = N'column', @level2name = N'suc_count',
    @name = N'ms_description', @value = N'执行成功-日志数量'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log_report',
    @level2type = N'column', @level2name = N'fail_count',
    @name = N'ms_description', @value = N'执行失败-日志数量'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_log_report',
    @level2type = N'column', @level2name = N'update_time',
    @name = N'ms_description', @value = N'更新时间'
    ;

-- —————————————————————— lock ——————————————————

CREATE TABLE xxl_job_lock
(
    lock_name NVARCHAR(50) NOT NULL,
    PRIMARY KEY (lock_name)
);

EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_lock',
    @name = N'ms_description', @value = N'并发锁'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_lock',
    @level2type = N'column', @level2name = N'lock_name',
    @name = N'ms_description', @value = N'锁名称'
    ;

-- —————————————————————— user ——————————————————

CREATE TABLE xxl_job_user
(
    id         INT            NOT NULL IDENTITY(100,1),
    username   NVARCHAR(50)   NOT NULL,
    password   NVARCHAR(100)  NOT NULL,
    token      NVARCHAR(100)  DEFAULT NULL,
    role       TINYINT        NOT NULL,
    permission NVARCHAR(255)  DEFAULT NULL,
    PRIMARY KEY (id),
    CONSTRAINT i_username UNIQUE (username)
);

EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_user',
    @name = N'ms_description', @value = N'用户账号'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_user',
    @level2type = N'column', @level2name = N'id',
    @name = N'ms_description', @value = N'用户主键ID'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_user',
    @level2type = N'column', @level2name = N'username',
    @name = N'ms_description', @value = N'账号'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_user',
    @level2type = N'column', @level2name = N'password',
    @name = N'ms_description', @value = N'密码加密信息'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_user',
    @level2type = N'column', @level2name = N'token',
    @name = N'ms_description', @value = N'登录token'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_user',
    @level2type = N'column', @level2name = N'role',
    @name = N'ms_description', @value = N'角色：0-普通用户、1-管理员'
    ;
EXEC sys.sp_addextendedproperty
    @level0type = N'schema', @level0name = N'dbo',
    @level1type = N'table',  @level1name = N'xxl_job_user',
    @level2type = N'column', @level2name = N'permission',
    @name = N'ms_description', @value = N'权限：执行器ID列表，多个逗号分割'
    ;

-- —————————————————————— for default data ——————————————————

SET IDENTITY_INSERT xxl_job_group ON;

INSERT INTO xxl_job_group(id, app_name, title, address_type, address_list, update_time)
VALUES (1, 'xxl-job-executor-sample', '通用执行器Sample', 0, NULL, GETDATE()),
       (2, 'xxl-job-executor-sample-ai', 'AI执行器Sample', 0, NULL, GETDATE());

SET IDENTITY_INSERT xxl_job_group OFF;

SET IDENTITY_INSERT xxl_job_info ON;

INSERT INTO xxl_job_info(id, job_group, job_desc, add_time, update_time, author, alarm_email,
                         schedule_type, schedule_conf, misfire_strategy, executor_route_strategy,
                         executor_handler, executor_param, executor_block_strategy, executor_timeout,
                         executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime,
                         child_jobid)
VALUES (1, 1, '示例任务01', GETDATE(), GETDATE(), 'XXL', '', 'CRON', '0 0 0 * * ? *',
        'DO_NOTHING', 'FIRST', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化',
        GETDATE(), ''),
       (2, 2, 'Ollama示例任务01', GETDATE(), GETDATE(), 'XXL', '', 'NONE', '',
        'DO_NOTHING', 'FIRST', 'ollamaJobHandler', '{
    "input": "慢SQL问题分析思路",
    "prompt": "你是一个研发工程师，擅长解决技术类问题。",
    "model": "qwen3:0.6b"
}', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化',
        GETDATE(), ''),
       (3, 2, 'Dify示例任务', GETDATE(), GETDATE(), 'XXL', '', 'NONE', '',
        'DO_NOTHING', 'FIRST', 'difyWorkflowJobHandler', '{
    "inputs":{
        "input":"查询班级各学科前三名"
    },
    "user": "xxl-job",
    "baseUrl": "http://localhost/v1",
    "apiKey": "app-OUVgNUOQRIMokfmuJvBJoUTN"
}', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化',
        GETDATE(), '');

SET IDENTITY_INSERT xxl_job_info OFF;

SET IDENTITY_INSERT xxl_job_user ON;

INSERT INTO xxl_job_user(id, username, password, role, permission)
VALUES (1, 'admin', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, NULL);

SET IDENTITY_INSERT xxl_job_user OFF;

INSERT INTO xxl_job_lock (lock_name)
VALUES ('schedule_lock');

COMMIT;