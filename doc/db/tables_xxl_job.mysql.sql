---#
---# XXL-JOB v3.0.0
---# Copyright (c) 2015-present, xuxueli.

CREATE TABLE xxl_job_info
(
    id                        int(11)      NOT NULL AUTO_INCREMENT COMMENT '任务主键ID',
    job_group                 int(11)      NOT NULL COMMENT '执行器主键ID',
    job_desc                  varchar(255) NOT NULL COMMENT '任务描述',
    add_time                  datetime              DEFAULT NULL COMMENT '创建时间',
    update_time               datetime              DEFAULT NULL COMMENT '更新时间',
    author                    varchar(64)           DEFAULT NULL COMMENT '作者',
    alarm_email               varchar(255)          DEFAULT NULL COMMENT '报警邮件',
    schedule_type             varchar(50)  NOT NULL DEFAULT 'NONE' COMMENT '调度类型',
    schedule_conf             varchar(128)          DEFAULT NULL COMMENT '调度配置，值含义取决于调度类型',
    misfire_strategy          varchar(50)  NOT NULL DEFAULT 'DO_NOTHING' COMMENT '调度过期策略',
    executor_route_strategy   varchar(50)           DEFAULT NULL COMMENT '执行器路由策略',
    executor_handler          varchar(255)          DEFAULT NULL COMMENT '执行器任务handler',
    executor_param            varchar(512)          DEFAULT NULL COMMENT '执行器任务参数',
    executor_block_strategy   varchar(50)           DEFAULT NULL COMMENT '阻塞处理策略',
    executor_timeout          int(11)      NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
    executor_fail_retry_count int(11)      NOT NULL DEFAULT '0' COMMENT '失败重试次数',
    glue_type                 varchar(50)  NOT NULL COMMENT 'GLUE类型',
    glue_source               mediumtext COMMENT 'GLUE源代码',
    glue_remark               varchar(128)          DEFAULT NULL COMMENT 'GLUE备注',
    glue_updatetime           datetime              DEFAULT NULL COMMENT 'GLUE更新时间',
    child_jobid               varchar(255)          DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
    trigger_status            tinyint(4)   NOT NULL DEFAULT '0' COMMENT '调度状态：0-停止，1-运行',
    trigger_last_time         bigint(13)   NOT NULL DEFAULT '0' COMMENT '上次调度时间',
    trigger_next_time         bigint(13)   NOT NULL DEFAULT '0' COMMENT '下次调度时间',
    PRIMARY KEY (id),
    KEY idx_xxl_job_info_1 (job_group)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 comment='任务信息表';

CREATE TABLE xxl_job_log
(
    id                        bigint(20) NOT NULL AUTO_INCREMENT COMMENT '调度主键ID',
    job_group                 int(11)    NOT NULL COMMENT '执行器主键ID',
    job_id                    int(11)    NOT NULL COMMENT '任务主键ID',
    executor_address          varchar(255)        DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
    executor_handler          varchar(255)        DEFAULT NULL COMMENT '执行器任务handler',
    executor_param            varchar(512)        DEFAULT NULL COMMENT '执行器任务参数',
    executor_sharding_param   varchar(20)         DEFAULT NULL COMMENT '执行器任务分片参数，格式如 1/2',
    executor_fail_retry_count int(11)    NOT NULL DEFAULT '0' COMMENT '失败重试次数',
    trigger_time              datetime            DEFAULT NULL COMMENT '调度-时间',
    trigger_code              int(11)    NOT NULL COMMENT '调度-结果',
    trigger_msg               text COMMENT '调度-日志',
    handle_time               datetime            DEFAULT NULL COMMENT '执行-时间',
    handle_code               int(11)    NOT NULL COMMENT '执行-状态',
    handle_msg                text COMMENT '执行-日志',
    alarm_status              tinyint(4) NOT NULL DEFAULT '0' COMMENT '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败',
    PRIMARY KEY (id),
    KEY idx_xxl_job_log_1 (trigger_time),
    KEY idx_xxl_job_log_2 (handle_code),
    KEY idx_xxl_job_log_3 (job_id,job_group),
    KEY idx_xxl_job_log_4 (job_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 comment='调度日志';

CREATE TABLE xxl_job_log_report
(
    id            int(11) NOT NULL AUTO_INCREMENT COMMENT '调度报告主键ID',
    trigger_day   datetime         DEFAULT NULL COMMENT '调度-时间',
    running_count int(11) NOT NULL DEFAULT '0' COMMENT '运行中-日志数量',
    suc_count     int(11) NOT NULL DEFAULT '0' COMMENT '执行成功-日志数量',
    fail_count    int(11) NOT NULL DEFAULT '0' COMMENT '执行失败-日志数量',
    update_time   datetime         DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY idex_xxl_job_log_report_1 (trigger_day) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 comment='调度报告';

CREATE TABLE xxl_job_logglue
(
    id          int(11)      NOT NULL AUTO_INCREMENT COMMENT 'GLUE主键ID',
    job_id      int(11)      NOT NULL COMMENT '任务主键ID',
    glue_type   varchar(50) DEFAULT NULL COMMENT 'GLUE类型',
    glue_source mediumtext COMMENT 'GLUE源代码',
    glue_remark varchar(128) NOT NULL COMMENT 'GLUE备注',
    add_time    datetime    DEFAULT NULL COMMENT '创建时间',
    update_time datetime    DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_xxl_job_logglue_1 (job_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 comment='GLUE任务';

CREATE TABLE xxl_job_registry
(
    id             int(11)      NOT NULL AUTO_INCREMENT COMMENT '注册主键ID',
    registry_group varchar(50)  NOT NULL COMMENT '注册组',
    registry_key   varchar(255) NOT NULL COMMENT '注册主键',
    registry_value varchar(255) NOT NULL COMMENT '注册值',
    update_time    datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY idx_xxl_job_registry_1 (registry_group, registry_key, registry_value) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 comment='客户端注册';

CREATE TABLE xxl_job_group
(
    id           int(11)     NOT NULL AUTO_INCREMENT COMMENT '执行器主键ID',
    app_name     varchar(64) NOT NULL COMMENT '执行器AppName',
    title        varchar(12) NOT NULL COMMENT '执行器名称',
    address_type tinyint(4)  NOT NULL DEFAULT '0' COMMENT '执行器地址类型：0=自动注册、1=手动录入',
    address_list text COMMENT '执行器地址列表，多地址逗号分隔',
    update_time  datetime             DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_xxl_job_group_1 (app_name)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 comment='执行器';

CREATE TABLE xxl_job_user
(
    id         int(11)     NOT NULL AUTO_INCREMENT COMMENT '账号主键ID',
    username   varchar(50) NOT NULL COMMENT '账号',
    password   varchar(50) NOT NULL COMMENT '密码',
    role       tinyint(4)  NOT NULL COMMENT '角色：0-普通用户、1-管理员',
    permission varchar(255) DEFAULT NULL COMMENT '权限：执行器ID列表，多个逗号分割',
    PRIMARY KEY (id),
    UNIQUE KEY idx_xxl_job_user_1 (username) USING BTREE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 comment='用户账号';

CREATE TABLE xxl_job_lock
(
    lock_name varchar(50) NOT NULL COMMENT '锁名称',
    PRIMARY KEY (lock_name)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 comment='并发锁';


## —————————————————————— init data ——————————————————

INSERT INTO xxl_job_group(id, app_name, title, address_type, address_list, update_time)
VALUES (1, 'xxl-job-executor-sample', '示例执行器', 0, NULL, '2018-11-03 22:21:31');

INSERT INTO xxl_job_info(id, job_group, job_desc, add_time, update_time, author, alarm_email,
                           schedule_type, schedule_conf, misfire_strategy, executor_route_strategy,
                           executor_handler, executor_param, executor_block_strategy, executor_timeout,
                           executor_fail_retry_count, glue_type, glue_source, glue_remark, glue_updatetime,
                           child_jobid)
VALUES (1, 1, '测试任务1', '2018-11-03 22:21:31', '2018-11-03 22:21:31', 'XXL', '', 'CRON', '0 0 0 * * ? *',
        'DO_NOTHING', 'FIRST', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化',
        '2018-11-03 22:21:31', '');

INSERT INTO xxl_job_user(id, username, password, role, permission)
VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);

INSERT INTO xxl_job_lock (lock_name)
VALUES ('schedule_lock');

commit;

