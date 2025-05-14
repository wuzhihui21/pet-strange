<template>
    <div>
        <el-header>奇异怪宠后台管理首页</el-header>
        <!-- 统计数 -->
        <el-row :gutter="20">
            <el-col :span="6">
                <el-card class="box-card">
                    <h3>作品发布总数</h3>
                    <div>
                        <i class="el-icon-s-order" style="color: green"></i>
                        <span>{{ this.totalpost}}</span>
                    </div>
                </el-card>
            </el-col>
            <el-col :span="6">
                <el-card class="box-card">
                    <h3>累计用户数</h3>
                    <div>
                        <i class="el-icon-user-solid" style="color: green"></i>
                        <span>{{this.totaluser}}</span>
                    </div>
                </el-card>
            </el-col>
            <el-col :span="6">
                <el-card class="box-card">
                    <h3>近一周新增作品数</h3>
                    <div>
                        <i class="el-icon-s-order" style="color: red"></i>
                        <span>{{this.lastpost}}</span>
                    </div>
                </el-card>
            </el-col>
            <el-col :span="6">
                <el-card class="box-card">
                    <h3>近一周新增用户数</h3>
                    <div>
                        <i class="el-icon-user-solid" style="color: red"></i>
                        <span>{{this.lastuser}}</span>
                    </div>
                </el-card>
            </el-col>
        </el-row>
        <!-- 统计图 -->
        <el-row :gutter="20">
            <el-col :span="16">
                <el-card class="box-card">
                     <ColumnChart/>
                </el-card>
            </el-col>
            <el-col :span="8">
                <el-card class="box-card">
                    <WorkSectorChart/>
                </el-card>
                <el-card class="box-card"> 
                     <UserSectorChart/>
                </el-card>
            </el-col>
        </el-row>


    </div>
</template>
<script>
import ColumnChart from './charttsComponents/columnChart.vue';
import WorkSectorChart from './charttsComponents/workSectorChart.vue';
import UserSectorChart from './charttsComponents/userSectorChart.vue';
export default{
    data(){
        return{
            lastpost:null,
            lastuser:null,
            totalpost:null,
            totaluser:null,
            
        }
    },
    components:{
        ColumnChart,
        WorkSectorChart,
        UserSectorChart
    },
    mounted(){
        this.fetchData()
       
    },
    methods:{
        fetchData(){
            this.axios.get("/api/admin/getCount")
            .then(res=>{
                // console.log(res.data.data);
                this.totalpost=res.data.data.totalpost.totalpost
                this.totaluser=res.data.data.totaluser.totaluser
                this.lastpost=res.data.data.lastpost.lastpost
                this.lastuser=res.data.data.lastuser.lastuser
                // this.counts=res.data.data.counts; 
            })
        },
       
    }
}
</script>
<style>
.el-main {
    background-color: #E9EEF3;
    color: #333;
    text-align: center;
    line-height: 160px;
    width: 100%;
}
</style>