<template>
    <div>
        <el-header>奇异怪宠后台管理——问题发布</el-header>
        <el-tabs v-model="activeName">
            <el-tab-pane label="新封禁作品" name="first">
                <!-- 新封禁的作品列表：显示出近一日被管理员下架的作品 -->
                <el-table :data="tableData1" style="width: 100%" :default-sort="{ prop: 'date', order: 'descending' }">
                    <el-table-column prop="post_id" label="ID" sortable width="100">
                    </el-table-column>
                    <el-table-column prop="b_time" label="日期" sortable width="200">
                    </el-table-column>
                    <el-table-column prop="uname" label="用户名" sortable width="200">
                    </el-table-column>
                    <el-table-column prop="post_title" label="作品题目" width="300">
                    </el-table-column>
                    <el-table-column prop="post_type" label="作品类别" sortable width="100">
                    </el-table-column>
                    <el-table-column prop="b_case" label="封禁原因" sortable width="200">
                    </el-table-column>
                    <el-table-column fixed="right" label="操作" width="100">
                        <template slot-scope="scope">
                            <el-button @click="showDetail(scope.row)" type="text" size="small">查看</el-button>
                            <el-button @click="liftedBanned(scope.row.post_id,scope.row.uid)" type="text" size="small">解封</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-tab-pane>
            <el-tab-pane label="重新发布审核" name="second">
                <!-- 重新发布的封禁作品列表：显示出被用户修改后请求重新发布的作品，管理员可以解除其封禁或重新提醒修改 -->
                <el-table :data="tableData2" style="width: 100%" :default-sort="{ prop: 'date', order: 'descending' }">
                    <el-table-column prop="post_id" label="ID" sortable width="100">
                    </el-table-column>
                    <el-table-column prop="b_time" label="日期" sortable width="200">
                    </el-table-column>
                    <el-table-column prop="uname" label="用户名" sortable width="200">
                    </el-table-column>
                    <el-table-column prop="post_title" label="作品题目" width="300">
                    </el-table-column>
                    <el-table-column prop="post_type" label="作品类别" sortable width="100">
                    </el-table-column>
                    <el-table-column prop="b_case" label="封禁原因" sortable width="200">
                    </el-table-column>
                    <el-table-column fixed="right" label="操作" width="100">
                        <template slot-scope="scope">
                            <el-button @click=" showDetail(scope.row)" type="text" size="small">查看</el-button>
                            <el-button @click="liftedBanned(scope.row.post_id,scope.row.uid)" type="text" size="small">解封</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-tab-pane>
            <el-tab-pane label="旧封禁作品" name="third">
                <!-- 旧封禁的作品列表：显示出近一日之前被管理员下架的作品，管理员可对长久未修改的作品进行删除其作品 -->
                <el-table :data="tableData3" style="width: 100%" :default-sort="{ prop: 'date', order: 'descending' }">
                    <el-table-column prop="post_id" label="ID" sortable width="100">
                    </el-table-column>
                    <el-table-column prop="b_time" label="封禁时间" sortable width="200">
                    </el-table-column>
                    <el-table-column prop="uname" label="用户名" sortable width="200">
                    </el-table-column>
                    <el-table-column prop="post_title" label="作品题目" width="300">
                    </el-table-column>
                    <el-table-column prop="post_type" label="作品类别" sortable width="100">
                    </el-table-column>
                    <el-table-column prop="b_case" label="封禁原因" sortable width="200">
                    </el-table-column>
                    <el-table-column fixed="right" label="操作" width="100">
                        <template slot-scope="scope">
                            <el-button @click="showDetail(scope.row)" type="text" size="small">查看</el-button>
                            <el-button @click="deletePost(scope.row.post_id,scope.row.uid)" type="text" size="small">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </el-tab-pane>
        </el-tabs>
        <div v-if="isShow" id="modal" @click="closeShow">
            <Transition name="bounce">
                <div @click.stop>
                    <el-card id="detailCard">
                        <el-row>
                            <el-col :span="12">
                                <el-image
                                    :src="'http://localhost:3000/images/' + this.postDetail[0].post_image"></el-image>
                            </el-col>
                            <el-col :span="12" style="padding-left: 20px;">
                                <!-- 作者 -->
                                <el-row type="flex" align="middle">
                                    <el-col>
                                        <el-row type="flex" align="middle">
                                            <el-avatar v-if="this.postDetail[0].imageUrl!==null" size="large" :src="'http://localhost:3000/images/' + this.postDetail[0].imageUrl"></el-avatar>
                                            <el-avatar v-else size="large" src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"></el-avatar>
                                            <span>{{ this.postDetail[0].uname }}</span>
                                        </el-row>
                                    </el-col>
                                    <el-col></el-col>
                                    <el-col v-for="(item, index) in this.postDetail" :key="index">
                                        <button @click="liftedBanned(item.post_id,item.uid)"
                                            style="background-color: red; width: 80px;height: 40px; border-radius: 50px;box-shadow: none;">解封</button>
                                    </el-col>
                                </el-row>

                                <div>
                                    <!-- 标题 -->
                                    <el-row style="padding-top: 20px;">
                                        <span style="font-weight: bolder;font-size: larger;">{{
                                            this.postDetail[0].post_title
                                            }}</span>
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
                                            共{{ this.commentN[0].commentNum }}条评论
                                        </el-row>

                                        <div v-if="this.commentN[0].commentNum != 0">
                                            <div v-for="(item, index) in this.comments" :key="index">
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
                                                            <el-col v-if="item.uname == null" :span="6"> {{ item.uname
                                                                }}</el-col>
                                                            <el-col v-else :span="6"> {{ item.uphone }}</el-col>
                                                            <el-col :span="18" style="text-align: right;">点赞</el-col>
                                                        </el-row>
                                                        <el-row>{{ item.c_content }}</el-row>
                                                        <el-row>
                                                            <el-row :span="24"
                                                                style="display: flex; justify-content: space-between;">
                                                                <el-col :span="18"> {{ item.c_time }}</el-col>
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
    </div>
