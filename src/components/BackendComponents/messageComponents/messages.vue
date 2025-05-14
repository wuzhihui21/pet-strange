<template>
    <div>
        <el-header>奇异怪宠后台管理——消息</el-header>
        <el-tabs type="border-card">

            <el-tab-pane label="发送消息">
                <el-card class="box-card" v-for="(item, index) in this.sendData" :key="index">
                    <div slot="header" class="clearfix">
                        <div style="width: 45%;">
                            <span>{{ item.uname }}</span><br>
                            <div style="float: left;"><span style="color:gray;">{{ item.send_time }}</span></div>
                        </div>
                    </div>
                    <div>
                        <span>{{ item.m_content }}</span>
                    </div>
                </el-card>
                <div style="text-align: center;">
                  <el-button style="margin-left: 20px;margin-right: 20px;" type="primary" :disabled="page===1" round @click="prevPage()">上一页</el-button> 
                  <span>当前：{{ this.page }} 页</span> 
                  <el-button style="margin-left: 20px;margin-right: 20px;" type="primary" :disabled="page===this.pages" round @click="nextPage()">下一页</el-button>
                  <span>总共：{{ this.pages  }} 页</span>
                </div>
            </el-tab-pane>
            <el-tab-pane label="接受消息">
                <el-card class="box-card" v-for="(item, index) in this.receptionData" :key="index">
                    <div slot="header" class="clearfix">
                        <div style="width: 45%;">
                            <span>{{ item.uname }}</span><br>
                            <div style="float: left;"><span style="color:gray;">{{ item.send_time }}</span></div>
                        </div>
                        <el-button v-if="item.reception_time == null" @click="readMessage(item.mid)"
                            style="float: right; padding: 3px 0" type="text">未读</el-button>
                        <el-button v-else style="float: right; padding: 3px 0" type="text">已读</el-button>
                    </div>
                    <div>
                        <span>{{ item.m_content }}</span>
                    </div>
                </el-card>
            </el-tab-pane>
        </el-tabs>
    </div>
</template>
<script>
import { mapState } from 'vuex';
export default {
    data() {
        return {
            sendData: null,
            receptionData: null,
            sendCount:null,
            receptionCount:null,
            page:1,
            pages:null
        }
    },
    computed: {
        ...mapState('user', ['user'])
    },
    methods: {
        getData() {
            this.axios.get(`/api/admin/getMessage?uid=${this.user.uid}`).then(res => {
                if (res.data.code == 200) {
                    this.sendData = res.data.data.sendData;
                    this.receptionData = res.data.data.receptionData;
                    this.sendCount = res.data.data.sendCount;
                    this.receptionCount = res.data.data.receptionCount;
                    this.pages=Math.ceil(this.sendCount/5)
                    // console.log(this.sendData);
                    // console.log(this.receptionData);
                    // console.log(this.sendCount);
                }
            })
        },
        readMessage(data) {
            this.axios.get(`/api/admin/readMessage?mid=${data}`).then(res => {
                if (res.data.code == 200) {
                    this.getData()
                }
            })
        },
        prevPage(){
            this.axios.get(`/api/admin/prevPage?page=${this.page}&uid=${this.user.uid}`).then(res=>{
                if(res.data.code == 200){
                    this.sendData = res.data.data.sendData;
                    this.receptionData = res.data.data.receptionData;
                    this.sendCount = res.data.data.sendCount;
                    this.receptionCount = res.data.data.receptionCount;
                    this.page=this.page-1
                }
            })
        },
        nextPage(){
            this.axios.get(`/api/admin/nextPage?page=${this.page}&uid=${this.user.uid}`).then(res=>{
                if(res.data.code == 200){
                    this.sendData = res.data.data.sendData;
                    this.receptionData = res.data.data.receptionData;
                    this.sendCount = res.data.data.sendCount;
                    this.receptionCount = res.data.data.receptionCount;
                    this.page=this.page+1;
                    console.log(this.receptionData);
                    
                }
            })
        }
    },
    created() {
        this.getData()
    }
}
</script>
<style scoped>
.el-header {
    color: #333;
    font-weight: bold;
    font-size: larger;
    text-align: center;
    line-height: 60px;
    width: 100%;
}
</style>