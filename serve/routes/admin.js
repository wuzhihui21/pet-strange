var express = require('express');
var router = express.Router();
const multer=require("multer");
var controllerAdmin=require("../controller/admin")

//配置multer的存储选项
let storage=multer.diskStorage({
  destination:(req,file,callback)=>{
      callback(null,"public/images");
  },
  filename:(req,file,callback)=>{
      callback(null,Date.now()+file.originalname);
  }
});

let upload=multer({
  storage:storage
});
//统计数据
router.get("/getCount",(req,res)=>{
    controllerAdmin.statistics(req,res)
})
//登录
router.post("/login",(req,res)=>{
  controllerAdmin.adminlogin(req,res)
})
//查询条形统计图数据
router.get("/columnCharDate",(req,res)=>{
  // console.log(111);
  controllerAdmin.columDate(req,res)
})
//查询作品扇形统计图数据
router.get("/workSectorCharDate",(req,res)=>{
  controllerAdmin.workSectorData(req,res)
})
//查询用品扇形统计图数据
router.get("/userSectorCharDate",(req,res)=>{
  controllerAdmin.userSectorData(req,res)
})
//请求获取最新发布
router.get("/getLatestPublish",(req,res)=>{
  // console.log(111);
  controllerAdmin.getLatestDate(req,res)
})
//请求获取作品详情
router.get("/postDetail",(req,res)=>{
  // console.log(111);
  controllerAdmin.getdetail(req,res)
})
//请求获取历史发布
router.get("/getHistoryWork",(req,res)=>{
  // console.log(111);
  controllerAdmin.getHistorial(req,res)
})
//请求封禁作品
router.post("/handleBanned",(req,res)=>{
  // console.log(111);
  controllerAdmin.handleBanned(req,res)
})
//处理审核
router.get("/handleAudit",(req,res)=>{
  // console.log(111);
  controllerAdmin.handleAudit(req,res)
})
//请求获取封禁作品
router.get("/getBanned",(req,res)=>{
  // console.log(111);
  controllerAdmin.getBanned(req,res)
})
//请求解封操作
router.get("/liftedBanned",(req,res)=>{
  // console.log(111);
  controllerAdmin.lifted(req,res)
})
//请求获取所有用户信息
router.get("/getUser",(req,res)=>{
  // console.log(111);
  controllerAdmin.getUser(req,res)
})
//修改用户信息
router.post("/edmitUser",upload.single('files'),(req,res)=>{
  // console.log(111);
  // console.log(req.body);
  // console.log(req.body.uname);
  // console.log(req.file);
  controllerAdmin.edmitUser(req,res)
})
//获取封禁用户信息
router.get("/getBannedUser",(req,res)=>{
  // console.log(111);
  controllerAdmin.getBannedUser(req,res)
})
//新增作品
router.post("/addPost",upload.single('files'),(req,res)=>{
  // console.log(111);
  controllerAdmin.addPost(req,res)
})
//管理作品
router.get('/getUserWork',(req,res)=>{
  controllerAdmin.getUserWorkDate(req,res)
})
//删除作品
router.get('/deleteWork',(req,res)=>{
  controllerAdmin.deleteWork(req,res)
})
//封禁用户
router.post('/handleBannedUser',(req,res)=>{
  controllerAdmin.bannedUser(req,res)
})
//解除封禁用户
router.get('/liftecBannedUser',(req,res)=>{
  controllerAdmin.liftecBannedUser(req,res)
})
//删除封禁用户记录
router.get('/deleteBannedUser',(req,res)=>{
  controllerAdmin.deleteBannedUser(req,res)
})
//点赞作品
router.get('/dolike',(req,res)=>{
  controllerAdmin.dolike(req,res)
})
//取消点赞作品
router.get('/cancellike',(req,res)=>{
  controllerAdmin.cancellike(req,res)
})
//管理员修改自己作品
router.post('/edmitWork',upload.single('files'),(req,res)=>{
  controllerAdmin.edmitWork(req,res)
})
//获取消息页面数据
router.get('/getMessage',(req,res)=>{
  controllerAdmin.getMessages(req,res)
})
//消息已读操作
router.get('/readMessage',(req,res)=>{
  controllerAdmin.handleReadMessages(req,res)
})
//消息上一页
router.get('/prevPage',(req,res)=>{
  controllerAdmin.prevPage(req,res)
})
//消息下一页
router.get('/nextPage',(req,res)=>{
  controllerAdmin.nextPage(req,res)
})
module.exports = router;