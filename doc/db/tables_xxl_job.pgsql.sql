---#
---# XXL-JOB v2.5.0
---# Copyright (c) 2015-present, xuxueli.

create table xxl_job_info
(
    id                        serial      not null ,
    job_group                 integer      not null ,
    job_desc                  varchar(255) not null,
    add_time                  timestamp              ,
    update_time               timestamp              ,
    author                    varchar(64)            ,
    alarm_email               varchar(255)           ,
    schedule_type             varchar(50)  not null default 'NONE' ,
    schedule_conf             varchar(128)           ,
    misfire_strategy          varchar(50)  not null default 'DO_NOTHING' ,
    executor_route_strategy   varchar(50)            ,
    executor_handler          varchar(255)           ,
    executor_param            varchar(512)           ,
    executor_block_strategy   varchar(50)            ,
    executor_timeout          integer      not null default 0 ,
    executor_fail_retry_count integer      not null default 0 ,
    glue_type                 varchar(50)  not null ,
    glue_source               text ,
    glue_remark               varchar(128)           ,
    glue_updatetime           timestamp               ,
    child_jobid               varchar(255)           ,
    trigger_status            int4   not null default 0 ,
    trigger_last_time         bigint   not null default 0 ,
    trigger_next_time         bigint   not null default 0 ,
    primary key (id)
)
;

select setval('xxl_job_info_id_seq',100);

create index idx_xxl_job_info_1 on xxl_job_info (job_group);

comment on table xxl_job_info is '任务信息表';
comment on column xxl_job_info.id is '任务主键ID';
comment on column xxl_job_info.job_group is '执行器主键ID';
comment on column xxl_job_info.job_desc is '任务描述';
comment on column xxl_job_info.add_time is '创建时间';
comment on column xxl_job_info.update_time is '更新时间';
comment on column xxl_job_info.author is '作者';
comment on column xxl_job_info.alarm_email is '报警邮件';
comment on column xxl_job_info.schedule_type is '调度类型';
comment on column xxl_job_info.schedule_conf is '调度配置，值含义取决于调度类型';
comment on column xxl_job_info.misfire_strategy is '调度过期策略';
comment on column xxl_job_info.executor_route_strategy is '执行器路由策略';
comment on column xxl_job_info.executor_handler is '执行器任务HANDLER';
comment on column xxl_job_info.executor_param is '执行器任务参数';
comment on column xxl_job_info.executor_block_strategy is '阻塞处理策略';
comment on column xxl_job_info.executor_timeout is '任务执行超时时间，单位秒';
comment on column xxl_job_info.executor_fail_retry_count is '失败重试次数';
comment on column xxl_job_info.glue_type is 'GLUE类型';
comment on column xxl_job_info.glue_source is 'GLUE源代码';
comment on column xxl_job_info.glue_remark is 'GLUE备注';
comment on column xxl_job_info.glue_updatetime is 'GLUE更新时间';
comment on column xxl_job_info.child_jobid is '子任务ID，多个逗号分隔';
comment on column xxl_job_info.trigger_status is '调度状态：0-停止，1-运行';
comment on column xxl_job_info.trigger_last_time is '上次调度时间';
comment on column xxl_job_info.trigger_next_time is '下次调度时间';


create table xxl_job_log
(
    id                        serial not null ,
    job_group                 integer    not null ,
    job_id                    integer    not null ,
    executor_address          varchar(255)         ,
    executor_handler          varchar(255)         ,
    executor_param            varchar(512)         ,
    executor_sharding_param   varchar(20)          ,
    executor_fail_retry_count integer    not null default 0 ,
    trigger_time              timestamp             ,
    trigger_code              integer    not null ,
    trigger_msg               text ,
    handle_time               timestamp             ,
    handle_code               integer    not null ,
    handle_msg                text ,
    alarm_status              int4 not null default 0 ,
    primary key (id)
)
;

select setval('xxl_job_log_id_seq',100);

create index idx_xxl_job_log_1 on xxl_job_log (trigger_time);
create index idx_xxl_job_log_2 on xxl_job_log (handle_code);
create index idx_xxl_job_log_3 on xxl_job_log (job_id,job_group);
create index idx_xxl_job_log_4 on xxl_job_log (job_id);

comment on table xxl_job_log is '调度日志';
comment on column xxl_job_log.id is '调度主键ID';
comment on column xxl_job_log.job_group is '执行器主键ID';
comment on column xxl_job_log.job_id is '任务主键ID';
comment on column xxl_job_log.executor_address is '执行器地址，本次执行的地址';
comment on column xxl_job_log.executor_handler is '执行器任务HANDLER';
comment on column xxl_job_log.executor_param is '执行器任务参数';
comment on column xxl_job_log.executor_sharding_param is '执行器任务分片参数，格式如 1/2';
comment on column xxl_job_log.executor_fail_retry_count is '失败重试次数';
comment on column xxl_job_log.trigger_time is '调度-时间';
comment on column xxl_job_log.trigger_code is '调度-结果';
comment on column xxl_job_log.trigger_msg is '调度-日志';
comment on column xxl_job_log.handle_time is '执行-时间';
comment on column xxl_job_log.handle_code is '执行-状态';
comment on column xxl_job_log.handle_msg is '执行-日志';
comment on column xxl_job_log.alarm_status is '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败';


