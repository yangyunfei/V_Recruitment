/******应聘人员导出*************/
SELECT
  a.id AS 标号,
  (SELECT NAME FROM table_code WHERE tablename = 'presentee' AND `attribute` = 'state' AND CODE = a.state ) AS 最后状态,
  (SELECT NAME FROM `user` WHERE id = a.handleman) AS 处理人,
   CASE  a.weight WHEN  0 THEN '共享池' ELSE '历史池' END AS 资源池归属,
  (SELECT NAME FROM table_code WHERE tablename = 'presentee' AND `attribute` = 'cancle' AND CODE = a.cancle ) AS 淘汰原因,
  a.name AS 新人姓名,
  a.phone AS 联系方式,
  p.name AS 推荐人姓名,
  a.recordman AS 推荐人系统号,
  p.mobile AS 推荐人手机号码,
  p.department AS 运营管理大区,
  (SELECT NAME FROM table_code WHERE tablename = 'presentee' AND `attribute` = 'degree' AND CODE = a.degree ) AS 学历,
  a.school_name AS 学校名称,
  a.school_level AS 学校级别,
  a.createtime AS 推荐时间, 
  a.lastUpdateTime AS 最后处理时间
  FROM presentee a  LEFT JOIN agent p ON a.recordman = p.pager WHERE lastUpdateTime > '2015-12-01' AND lastUpdateTime < '2015-12-07'
  
/******招聘任务导出*************/
    SELECT
  `presentee_id` AS 应聘人员标号,
  (SELECT NAME FROM `user` WHERE id = a.handleman) AS 处理人,
  (SELECT NAME FROM table_code WHERE tablename = 'presentee' AND `attribute` = 'state' AND CODE = a.state ) AS 招聘任务状态,
  (SELECT NAME FROM table_code WHERE tablename = 'presentee' AND `attribute` = 'cancle' AND CODE = a.cancle ) AS 淘汰原因,
  interviewtime 面试时间,
  createtime  AS 创建时间,
  lastUpdateTime AS 最后操作时间
FROM recruit a WHERE a.lastUpdateTime > '2015-12-01' AND a.lastUpdateTime < '2015-12-07'

/******操作记录导出*************/
SELECT
   `presentee_id` AS 应聘人员标号,

	(SELECT NAME FROM `user` WHERE id = a.handleman) AS 处理人,
    (SELECT NAME FROM table_code WHERE tablename = 'presentee' AND `attribute` = 'state' AND CODE = a.state ) AS 应聘者最后状态,
   (SELECT NAME FROM table_code WHERE tablename = 'presentee' AND `attribute` = 'cancle' AND CODE = a.cancle ) AS 淘汰原因,
  `description` AS 操作类型,
  `createtime` AS 创建时间
FROM `v_recruitment`.`recruit_record` a  WHERE a.createtime > '2015-12-01' AND a.createtime < '2015-12-07'



/******招聘任务详细导出表**********/
SELECT
  `r`.`presentee_id`   AS `应聘人员标号`,
  `p`.`name`           AS `应聘人员姓名`,
  `p`.`phone`          AS `应聘人员联系方式`,
  `d`.`name`           AS `学历`,
  `p`.`school_name`    AS `学校名称`,
  `p`.`school_level`   AS `学校级别`,
  `a`.`name`           AS `推荐人姓名`,
  `p`.`recordman`      AS `推荐人系统号`,
  `a`.`mobile`         AS `推荐人手机号码`,
  `a`.`department`     AS `运营管理大区`,
  `p`.`createtime`     AS `推荐时间`,
  `u`.`name`           AS `处理人`,
  `s`.`name`           AS `招聘任务状态`,
  `c`.`name`           AS `淘汰原因`,
  `r`.`interviewtime`  AS `面试时间`,
  `r`.`createtime`     AS `创建时间`,
  `r`.`lastUpdateTime` AS `最后操作时间`
FROM `recruit` `r`
       LEFT JOIN `presentee` `p` ON r.`presentee_id` = p.`id`
       LEFT JOIN `agent` `a`
         ON `p`.`recordman` = `a`.`pager`
      LEFT JOIN `user` `u`
        ON `u`.`id` = `r`.`handleman`
     LEFT JOIN `v_degree` `d`
       ON `p`.`degree` = `d`.`code`
    LEFT JOIN `v_state` `s`
      ON `r`.`state` = `s`.`code`
   LEFT JOIN `v_cancle` `c`
     ON `r`.`cancle` = `c`.`code`