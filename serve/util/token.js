/**
 * 封装token的签发和解析函数
 * 安装第三方中间件：jsonwebtoken
 */

const jwt=require("jsonwebtoken");
//签名密钥(解析token时也要用同样的密钥)
let jwtSecret="jwt_secret"
module.exports={
    

    //签发token(即：生成token、创建token)
    setToken:(uaccount,uid)=>{
        return new Promise((resolve,reject)=>{
            //sign用密钥使用加密算法生成一个token
            const token=jwt.sign({uaccount:uaccount,uid:uid},jwtSecret,{expiresIn:"1h"//expiresIn表示token的过期时间，1h是1小时
                }) //algorithm表示算法，默认是HS256
            resolve(token);
        });

    },

    //解析token
    getToken:(token)=>{
        return new Promise((resolve,reject)=>{
            if(token){
                /**
                 * token使用.号分隔的字符串，分为3个部分。
                 * 第2个部分是载荷，即数据
                 * 解析token时要用同样的密钥
                 * 客户端手动添加token时加了“Bearer ”
                 */
                let info=jwt.verify(token.split(" ")[1],jwtSecret);
                resolve(info);
            }else{//token不存在
                reject({code:601,msg:"token为空"})
            }
        })
    }

}

