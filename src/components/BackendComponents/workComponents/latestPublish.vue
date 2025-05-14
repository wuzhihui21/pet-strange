<template>
  <div>
    <el-header>奇异怪宠后台管理用户——最新发布</el-header>
    <el-row>
    <span v-if="this.latestDate.length==0">没有用户发布新作品哦！！！</span>
      <!-- 查询出最近一天发布的作品，卡片显示出基本信息，点击卡片查看作品详情 -->
      <el-col :span="5" v-for="(item,o) in this.latestDate" :key="o">
        <div @click="showDetail(item.post_id)">
          <el-card style="position: relative; background-color: aqua;height: 300px;">
            <el-image :src="'http://localhost:3000/images/' + item.post_image" style="padding: 0;margin: 0; width: 100%;" width="100%" height="300px" fit="cover"></el-image>
            <div>
              <span v-if="item.uname!=null">{{ item.uname }}</span><span v-else>{{ item.uphone }}</span><br>
              <span>{{ item.post_title }}</span><br>
              <span>{{ item.post_time }}</span>
              <!-- <div @click.stop style="position: absolute;bottom: 0; right: 0;">
                <span >
                <svg t="1729556638978" @click="doLike(o,item.post_id,item.post_like)" :class="{ 'selected' : selectedCardIndex=== o}" viewBox="0 0 1024 1024" version="1.1"
                  xmlns="http://www.w3.org/2000/svg" p-id="6915" width="32" height="32">
                  <path
                    d="M533.504 268.288q33.792-41.984 71.68-75.776 32.768-27.648 74.24-50.176t86.528-19.456q63.488 5.12 105.984 30.208t67.584 63.488 34.304 87.04 6.144 99.84-17.92 97.792-36.864 87.04-48.64 74.752-53.248 61.952q-40.96 41.984-85.504 78.336t-84.992 62.464-73.728 41.472-51.712 15.36q-20.48 1.024-52.224-14.336t-69.632-41.472-79.872-61.952-82.944-75.776q-26.624-25.6-57.344-59.392t-57.856-74.24-46.592-87.552-21.504-100.352 11.264-99.84 39.936-83.456 65.536-61.952 88.064-35.328q24.576-5.12 49.152-1.536t48.128 12.288 45.056 22.016 40.96 27.648q45.056 33.792 86.016 80.896z"
                    p-id="6916" >
                  </path>
                </svg>
                {{ item.post_like}}
              </span>
            
              </div> -->
             

            </div>
          </el-card>
        </div>
      </el-col>
    </el-row>
    <!-- 宠物详情 -->
    <div v-if="isShow" id="modal" @click="closeShow">
      <Transition name="bounce">
        <div @click.stop>
          <el-card id="detailCard">
            <el-row>
              <el-col :span="12">
                <el-image :src="'http://localhost:3000/images/' +this.postDetail[0].post_image"></el-image>
              </el-col>
              <el-col :span="12" style="padding-left: 20px;">
                <!-- 作者 -->
                <el-row type="flex" align="middle">
                  <el-col>
                    <el-row type="flex" align="middle">
                      <el-avatar size="large"
                        src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"></el-avatar>
                      <span>{{ this.postDetail[0].uname }}</span>
                    </el-row>
                  </el-col>
                  <el-col></el-col>
                  <el-col>
                    <button @click="openShow2"
                      style="background-color: red; width: 80px;height: 40px; border-radius: 50px;box-shadow: none;">封禁</button>
                  </el-col>
                </el-row>

                <div>
                  <!-- 标题 -->
                  <el-row style="padding-top: 20px;">
                    <span style="font-weight: bolder;font-size: larger;">{{ this.postDetail[0].post_title }}</span>
                  </el-row>
                  <!-- 正文 -->
                  <el-row style="padding-top: 10px;">
                    {{ this.postDetail[0].post_describe }}
                  </el-row>
                  <!-- 时间 -->
                  <el-row style="padding-top: 10px;">
                    {{ this.postDetail[0].post_time }}
                    <div style="background-color: black; border-bottom: 1px solid;"></div>
                  </el-row>
                  <!-- 评论 -->
                  <div>
                    <el-row style="padding-top: 10px;padding-bottom: 10px;">
                      共{{this.commentN[0].commentNum}}条评论
                    </el-row>
                    
                      <div v-if="this.commentN[0].commentNum!=0">
                        <div v-for="(item,index) in this.comments" :key="index">
                                                <el-row :span="24">
                                                <el-col :span="4">
                                                    <el-avatar size="medium"
                                                        src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"></el-avatar>
                                                        <!-- <el-avatar v-if="this.comments[0].imageUrl=null" size="medium"
                                                        src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"></el-avatar>
                                                   -->
                                                </el-col>
                                                <el-col :span="20">
                                                    <el-row :span="24"
                                                        style="display: flex; justify-content: space-between;">
                                                        <el-col v-if=" item.uname==null" :span="6"> {{ item.uname }}</el-col>
                                                        <el-col v-else :span="6"> {{ item.uphone }}</el-col>
                                                        <el-col :span="18" style="text-align: right;">点赞</el-col>
                                                    </el-row>
                                                    <el-row>{{  item.c_content }}</el-row>
                                                    <el-row>
                                                        <el-row :span="24"
                                                            style="display: flex; justify-content: space-between;">
                                                            <el-col :span="18"> {{ item.c_time}}</el-col>
                                                            <el-col :span="6" style="text-align: right;">回复</el-col>
                                                        </el-row>
                                                    </el-row>
                                                </el-col>
                                            </el-row>
                                            </div>
                    </div>
                    
                  </div>
                </div>
              </el-col>
            </el-row>
          </el-card>
        </div>
      </Transition>
    </div>
    <!-- 封禁 -->
    
    <div v-if="isRevokeShow" id="fengjin" @click="colseShow2">
      <!-- <el-button :plain="true" @click="open">封禁成功</el-button> -->
      <Transition name="bounce">
        <div @click.stop>
          <el-card id="fengjin2">
            <el-radio-group v-model="bannedRadio" v-removeAriaHidden>
            <el-radio  label="作品使用了未经授权的内容，侵犯了他人的版权">作品使用了未经授权的内容，侵犯了他人的版权</el-radio>
            <el-radio  label="作品内容可能包含虚假信息、不当行为或错误观念">作品内容可能包含虚假信息、不当行为或错误观念</el-radio>
            <el-radio  label="作品内容挑战公众认知底线或涉及法律风险">作品内容挑战公众认知底线或涉及法律风险</el-radio>
            <el-radio  label="作品内容涉及敏感或争议性话题">作品内容涉及敏感或争议性话题</el-radio>
            <el-radio  label="作品发布不良信息，如自杀自残、虐待动物等，可能对社会造成不良影响">作品发布不良信息，如自杀自残、虐待动物等，可能对社会造成不良影响</el-radio>
          </el-radio-group>
            <el-button type="primary" @click="submitBannedCase">确认</el-button>
          </el-card>
        </div>
      </Transition>
    </div>
  </div>