</template>
<script>
import { mapState } from 'vuex';
export default {
    data() {
        return {
            tableData1: null,
            tableData2: null,
            tableData3: null,
            activeName: 'first',
            isShow: false,
            postDetail: null,
            comments: null,
            commentN: null,
        }
    },
    computed: {
        ...mapState('user', ['user'])
    },
    methods: {
        getData() {
            this.axios.get("/api/admin/getBanned").then(res => {
                if (res.data.code == 200) {
                    this.tableData1 = res.data.data[0];
                    this.tableData2 = res.data.data[1];
                    this.tableData3 = res.data.data[2];
                    // console.log(this.tableData1);

                }
            })
        },
        showDetail(row) {
            // console.log("打开");
            // console.log(row);
            this.axios.get(`/api/admin/postDetail?post_id=${row.post_id}`).then(res => {
                if (res.data.code = 200) {
                    this.postDetail = res.data.data.detail
                    this.commentN = res.data.data.comment
                    this.comments = res.data.data.comments
                    // console.log(this.postDetail);

                    this.isShow = true

                }
            })

        },
        closeShow() {
            // console.log("关闭");
            this.axios.get(`/api/admin/handleAudit?pid=${this.postDetail[0].post_id}`).then(res => {
                if (res.data.code == 200) {
                    this.isShow = false
                }
            })

        },
        liftedBanned(pid,uid) {
            // console.log(pid);

            this.$confirm('确定解除封禁', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.axios.get(`/api/admin/liftedBanned?post_id=${pid}&senduid=${this.user.uid}&receptionuid=${uid}`).then(res => {
                    if (res.data.code == 200) {
                        this.$message({
                            type: 'success',
                            message: '解除成功!'
                        });
                        this.getData()
                    }
                })
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消解除封禁'
                });
            });

        },
        deletePost(pid) {
            this.$confirm('确定删除封禁记录吗', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.axios.get(`/api/admin/deleteWork?post_id=${pid}`).then(res => {
                    if (res.data.code == 200) {
                        this.$message({
                            type: 'success',
                            message: '删除成功!'
                        });
                        this.getData()
                    } else {
                        this.$message({
                            type: 'info',
                            message: '删除失败'
                        });
                    }
                })
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消删除'
                });
            });

        }
    },
    created() {
        this.getData()
    }
}
</script>
<style>
#detailCard {
    background-color:  white;
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
.el-header {
    color: #333;
  font-weight: bold;
  font-size:larger;
  text-align: center;
  line-height: 60px;
  width: 100%;
}
</style>