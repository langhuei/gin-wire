create table location.member_vip
(
    id                   bigint unsigned auto_increment
        primary key,
    user_id              bigint(11)                  not null comment '用户id',
    head_portrait        varchar(150)                null comment '头像',
    user_money           decimal(10, 2) default 0.00 null comment '余额',
    accumulate_money     decimal(10, 2) default 0.00 null comment '累积消费',
    frozen_money         decimal(10, 2) default 0.00 null comment '累积金额',
    user_integral        int            default 0    null comment '当前积分',
    visit_count          int(10)        default 1    null comment '访问次数',
    role                 smallint       default 10   null comment '权限',
    last_time            int(10)        default 0    null comment '最后一次登陆时间',
    last_ip              varchar(16)                 null comment '最后一次登陆ip',
    status               tinyint        default 1    null comment '状态[-1:删除;0:禁用;1启用]',
    password_hash        varchar(150)                null comment '密码',
    auth_key             varchar(32)                 null comment '授权令牌',
    password_reset_token varchar(150)                null comment '密码重置令牌',
    type                 tinyint        default 1    null comment '类别[1:普通会员;2白金会员,3黄金会员'
)
    comment '用户会员表';

create table location.user
(
    id                 bigint(11) auto_increment
        primary key,
    user_id            bigint(11)                         not null comment '用户id',
    phone              int                                null comment '手机号',
    username           varchar(45)                        null comment '真实姓名',
    email              varchar(30)                        null comment '用户邮箱',
    nickname           varchar(45)                        null comment '昵称',
    avatar             int                                null comment '头像',
    birthday           date                               null comment '生日',
    sex                tinyint  default 0                 null comment '性别',
    short_introduce    varchar(150)                       null comment '一句话介绍自己，最多50个汉字',
    user_register_ip   int                                not null comment '用户注册时的源ip',
    create_time        datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time        datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    user_review_status tinyint                            not null comment '用户资料审核状态，1为通过，2为审核中，3为未通过，4为还未提交审核',
    constraint idx_user_id
        unique (user_id)
)
    comment '用户基本信息表';

create index idx_create_time
    on location.user (create_time, user_review_status);

create index idx_username
    on location.user (username);

create table location.user_token
(
    id          bigint unsigned auto_increment
        primary key,
    user_id     bigint  default 0 not null comment '用户id',
    expire_time int(10) default 0 not null comment ' 过期时间',
    create_time int(10) default 0 not null comment '创建时间',
    token       varchar(64)       not null comment 'token',
    device_type varchar(10)       not null comment '设备类型;mobile,android,iphone,ipad,web,pc,mac,wxapp'
)
    comment '用户客户端登录 token 表';