</template>
<script>
import { mapState } from 'vuex';
export default {
  
  data() {
    return {
      currentDate: new Date(),
      isShow: false,
      isActive:false,
      isRevokeShow:false,
      selectedCardIndex:null,
      latestDate:[],
      postDetail: null,
      comments: null,
      commentN: null,
      newData:null,
      bannedRadio:null
    };
  },
  computed:{
    ...mapState('user',['user'])
  },
  methods: {
    getData(){
      this.axios.get("/api/admin/getLatestPublish").then(res=>{
      if(res.data.code==200){
        // console.log(res.data.data);
        this.latestDate=res.data.data
        // console.log(1111);
        console.log(this.latestDate);
        // this.newData=this.latestDate.map(item=>{
        // return{
        //   ...item,
        //   likeNum:Number(item.post_like)
        // }
      // })
    }
  })
    },
    showDetail(pid) {
      // console.log("打开");
      // console.log(pid);
      this.axios.get(`/api/admin/postDetail?post_id=${pid}`).then(res=>{
        if(res.data.code=200){
          this.postDetail = res.data.data.detail
          this.commentN=res.data.data.comment
          this.comments = res.data.data.comments
          this.isShow = true
        }
      })
      
    },
    closeShow() {
      // console.log("关闭");
      this.axios.get(`/api/admin/handleAudit?pid=${this.postDetail[0].post_id}`).then(res=>{
        if(res.data.code==200){
          this.isShow = false
          this.getData()
        }
      })
      
    },
    openShow2(){
      this.isRevokeShow=true
    },
    colseShow2(){
      this.isRevokeShow=false
    },
    // doLike(o,pid,num){
    //   console.log(o);
    //   console.log(pid,num);
    //   this.isActive=!this.isActive
    //   if(this.isActive){
    //     this.axios.get(`/api/admin/dolike?pid=${pid}&likenum=${num}`).then(res=>{
    //       if(res.data.code==200){
    //         this.selectedCardIndex=o
    //         console.log(res.data.data);
    //         this.latestDate[o].post_like=res.data.data[0].post_like
    //       }
    //     })
    //   }else{
    //     this.axios.get(`/api/admin/cancellike?pid=${pid}&likenum=${num}`).then(res=>{
    //       if(res.data.code==200){
    //         this.selectedCardIndex=null
    //         console.log(res.data.data);
    //         this.latestDate[o].post_like=res.data.data[0].post_like
    //       }
    //     })
        
    //   }
    //   console.log(this.isActive);
    // },
    
    message(){
      this.$message({
        message:"封禁成功",
        duration:2000,
        type: 'success'
      });
    },
    submitBannedCase(){
      // console.log(11111);
      // console.log(this.bannedRadio);
      // console.log(this.postDetail[0].post_id);
      this.axios.post("/api/admin/handleBanned",{data:{
        case:this.bannedRadio,
        pid:this.postDetail[0].post_id,
        receptionuid:this.postDetail[0].uid,
        senduid:this.user.uid
      }
      }).then(res=>{
        if(res.data.code==200){
          this.message();
          this.bannedRadio=null;
          this.isRevokeShow=false;
          this.getData()
        }
      })
    },
    
  },
  created(){
    this.getData()
  },
 
}

</script>
<style scoped>
#detailCard {
  background-color: rgb(32, 154, 81);
  width: 800px;
  height: 500px;
}

#modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(103, 103, 99, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 999;
}
#fengjin2{
  background-color: rgb(35, 57, 224);
  width: 400px;
  height: 300px;
}
#fengjin{
  position: fixed;
  top: 0;
  left: 0;
  right: 100px;
  bottom: 70px;
  /* background: rgba(103, 103, 99, 0.5); */
  display: flex;
  justify-content:right;
  padding: 100px;
  align-items: center;
  z-index: 999;
}
svg{
  fill:aliceblue
}
svg.selected{
  fill: crimson;
}
</style>