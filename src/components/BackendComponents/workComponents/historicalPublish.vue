<template>
    <div>
        <el-header>奇异怪宠后台管理用户——历史发布</el-header>
        <el-row>
            <!--以表单的形式显示 查询以往用户发布的能够显示给用户查看的所有作品 -->
            <el-table :data="tableData" style="width: 100%" :default-sort="{ prop: 'date', order: 'descending' }">
                <el-table-column prop="post_id" label="ID" sortable width="100">
                </el-table-column>
                <el-table-column prop="time" label="日期" sortable width="200">
                </el-table-column>
                <el-table-column prop="uname" label="用户名" sortable width="200">
                </el-table-column>
                <el-table-column prop="post_title" label="作品题目" width="300">
                </el-table-column>
                <el-table-column prop="post_type" label="作品类别" sortable width="100">
                </el-table-column>
                <el-table-column fixed="right" label="操作" width="100">
                    <template slot-scope="scope">
                        <el-button @click=" showDetail(scope.row)" type="text" size="small">查看</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-row>
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
        <!-- 封禁 -->

        <div v-if="isRevokeShow" id="fengjin" @click="colseShow2">
            <!-- <el-button :plain="true" @click="open">封禁成功</el-button> -->
            <Transition name="bounce">
                <div @click.stop>
                    <el-card id="fengjin2">
                        <el-radio-group v-model="bannedRadio" v-removeAriaHidden>
                            <el-radio label="作品使用了未经授权的内容，侵犯了他人的版权">作品使用了未经授权的内容，侵犯了他人的版权</el-radio>
                            <el-radio label="作品内容可能包含虚假信息、不当行为或错误观念">作品内容可能包含虚假信息、不当行为或错误观念</el-radio>
                            <el-radio label="作品内容挑战公众认知底线或涉及法律风险">作品内容挑战公众认知底线或涉及法律风险</el-radio>
                            <el-radio label="作品内容涉及敏感或争议性话题">作品内容涉及敏感或争议性话题</el-radio>
                            <el-radio
                                label="作品发布不良信息，如自杀自残、虐待动物等，可能对社会造成不良影响">作品发布不良信息，如自杀自残、虐待动物等，可能对社会造成不良影响</el-radio>
                        </el-radio-group>
                        <el-button type="primary" @click="submitBannedCase">确认</el-button>
                    </el-card>
                </div>
            </Transition>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            tableData: null,
            isShow: false,
            postDetail: null,
            comments: null,
            commentN: null,
            isRevokeShow: false,
            bannedRadio:null
        }
    },
    methods: {
        getdata(){
            this.axios.get("/api/admin/getHistoryWork").then(res => {
            if (res.data.code == 200) {
                this.tableData = res.data.data
                console.log(this.tableData);

            }
        })
        },
        showDetail(row) {
            // console.log("打开");
            // console.log(row);

            this.axios.get(`/api/admin//postDetail?post_id=${row.post_id}`).then(res => {
                if (res.data.code = 200) {
                    this.postDetail = res.data.data.detail
                    this.commentN = res.data.data.comment
                    this.comments = res.data.data.comments
                    this.isShow = true
                }
            })
            
        },
        closeShow() {
            // console.log("关闭");

            this.isShow = false
        },
        openShow2() {
            this.isRevokeShow = true
        },
        colseShow2() {
            this.isRevokeShow = false
        },
        message() {
            this.$message({
                message: "封禁成功",
                duration: 2000,
                type: 'success'
            });
        },
        submitBannedCase() {
            // console.log(11111);
            // console.log(this.bannedRadio);
            // console.log(this.postDetail[0].post_id);
            this.axios.post("/api/admin/handleBanned", {
                data: {
                    case: this.bannedRadio,
                    pid: this.postDetail[0].post_id
                }
            }).then(res => {
                if (res.data.code == 200) {
                    this.message();
                    this.bannedRadio = null;
                    this.isRevokeShow = false;
                    this.getdata()
                }
            })
        },
    },
    created() {
       this.getdata()
    }
}
</script>
<style>
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

#fengjin2 {
    background-color: rgb(35, 57, 224);
    width: 400px;
    height: 300px;
}

#fengjin {
    position: fixed;
    top: 0;
    left: 0;
    right: 100px;
    bottom: 70px;
    /* background: rgba(103, 103, 99, 0.5); */
    display: flex;
    justify-content: right;
    padding: 100px;
    align-items: center;
    z-index: 999;
}
</style>