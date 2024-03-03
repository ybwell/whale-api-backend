# 数据库初始化
-- 创建库
create database if not exists whale_api;

-- 切换库
use whale_api;

-- 用户表
create table if not exists user
(
    id           bigint auto_increment comment 'id' primary key,
    userName     varchar(256)                           null comment '用户昵称',
    userAccount  varchar(256)                           not null comment '账号',
    userAvatar   varchar(1024)                          null comment '用户头像',
    gender       tinyint                                null comment '性别',
    userRole     varchar(256) default 'user'            not null comment '用户角色：user / admin',
    userPassword varchar(512)                           not null comment '密码',
    `accessKey` varchar(512) not null comment 'accessKey',
    `secretKey` varchar(512) not null comment 'secretKey',
    createTime   datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime   datetime     default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete     tinyint      default 0                 not null comment '是否删除',
    constraint uni_userAccount
    unique (userAccount)
    ) comment '用户';

-- 接口信息
create table if not exists whale_api.`interface_info`
(
    `id` bigint not null auto_increment comment '主键' primary key,
    `name` varchar(256) not null comment '名称',
    `description` varchar(256) null comment '描述',
    `url` varchar(512) not null comment '接口地址',
    `requestParams` text not null comment '请求参数',
    `requestHeader` text null comment '请求头',
    `responseHeader` text null comment '响应头',
    `status` int default 0 not null comment '接口状态（0-关闭，1-开启）',
    `method` varchar(256) not null comment '请求类型',
    `userId` bigint not null comment '创建人',
    `createTime` datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    `updateTime` datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    `isDelete` tinyint default 0 not null comment '是否删除(0-未删, 1-已删)'
    ) comment '接口信息';

-- 用户调用接口关系表
create table if not exists whale_api.`user_interface_info`
(
    `id` bigint not null auto_increment comment '主键' primary key,
    `userId` bigint not null comment '调用用户 id',
    `interfaceInfoId` bigint not null comment '接口 id',
    `totalNum` int default 0 not null comment '总调用次数',
    `leftNum` int default 0 not null comment '剩余调用次数',
    `status` int default 0 not null comment '0-正常，1-禁用',
    `createTime` datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    `updateTime` datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    `isDelete` tinyint default 0 not null comment '是否删除(0-未删, 1-已删)'
) comment '用户调用接口关系';

INSERT INTO whale_api.interface_info (`name`, `description`, `url`, `requestParams`, `requestHeader`, `responseHeader`, `status`, `method`, `userId`, `createTime`, `updateTime`, `isDelete`)
VALUES
    ('用户登录接口', '用于用户登录操作', 'https://example.com/api/login', '{"username": "string", "password": "string"}', '{"Content-Type": "application/json"}', '{"Content-Type": "application/json"}', 1, 'POST', 123456, '2024-03-03 09:00:00', '2024-03-03 09:00:00', 0),
    ('获取用户信息接口', '用于获取用户详细信息', 'https://example.com/api/userinfo', '{}', '{"Authorization": "Bearer token"}', '{"Content-Type": "application/json"}', 1, 'GET', 123456, '2024-03-03 09:00:00', '2024-03-03 09:00:00', 0),
    ('创建订单接口', '用于创建新订单', 'https://example.com/api/order', '{"product_id": 123, "quantity": 2}', '{"Authorization": "Bearer token", "Content-Type": "application/json"}', '{"Content-Type": "application/json"}', 1, 'POST', 789012, '2024-03-03 09:00:00', '2024-03-03 09:00:00', 0),
    ('获取订单列表接口', '用于获取用户订单列表', 'https://example.com/api/orders', '{}', '{"Authorization": "Bearer token"}', '{"Content-Type": "application/json"}', 1, 'GET', 789012, '2024-03-03 09:00:00', '2024-03-03 09:00:00', 0),
    ('更新订单状态接口', '用于更新订单状态', 'https://example.com/api/order/status', '{"order_id": 456, "status": "shipped"}', '{"Authorization": "Bearer token", "Content-Type": "application/json"}', '{"Content-Type": "application/json"}', 1, 'PUT', 345678, '2024-03-03 09:00:00', '2024-03-03 09:00:00', 0),
    ('删除订单接口', '用于删除订单', 'https://example.com/api/order/delete', '{"order_id": 789}', '{"Authorization": "Bearer token", "Content-Type": "application/json"}', '{"Content-Type": "application/json"}', 1, 'DELETE', 345678, '2024-03-03 09:00:00', '2024-03-03 09:00:00', 0),
    ('搜索商品接口', '用于搜索商品', 'https://example.com/api/products/search', '{"keyword": "string", "category": "string"}', '{"Authorization": "Bearer token", "Content-Type": "application/json"}', '{"Content-Type": "application/json"}', 1, 'POST', 901234, '2024-03-03 09:00:00', '2024-03-03 09:00:00', 0),
    ('获取商品详情接口', '用于获取商品详细信息', 'https://example.com/api/products/123', '{}', '{"Authorization": "Bearer token"}', '{"Content-Type": "application/json"}', 1, 'GET', 901234, '2024-03-03 09:00:00', '2024-03-03 09:00:00', 0),
    ('创建用户接口', '用于创建新用户', 'https://example.com/api/user/create', '{"username": "string", "password": "string"}', '{"Content-Type": "application/json"}', '{"Content-Type": "application/json"}', 1, 'POST', 567890, '2024-03-03 09:00:00', '2024-03-03 09:00:00', 0),
    ('更新用户信息接口', '用于更新用户信息', 'https://example.com/api/user/update', '{"username": "string", "email": "string"}', '{"Authorization": "Bearer token", "Content-Type": "application/json"}', '{"Content-Type": "application/json"}', 1, 'PUT', 567890, '2024-03-03 09:00:00', '2024-03-03 09:00:00', 0);
