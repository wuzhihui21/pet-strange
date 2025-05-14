//用户的状态数据
const state={
    user:null
}

//同步操作state的方法
const mutations={
   //登录成功时，将当前用户对象保存到state的user
   saveUser(state,user){
     state.user=user;
   },

   //退出登录时，删除state的user
   deleteUser(state){
      state.user=null;
   }
}

export default{
    namespaced:true, //使用名称空间
    state,
    mutations
}