create table xxl_job_log_report
(
    id            serial not null,
    trigger_day   timestamp          ,
    running_count integer not null default 0 ,
    suc_count     integer not null default 0 ,
    fail_count    integer not null default 0 ,
    update_time   timestamp         ,
    primary key (id)
)
;

select setval('xxl_job_log_report_id_seq',100);

create unique index idx_xxl_job_log_report_1 on xxl_job_log_report (trigger_day);


comment on table xxl_job_log_report is '调度报告';
comment on column xxl_job_log_report.id is '调度报告主键ID';
comment on column xxl_job_log_report.trigger_day is '调度-时间';
comment on column xxl_job_log_report.running_count is '运行中-日志数量';
comment on column xxl_job_log_report.suc_count is '执行成功-日志数量';
comment on column xxl_job_log_report.fail_count is '执行失败-日志数量';
comment on column xxl_job_log_report.update_time is '更新时间';

create table xxl_job_logglue
(
    id          serial      not null,
    job_id      integer      not null ,
    glue_type   varchar(50)  ,
    glue_source text ,
    glue_remark varchar(128) not null ,
    add_time    timestamp    ,
    update_time timestamp    ,
    primary key (id)
)
;

select setval('xxl_job_logglue_id_seq',100);

create index idx_xxl_job_logglue_1 on xxl_job_logglue (job_id);

comment on table xxl_job_logglue is 'GLUE任务';
comment on column xxl_job_logglue.id is 'GLUE主键ID';
comment on column xxl_job_logglue.job_id is '任务主键ID';
comment on column xxl_job_logglue.glue_type is 'GLUE类型';
comment on column xxl_job_logglue.glue_source is 'GLUE源代码';
comment on column xxl_job_logglue.glue_remark is 'GLUE备注';
comment on column xxl_job_logglue.add_time is '创建时间';
comment on column xxl_job_logglue.update_time is '更新时间';
create table xxl_job_registry
(
    id             serial      not null ,
    registry_group varchar(50)  not null,
    registry_key   varchar(255) not null,
    registry_value varchar(255) not null,
    update_time    timestamp            ,
    primary key (id)
)
;

select setval('xxl_job_registry_id_seq',100);

create unique index idx_xxl_job_registry_1 on xxl_job_registry (registry_group, registry_key, registry_value);

comment on table xxl_job_registry is '客户端注册';
comment on column xxl_job_registry.id is '注册主键ID';
comment on column xxl_job_registry.registry_group is '注册组';
comment on column xxl_job_registry.registry_key is '注册主键';
comment on column xxl_job_registry.registry_value is '注册值';
comment on column xxl_job_registry.update_time is '更新时间';


create table xxl_job_group
(
    id           serial     not null ,
    app_name     varchar(64) not null ,
    title        varchar(64) not null ,
    address_type int4  not null default 0 ,
    address_list text ,
    update_time  timestamp ,
    primary key (id)
)
;

select setval('xxl_job_group_id_seq',100);

create index idx_xxl_job_group_1 on xxl_job_group (app_name);

comment on table xxl_job_registry is '执行器';
comment on column xxl_job_registry.id is '执行器主键ID';
comment on column xxl_job_group.app_name is '执行器APPNAME';
comment on column xxl_job_group.title is '执行器名称';
comment on column xxl_job_group.address_type is '执行器地址类型：0=自动注册、1=手动录入';
comment on column xxl_job_group.address_list is '执行器地址列表，多地址逗号分隔';
comment on column xxl_job_group.update_time is '更新时间';


create table xxl_job_user
(
    id         serial     not null ,
    username   varchar(50) not null ,
    password   varchar(300) not null ,
    role       int4  not null ,
    permission varchar(255)  ,
    primary key (id)
)
;

select setval('xxl_job_user_id_seq',100);

create unique index idx_xxl_job_user_1 on xxl_job_user (username);

comment on table xxl_job_user is '用户账号';
comment on column xxl_job_user.id is '用户主键ID';
comment on column xxl_job_user.username is '账号';
comment on column xxl_job_user.password is '密码';
comment on column xxl_job_user.role is '角色：0-普通用户、1-管理员';
comment on column xxl_job_user.permission is '权限：执行器ID列表，多个逗号分割';

create table xxl_job_lock
(
    lock_name varchar(50) not null ,
    primary key (lock_name)
)
;

comment on table xxl_job_user is '并发锁';
comment on column xxl_job_lock.lock_name is '锁名称';

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


