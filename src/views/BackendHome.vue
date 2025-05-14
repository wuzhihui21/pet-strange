<template>
  <div class="home" style="height: 100%;">
    <el-container height="100%">
      <!-- <el-aside width="200px">
        <div class="block"
          style="margin-top: 30px;margin-bottom: -20px; line-height: 20px; height: 150px;display: flex;flex-direction: column; justify-content: center; align-items: center;">
          <img :src="circleUrl" alt="" width="50"><br>
          <span>管理员</span>
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
      </el-aside> -->
      <Aside @changeIndex="handleAsideIndex" :userMessage='user'></Aside>
      <el-container direction="vertical" id="fff">
        <!-- <Header /> -->
        <Main id="bbb">
          <!-- <component :is="currentComponent"></component> -->
          <div v-if="currentIndex === '1' ">
            <MainHome></MainHome>
          </div>
          <div v-else-if="currentIndex === '2-1'">
            <LatestPublish></LatestPublish>
          </div>
          <div v-else-if="currentIndex === '2-2'">
            <HistoricalPublish></HistoricalPublish>
          </div>
          <div v-else-if="currentIndex === '2-3'">
            <RevokePublish></RevokePublish>
          </div>
          <div v-else-if="currentIndex === '2-4'">
            <WorkPublish></WorkPublish>
          </div>
          <div v-else-if="currentIndex === '2-5'">
            <ManageWork></ManageWork>
          </div>
          <div v-else-if="currentIndex === '3-1'">
            <UserMessages></UserMessages>
          </div>
          <div v-else-if="currentIndex === '3-2'">
            <BannedUsers></BannedUsers>
          </div>
          <div v-else-if="currentIndex === '4'">
            <Messages></Messages>
          </div>
        </Main>
        <Footer id="sss" />
      </el-container>
    </el-container>
  </div>
</template>

<script>
import MainHome from '@/components/BackendComponents/BHComponents/main.vue';
import Header from '@/components/BackendComponents/BHComponents/header.vue';
import Footer from '@/components/BackendComponents/BHComponents/footer.vue';
import Aside from '@/components/BackendComponents/BHComponents/aside.vue';
import LatestPublish from '@/components/BackendComponents/workComponents/latestPublish.vue';
import HistoricalPublish from '@/components/BackendComponents/workComponents/historicalPublish.vue';
import RevokePublish from '@/components/BackendComponents/workComponents/revokePublish.vue';
import WorkPublish from '@/components/BackendComponents/workComponents/workPublish.vue';
import ManageWork from '@/components/BackendComponents/workComponents/manageWork.vue';
import UserMessages from '@/components/BackendComponents/usersComponents/userMessages.vue';
import BannedUsers from '@/components/BackendComponents/usersComponents/bannedUsers.vue';
import Messages from '@/components/BackendComponents/messageComponents/messages.vue';

import { mapMutations,mapState } from 'vuex';

export default {
  data() {
    return {
      currentComponent: 'MainHome',
      currentIndex: "1",
    }
  },
  components: {
    MainHome,
    Header, Footer,Aside,
    LatestPublish, HistoricalPublish, RevokePublish,WorkPublish,ManageWork,
    UserMessages, BannedUsers,
    Messages
  },
  methods: {
    ...mapMutations('user',["deleteUser"]),
    handleAsideIndex(data){
      console.log(data);
      this.currentIndex=data 
      if(data=='5'){
        this.deleteUser()
        this.$router.push("/")
      }     
    }
  },
  computed:{
    ...mapState('user',['user'])
  },
  created(){
    if(this.user==null){
      alert("未登录，请先登录")
      this.$router.push("/loginPage")
    }
  }
}
</script>
<style>
.navName {
  font-size: large;
}
#fff{
  display: flex;
  flex-direction: column; 
  min-height: 100%;
}
#bbb{
  flex: 1;
}
#sss{

}

.el-menu-vertical-demo {
  position: absolute;
  top: 50px;
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
}

.el-container {
  direction: 'vertical';
}

body>.el-container {
  margin-bottom: 40px;
}

.el-container .el-aside {
  line-height: 320px;
}
</style>
