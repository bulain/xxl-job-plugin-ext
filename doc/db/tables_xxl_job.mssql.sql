---#
---# XXL-JOB v2.5.0
---# Copyright (c) 2015-present, xuxueli.

create table xxl_job_info
(
    id bigint identity(100,1) not null,
    job_group bigint not null,
    job_desc varchar (512) not null,
    add_time        datetime,
    update_time     datetime,
    author varchar (125),
    alarm_email varchar (512),
    schedule_type varchar (100) default 'NONE' not null,
    schedule_conf varchar (256),
    misfire_strategy varchar (100) default 'DO_NOTHING' not null,
    executor_route_strategy varchar (100),
    executor_handler varchar (512),
    executor_param varchar (1024),
    executor_block_strategy varchar (100),
    executor_timeout int default 0 not null,
    executor_fail_retry_count int default 0 not null,
    glue_type varchar (100) not null,
    glue_source text,
    glue_remark varchar (256),
    glue_updatetime datetime,
    child_jobid varchar (512),
    trigger_status int default 0 not null,
    trigger_last_time bigint default 0,
    trigger_next_time bigint default 0,
    primary key (id)
);

create index idx_xxl_job_info_1 on xxl_job_info (job_group);

exec sp_addextendedproperty
    @level0type = n'schema', @level0name = 'dbo',
    @level1type = n'table',  @level1name = n'xxl_job_info',
   	@name = n'ms_description',@value = n'任务信息表'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'id',
    @name = n'ms_description', @value = n'任务主键ID'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'job_group',
    @name = n'ms_description', @value = n'执行器主键ID'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'job_desc',
    @name = n'ms_description', @value = n'任务描述'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'add_time',
    @name = n'ms_description', @value = n'创建时间'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'update_time',
    @name = n'ms_description', @value = n'更新时间'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'author',
    @name = n'ms_description', @value = n'作者'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'alarm_email',
    @name = n'ms_description', @value = n'报警邮件'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'schedule_type',
    @name = n'ms_description', @value = n'调度类型'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'schedule_conf',
    @name = n'ms_description', @value = n'调度配置，值含义取决于调度类型'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'misfire_strategy',
    @name = n'ms_description', @value = n'调度过期策略'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'executor_route_strategy',
    @name = n'ms_description', @value = n'执行器路由策略'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'executor_handler',
    @name = n'ms_description', @value = n'执行器任务HANDLER'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'executor_param',
    @name = n'ms_description', @value = n'执行器任务参数'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'executor_block_strategy',
    @name = n'ms_description', @value = n'阻塞处理策略'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'executor_timeout',
    @name = n'ms_description', @value = n'任务执行超时时间，单位秒'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'executor_fail_retry_count',
    @name = n'ms_description', @value = n'失败重试次数'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'glue_type',
    @name = n'ms_description', @value = n'GLUE类型'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'glue_source',
    @name = n'ms_description', @value = n'GLUE源代码'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'glue_remark',
    @name = n'ms_description', @value = n'GLUE备注'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'glue_updatetime',
    @name = n'ms_description', @value = n'GLUE更新时间'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'child_jobid',
    @name = n'ms_description', @value = n'子任务ID，多个逗号分隔'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'trigger_status',
    @name = n'ms_description', @value = n'调度状态：0-停止，1-运行'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'trigger_last_time',
    @name = n'ms_description', @value = n'上次调度时间'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_info',
    @level2type = n'column',  @level2name = 'trigger_next_time',
    @name = n'ms_description', @value = n'下次调度时间'
    ;



create table xxl_job_log
(
    id bigint identity(100,1) not null,
    job_group bigint not null,
    job_id bigint not null,
    executor_address varchar (512),
    executor_handler varchar (512),
    executor_param varchar (1024),
    executor_sharding_param varchar (40),
    executor_fail_retry_count int default 0 not null,
    trigger_time datetime,
    trigger_code int not null,
    trigger_msg text,
    handle_time  datetime,
    handle_code int not null,
    handle_msg text,
    alarm_status int default 0 not null,
    primary key (id)
);

create index idx_xxl_job_log_1 on xxl_job_log (trigger_time);
create index idx_xxl_job_log_2 on xxl_job_log (handle_code);
create index idx_xxl_job_log_3 on xxl_job_log (job_id,job_group);
create index idx_xxl_job_log_4 on xxl_job_log (job_id);

exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @name = n'ms_description', @value = n'调度日志'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'id',
    @name = n'ms_description', @value = n'调度主键ID'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'job_group',
    @name = n'ms_description', @value = n'执行器主键ID'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'job_id',
    @name = n'ms_description', @value = n'任务主键ID'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'executor_address',
    @name = n'ms_description', @value = n'执行器地址，本次执行的地址'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'executor_handler',
    @name = n'ms_description', @value = n'执行器任务HANDLER'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'executor_param',
    @name = n'ms_description', @value = n'执行器任务参数'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'executor_sharding_param',
    @name = n'ms_description', @value = n'执行器任务分片参数，格式如 1/2'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'executor_fail_retry_count',
    @name = n'ms_description', @value = n'失败重试次数'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'trigger_time',
    @name = n'ms_description', @value = n'调度-时间'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'trigger_code',
    @name = n'ms_description', @value = n'调度-结果'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'trigger_msg',
    @name = n'ms_description', @value = n'调度-日志'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'handle_time',
    @name = n'ms_description', @value = n'执行-时间'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'handle_code',
    @name = n'ms_description', @value = n'执行-状态'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'handle_msg',
    @name = n'ms_description', @value = n'执行-日志'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log',
    @level2type = n'column',  @level2name = 'alarm_status',
    @name = n'ms_description', @value = n'告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败'
    ;


create table xxl_job_log_report
(
    id bigint identity(100,1) not null,
    trigger_day datetime,
    running_count int default 0 not null,
    suc_count int default 0 not null,
    fail_count int default 0 not null,
    update_time datetime,
    primary key (id)
);

create unique index idx_xxl_job_log_report_1 on xxl_job_log_report (trigger_day);

exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log_report',
    @name = n'ms_description', @value = n'调度报告'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log_report',
    @level2type = n'column',  @level2name = 'id',
    @name = n'ms_description', @value = n'调度报告主键ID'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log_report',
    @level2type = n'column',  @level2name = 'trigger_day',
    @name = n'ms_description', @value = n'调度-时间'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log_report',
    @level2type = n'column',  @level2name = 'running_count',
    @name = n'ms_description', @value = n'运行中-日志数量'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log_report',
    @level2type = n'column',  @level2name = 'suc_count',
    @name = n'ms_description', @value = n'执行成功-日志数量'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log_report',
    @level2type = n'column',  @level2name = 'fail_count',
    @name = n'ms_description', @value = n'执行失败-日志数量'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_log_report',
    @level2type = n'column',  @level2name = 'update_time',
    @name = n'ms_description', @value = n'更新时间'
    ;

create table xxl_job_logglue
(
    id bigint identity(100,1) not null,
    job_id bigint not null,
    glue_type varchar (100),
    glue_source text,
    glue_remark varchar (256) not null,
    add_time    datetime,
    update_time datetime,
    primary key (id)
);

create index idx_xxl_job_logglue_1 on xxl_job_logglue (job_id);

exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @name = n'ms_description', @value = n'GLUE任务'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'id',
    @name = n'ms_description', @value = n'GLUE主键ID'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'job_id',
    @name = n'ms_description', @value = n'任务主键ID'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'glue_type',
    @name = n'ms_description', @value = n'GLUE类型'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'glue_source',
    @name = n'ms_description', @value = n'GLUE源代码'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'glue_remark',
    @name = n'ms_description', @value = n'GLUE备注'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'add_time',
    @name = n'ms_description', @value = n'创建时间'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'update_time',
    @name = n'ms_description', @value = n'更新时间'
    ;

create table xxl_job_registry
(
    id bigint identity(100,1) not null,
    registry_group varchar (100) not null,
    registry_key varchar (512) not null,
    registry_value varchar (512) not null,
    update_time datetime,
    primary key (id)
);

create unique index idx_xxl_job_registry_1 on xxl_job_registry (registry_group, registry_key, registry_value);

exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @name = n'ms_description', @value = n'客户端注册'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'id',
    @name = n'ms_description', @value = n'注册主键ID'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'registry_group',
    @name = n'ms_description', @value = n'注册组'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'registry_key',
    @name = n'ms_description', @value = n'注册主键'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'registry_value',
    @name = n'ms_description', @value = n'注册值'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_logglue',
    @level2type = n'column',  @level2name = 'update_time',
    @name = n'ms_description', @value = n'更新时间'
    ;

create table xxl_job_group
(
    id bigint identity(100,1) not null,
    app_name varchar (128) not null,
    title varchar (128) not null,
    address_type int default 0 not null,
    address_list varchar (4000),
    update_time datetime,
    primary key (id)
);


exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_group',
    @name = n'ms_description', @value = n'执行器'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_group',
    @level2type = n'column',  @level2name = 'id',
    @name = n'ms_description', @value = n'执行器主键ID'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_group',
    @level2type = n'column',  @level2name = 'app_name',
    @name = n'ms_description', @value = n'执行器APPNAME'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_group',
    @level2type = n'column',  @level2name = 'title',
    @name = n'ms_description', @value = n'执行器名称'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_group',
    @level2type = n'column',  @level2name = 'address_type',
    @name = n'ms_description', @value = n'执行器地址类型：0=自动注册、1=手动录入'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_group',
    @level2type = n'column',  @level2name = 'address_list',
    @name = n'ms_description', @value = n'执行器地址列表，多地址逗号分隔'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_group',
    @level2type = n'column',  @level2name = 'update_time',
    @name = n'ms_description', @value = n'更新时间'
    ;


create table xxl_job_user
(
    id bigint identity(100,1) not null,
    username varchar (100) not null,
    password varchar (600) not null,
    role int not null,
    permission varchar (512),
    primary key (id)
);

create unique index idx_xxl_job_user_1 on xxl_job_user (username);

exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_user',
    @name = n'ms_description', @value = n'用户账号'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_user',
    @level2type = n'column',  @level2name = 'id',
    @name = n'ms_description', @value = n'用户主键ID'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_user',
    @level2type = n'column',  @level2name = 'username',
    @name = n'ms_description', @value = n'账号'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_user',
    @level2type = n'column',  @level2name = 'password',
    @name = n'ms_description', @value = n'密码'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_user',
    @level2type = n'column',  @level2name = 'role',
    @name = n'ms_description', @value = n'角色：0-普通用户、1-管理员'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_user',
    @level2type = n'column',  @level2name = 'permission',
    @name = n'ms_description', @value = n'权限：执行器ID列表，多个逗号分割'
    ;


create table xxl_job_lock
(
    lock_name varchar (100) not null,
    primary key (lock_name)
);

exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_lock',
    @name = n'ms_description', @value = n'并发锁'
    ;
exec sys.sp_addextendedproperty
    @level0type = n'schema',  @level0name = n'dbo',
    @level1type = n'table',  @level1name = 'xxl_job_lock',
    @level2type = n'column',  @level2name = 'lock_name',
    @name = n'ms_description', @value = n'锁名称'
    ;

set identity_insert XXL_JOB_GROUP on;

INSERT INTO XXL_JOB_GROUP(ID, APP_NAME, TITLE, ADDRESS_TYPE, ADDRESS_LIST, UPDATE_TIME)
VALUES (1, 'xxl-job-executor-sample', '示例执行器', 0, NULL, convert(datetime,'2018-11-03 22:21:31'));

set identity_insert XXL_JOB_GROUP off;

set identity_insert XXL_JOB_INFO on;

INSERT INTO XXL_JOB_INFO(ID, JOB_GROUP, JOB_DESC,
                           ADD_TIME, UPDATE_TIME,
                           AUTHOR, ALARM_EMAIL,
                           SCHEDULE_TYPE, SCHEDULE_CONF,
                           MISFIRE_STRATEGY, EXECUTOR_ROUTE_STRATEGY,
                           EXECUTOR_HANDLER, EXECUTOR_PARAM,
                           EXECUTOR_BLOCK_STRATEGY,
                           EXECUTOR_TIMEOUT, EXECUTOR_FAIL_RETRY_COUNT,
                           GLUE_TYPE, GLUE_SOURCE, GLUE_REMARK,
                           GLUE_UPDATETIME,
                           CHILD_JOBID)
VALUES (1, 1, '测试任务1',
        convert(datetime,'2018-11-03 22:21:31'),
        convert(datetime,'2018-11-03 22:21:31'),
        'XXL', '',
        'CRON', '0 0 0 * * ? *',
        'DO_NOTHING', 'FIRST',
        'demoJobHandler', '',
        'SERIAL_EXECUTION', 0, 0,
        'BEAN', '', 'GLUE代码初始化',
        convert(datetime,'2018-11-03 22:21:31'),
        '');

set identity_insert XXL_JOB_INFO off;

set identity_insert XXL_JOB_USER on;

INSERT INTO XXL_JOB_USER(ID, USERNAME, PASSWORD, ROLE, PERMISSION)
VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);

set identity_insert XXL_JOB_USER off;

INSERT INTO XXL_JOB_LOCK (LOCK_NAME)
VALUES ('schedule_lock');

