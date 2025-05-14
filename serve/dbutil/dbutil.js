/**
 * 封装数据库的公共操作
 * 1.安装mysql或mysql2
 * 2.导入
 * 3.创建连接池
 * 4.封装公用函数,并暴露
 */
const mysql=require("mysql");
const config=require("../config");
const pool=mysql.createPool(config.db);

module.exports={
    query:(sql,params,callback)=>{
        pool.getConnection((err1,conn)=>{
             if(err1){
                return callback(err1,null);
             }
            conn.query(sql,params,(err2,results)=>{
                if(err2){
                   callback(err2,null); 
                }
                //执行成功返回results
                callback(null,results);
                //释放连接
                conn.release();
            });
        });
    }
}
