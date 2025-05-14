<template>
    <div>
        <el-aside width="200px">
        <div class="block"
          style="margin-top: 30px;margin-bottom: -20px; line-height: 20px; height: 150px;display: flex;flex-direction: column; justify-content: center; align-items: center;">
          <img v-if="userMessage.imageUrl==null" :src="circleUrl" alt="" width="50">
          <img v-else :src="'http://localhost:3000/images/' + userMessage.imageUrl" alt="" width="50"><br>
          <span>{{ userMessage.uname }}</span>
        </div>
        <el-menu default-active="1" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose"
          @select="handleSelect">

          <el-menu-item index="1">
            <i class="el-icon-s-data"></i>
            <span class="navName">后台首页</span>
          </el-menu-item>

          <el-submenu index="2">
            <template slot="title">
              <i class="el-icon-s-order"></i>
              <span class="navName">作品</span>
            </template>
            <el-menu-item-group>
              <template slot="title">用户作品</template>
              <el-menu-item index="2-1">最新发布</el-menu-item>
              <el-menu-item index="2-2">历史发布</el-menu-item>
              <el-menu-item index="2-3">问题发布</el-menu-item>
            </el-menu-item-group>
            <el-menu-item-group>
              <template slot="title">管理员作品</template>
              <el-menu-item index="2-4">发布作品</el-menu-item>
              <el-menu-item index="2-5">管理作品</el-menu-item>
            </el-menu-item-group>
          </el-submenu>

          <el-submenu index="3">
            <template slot="title">
              <i class="el-icon-user-solid"></i>
              <span class="navName">用户</span>
            </template>
            <el-menu-item-group>
              <el-menu-item index="3-1">用户</el-menu-item>
            </el-menu-item-group>
            <el-menu-item-group>
              <el-menu-item index="3-2">封禁用户</el-menu-item>
            </el-menu-item-group>
          </el-submenu>

          <el-menu-item index="4">
            <i class="el-icon-s-comment"></i>
            <span class="navName">信息</span>
          </el-menu-item>

          <el-menu-item index="5">
            <i class="el-icon-s-tools"></i>
            <span class="navName">退出登录</span>
          </el-menu-item>
        </el-menu>
      </el-aside>
    </div>
</template>
<script>
export default {
    data(){
        return{
            circleUrl: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png",
        }
    },
    methods:{
    handleSelect(key) {
    //   console.log(key);
      this.$emit("changeIndex",key)
    //   this.currentIndex=key
    },
    handleOpen(key, keyPath) {
      console.log(key);
    },
    handleClose(key, keyPath) {
      console.log(key, keyPath);
    }
    },
    props:["userMessage"],
}


</script>
<style scoped>
.navName {
  font-size: large;
}

.el-menu-vertical-demo {
  /* position: absolute;
  top: 50px; */
}

.el-menu {
  margin-top: 0px;
  
}

.el-aside {
  /* background-color: #D3DCE6; */
  color: #333;
  text-align: center;
  line-height: 200px;
  margin-right: 10px;
  height: 700px;
}

</style>