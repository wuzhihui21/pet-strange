
module.exports = {
    t_user: {
        login: "select * from t_user where uphone=? and upass=? and urole='1' ",
        selectUser:`select uid,uphone,upass,uname,imageUrl,usex,uage,DATE_FORMAT(utime, '%Y-%m-%d %H:%i:%s') AS utime,
                CASE
                    WHEN ustatus =1 THEN '正常'
                    WHEN ustatus =2 THEN '封禁 '
                END AS ustatus
                FROM t_user `,
        updateUser:`UPDATE t_user SET upass=?,uname=?,imageUrl=?,usex=?,uage=? where uid=?`


    },
    charts: {
        select: `select count(*)as totalpost from t_post;
                select count(*)as totaluser from t_user;
                select count(*)as lastpost from t_post where post_time>?;
                select count(*)as lastuser from t_user where utime>?`,
        columnChart: `DROP TEMPORARY TABLE IF EXISTS TempDates;
                CREATE TEMPORARY TABLE TempDates (date DATE);
                INSERT INTO TempDates (date) VALUES
                    (CURDATE()),
                    (CURDATE() - INTERVAL 1 DAY),
                    (CURDATE() - INTERVAL 2 DAY),
                    (CURDATE() - INTERVAL 3 DAY),
                    (CURDATE() - INTERVAL 4 DAY),
                    (CURDATE() - INTERVAL 5 DAY),
                    (CURDATE() - INTERVAL 6 DAY);
                SELECT DATE_FORMAT(TempDates.date, '%m-%d') AS date,COUNT(t_post.post_id) FROM TempDates 
                LEFT JOIN t_post ON DATE(t_post.post_time) = TempDates.date GROUP BY TempDates.date
                ORDER BY TempDates.date;`,
        workSectorChart:`SELECT CASE WHEN status_values.status ='1' THEN '正常' WHEN status_values.status ='0' THEN '封禁 ' END AS name,
                COUNT(t_post.post_id) AS value FROM (SELECT '0' AS status UNION SELECT '1' AS status) AS status_values
                LEFT JOIN t_post ON status_values.status = t_post.post_status
                GROUP BY status_values.status;`,
        userSectorChart:`SELECT CASE WHEN status_values.status ='1' THEN '正常' WHEN status_values.status ='0' THEN '封禁 ' END AS name,
                COUNT(t_user.uid) AS value FROM (SELECT '0' AS status UNION SELECT '1' AS status) AS status_values
                LEFT JOIN t_user ON status_values.status = t_user.ustatus
                GROUP BY status_values.status;`
    },
    t_post:{
        selectLatest:`select t_post.post_id,t_post.post_image,t_post.post_title,t_post.post_like,DATE_FORMAT(t_post.post_time, '%Y-%m-%d %H:%i:%s') AS post_time,t_post.post_type,t_user.uname,t_user.uphone FROM t_post LEFT JOIN t_user ON t_user.uid=t_post.uid
                    WHERE t_post.post_audit='0' AND t_user.ustatus='1' and t_user.urole='0';`,
        selectPostDetail:`select t_post.post_id,t_post.post_image,t_post.post_title,t_post.post_describe,DATE_FORMAT(t_post.post_time, '%Y-%m-%d %H:%i:%s') AS post_time,t_post.post_like,t_post.post_type,t_post.post_notes,t_user.uid,t_user.uname,t_user.uphone 
                    FROM t_post LEFT JOIN t_user ON t_user.uid=t_post.uid
                    WHERE t_post.post_id=?;
                    select count(*)as commentNum from t_comments 
                    LEFT JOIN t_post ON t_post.post_id=t_comments.post_id WHERE t_post.post_id=?;
                    select t_comments.c_content,t_comments.c_like,DATE_FORMAT(t_comments.c_time, '%Y-%m-%d %H:%i:%s') AS c_time,t_user.uname,t_user.uphone FROM t_comments
                    LEFT JOIN t_user ON t_user.uid=t_comments.uid WHERE t_comments.post_id=? `,
        selectHistorical:`select DATE_FORMAT(t_post.post_time, '%Y-%m-%d') AS time,t_post.post_id,t_post.post_title,t_post.post_type,t_user.uname,t_user.uphone from t_post 
                    LEFT JOIN t_user ON t_user.uid=t_post.uid
                    WHERE post_status='1' AND post_audit='1'`,
        updateAudit:`update t_post set post_audit='1' where post_id=?`,
        insertPost:`INSERT INTO t_post(post_image,post_title,post_describe,post_type,post_notes,post_time,post_status,uid,post_like,post_audit)
                VALUES(?,?,?,?,?,?,?,?,?,?);`,
        selectUserWorkData:`select count(*) as num FROM t_focus WHERE focus_id=?;
                select sum(post_like)as allnum FROM t_post WHERE t_post.uid=?;
                select DATE_FORMAT(t_post.post_time, '%Y-%m-%d %H:%i:%s') AS time,t_post.post_id,t_post.post_image,t_post.post_title,t_post.post_like,t_user.uname,t_user.uphone FROM t_post LEFT JOIN t_user ON t_user.uid=t_post.uid
                WHERE t_post.uid=?;`,
        selectLikeNum:`select post_like from t_post where post_id=?`,
        deletePost:`delete from t_post where post_id=?`,
        updateDolike:`update t_post set post_like=? where post_id=?`,
        updateWork:`UPDATE t_post SET post_image=?,post_title=?,post_describe=?,post_type=?,post_notes=?,post_time=?,post_audit=? WHERE post_id=? `
    },
    t_banned_work: {
        insertBanned: `INSERT INTO t_banned_work(post_id,b_case,b_time,b_status) VALUES(?,?,?,?);
                    update t_post set post_status='0' where post_id=?;
                    INSERT INTO t_messages(m_content,send_id,send_time,reception_id) VALUES(?,?,?,?);`,
        selectBannedDate: `SELECT t_post.post_id, DATE_FORMAT(t_banned_work.b_time, '%Y-%m-%d %H:%i:%s') AS b_time,t_user.uname,t_user.uphone,t_post.post_title,
                    t_post.post_type,t_banned_work.b_case FROM t_post 
                    LEFT JOIN t_user ON t_user.uid=t_post.uid
                    LEFT JOIN t_banned_work ON t_post.post_id=t_banned_work.post_id
                    WHERE t_post.post_status='0' AND t_banned_work.b_time >= NOW() - INTERVAL 7 DAY and t_banned_work.b_status='1';
                    SELECT t_post.post_id, DATE_FORMAT(t_banned_work.b_time, '%Y-%m-%d %H:%i:%s') AS b_time,t_user.uname,t_user.uphone,t_post.post_title,
                    t_post.post_type,t_banned_work.b_case FROM t_post 
                    LEFT JOIN t_user ON t_user.uid=t_post.uid
                    LEFT JOIN t_banned_work ON t_post.post_id=t_banned_work.post_id
                    WHERE t_banned_work.b_status='0';
                    SELECT t_post.post_id, DATE_FORMAT(t_banned_work.b_time, '%Y-%m-%d %H:%i:%s') AS b_time,t_user.uname,t_user.uphone,t_post.post_title,
                    t_post.post_type,t_banned_work.b_case FROM t_post 
                    LEFT JOIN t_user ON t_user.uid=t_post.uid
                    LEFT JOIN t_banned_work ON t_post.post_id=t_banned_work.post_id
                    WHERE t_post.post_status='0'AND t_banned_work.b_time< NOW() - INTERVAL 7 DAY`,
        updateBanned:`UPDATE t_post SET post_status='1' where post_id=?;
                    delete FROM t_banned_work WHERE post_id=?`
    },
    t_banned_user:{
        selectUser:`SELECT t_user.uid,t_banned_user.bu_id,t_user.uphone,t_user.uname,t_user.imageUrl,DATE_FORMAT(t_banned_user.bannedtime, '%Y-%m-%d %H:%i:%s') AS bannedtime,
                DATE_FORMAT(t_banned_user.longtime, '%Y-%m-%d %H:%i:%s') AS longtime,
                CASE WHEN t_user.ustatus ='1' THEN '已解封' WHEN t_user.ustatus ='0' THEN '封禁 ' END AS ustatus
                FROM t_banned_user
                LEFT JOIN t_user ON t_user.uid=t_banned_user.uid`,
        insertBannedUser:`INSERT INTO t_banned_user(uid,bannedtime,longtime,bu_case) VALUES(?,?,?,?);
                UPDATE t_user SET ustatus='0' where uid=?;
                INSERT INTO t_messages(m_content,send_id,send_time,reception_id) VALUES(?,?,?,?);`,
        liftedBannedUser:`UPDATE t_user SET ustatus='1' where uid=?;
                INSERT INTO t_messages(m_content,send_id,send_time,reception_id) VALUES(?,?,?,?);`,
        deleteBannedUser:`delete from t_banned_user where bu_id=? `
    },
   t_messages: {
    selectMessage: `select t_messages.mid,t_messages.m_content,DATE_FORMAT(t_messages.send_time, '%Y-%m-%d %H:%i:%s') AS send_time,t_user.uname,t_user.uphone from t_messages 
    LEFT JOIN t_user ON t_user.uid=t_messages.reception_id where t_messages.send_id=? order by send_time desc LIMIT ?,5;
    select count(t_messages.mid) as sCount from t_messages LEFT JOIN t_user ON t_user.uid=t_messages.reception_id where t_messages.send_id=?;
    select t_messages.mid,t_messages.m_content,DATE_FORMAT(t_messages.send_time, '%Y-%m-%d %H:%i:%s') AS send_time,DATE_FORMAT(t_messages.reception_time, '%Y-%m-%d %H:%i:%s') AS reception_time,t_user.uname,t_user.uphone from t_messages 
    LEFT JOIN t_user ON t_user.uid=t_messages.send_id where t_messages.reception_id=? order by send_time desc LIMIT ?,5;
    select count(t_messages.mid) as rCount from t_messages LEFT JOIN t_user ON t_user.uid=t_messages.send_id where t_messages.reception_id=? `,
    updateMessage: `update t_messages set reception_time=? where mid=? `
  }

}