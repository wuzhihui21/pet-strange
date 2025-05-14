var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var cors =require("cors")

/**
 * 安装express-jwt,用来验证token
 * 查看express-jwt的版本号： npm list express-jwt
 */
var jwt=require("express-jwt")
var token=require("./util/token")


var adminRouter = require('./routes/admin')

var app = express();

/**
 * 使用express-jwt中间件,验证token是否失效(是否过期) ，并规定哪些路由不用验证token
 * 7以下版本用jwt(),7以上的版本用expressjwt()
 */
app.use(jwt.expressjwt({
  secret:"jwt_secret",  //签发、解析及验证token都使用同一个密钥
  algorithms:["HS256"]  //算法，签发和验证token使用的算法要一致，默认HS256
}).unless({//白名单
  path:["/","/users/login","/users/regist","/home",/^\/images\//,"/admin/login",/^\/admin\//]
}));

//使用拦截器，解析token,token由请求报文的"authorization"字段中
app.use((req,res,next)=>{
  let t=req.headers["authorization"];
  if(t){
    token.getToken(t).then((data)=>{
      req.data=data;
      return next();
    }).catch(err=>{
      return next();
    });
  }else{
    return next();
  }
});

//错误中间件：token失效时返回消息
app.use((err,req,res,next)=>{
  if(err.status==401){
    res.send({
      code:401,
      msg:"token失效"
    })
  }
});



// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(cors())

app.use('/admin',adminRouter)

// app.listen(3000,()=>{
//   console.log("服务器启动");
  
// })

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
