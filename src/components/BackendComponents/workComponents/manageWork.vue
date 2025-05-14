<template>
    <div>
        <el-header>奇异怪宠后台管理首页——管理作品</el-header>
        <!-- 管理员管理自己发布的作品 -->
        <!-- 显示此账号管理员发布的作品及获得的点赞和关注量 -->
        <el-row style="width: 100%;text-align: center;padding-top: 20px;">
            <el-avatar v-if="user.imageUrl == null" size="large"
                src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"></el-avatar>
            <el-avatar v-else :size="70" :src="'http://localhost:3000/images/' + user.imageUrl"></el-avatar>

            <el-row>
                <span>{{ user.uname }}</span>
            </el-row>
            <el-row style="">
                <el-col>粉丝量:{{ this.focusNum }} &nbsp; &nbsp; 点赞量:{{ this.likeNum }}</el-col>
            </el-row>
            <div style="border-bottom: 1px solid; margin-bottom: 30px;margin-top: 30px;"></div>
        </el-row>
        <div id="div2">
            <!-- <masonry  :cols="{ default: 5, 1100: 3, 700: 2, 500: 1 }">  -->
                <div id="workCard" v-for="(item, index) in this.workDate" :key="index" >
                    <div @click="showDetail(item.post_id)">
                        <el-card style="background-color: white;margin-left: 5px;width: 280px;">
                            <el-image :src="'http://localhost:3000/images/' + item.post_image"
                                style="padding: 0;margin: 0; width: 100%;" width="100%" height="300px"
                                fit="cover"></el-image>
                            <div>
                                <span>{{ item.post_title }}</span><br>
                                <span>{{ item.uname }}</span><br>
                                <span>点赞：{{ item.post_like }}</span>
                            </div>
                        </el-card>
                    </div>
                </div>

            <!-- </masonry> -->
        </div>
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
                                <div style="height: 500px;overflow: auto;">
                                    <el-row type="flex" align="middle">
                                        <el-col>
                                            <el-row type="flex" align="middle">

                                                <el-avatar v-if="this.postDetail[0].imageUrl==null" size="large"
                                                    src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"></el-avatar>
                                                <el-avatar v-else size="large"
                                                    :src="'http://localhost:3000/images/' + this.postDetail[0].imageUrl"></el-avatar>
                                                <span>{{ this.postDetail[0].uname }}</span>
                                            </el-row>
                                        </el-col>
                                        <el-col></el-col>
                                        <el-col v-for="(item, key) in this.postDetail" :key="key">
                                            <button @click="openEdit()"
                                                style="background-color: red; width: 80px;height: 40px; border-radius: 50px;box-shadow: none;">
                                                修改
                                            </button>
                                            <button @click="deleteWork(item.post_id)"
                                                style="background-color: red; width: 80px;height: 40px; border-radius: 50px;box-shadow: none;">
                                                删除
                                            </button>
                                        </el-col>
                                    </el-row>

                                    <div id="content">
                                        <!-- 标题 -->
                                        <el-row style="padding-top: 20px;">
                                            <span style="font-weight: bolder;font-size: larger;">{{
                                                this.postDetail[0].post_title }}</span>
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
                                                                <el-col v-if="item.uname == null" :span="6"> {{
                                                                    item.uname
                                                                    }}</el-col>
                                                                <el-col v-else :span="6"> {{ item.uphone }}</el-col>
                                                                <el-col :span="18"
                                                                    style="text-align: right;">点赞</el-col>
                                                            </el-row>
                                                            <el-row>{{ item.c_content }}</el-row>
                                                            <el-row>
                                                                <el-row :span="24"
                                                                    style="display: flex; justify-content: space-between;">
                                                                    <el-col :span="18"> {{ item.c_time }}</el-col>
                                                                    <el-col :span="6"
                                                                        style="text-align: right;">回复</el-col>
                                                                </el-row>
                                                            </el-row>
                                                        </el-col>
                                                    </el-row>
                                                </div>
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

        <!-- 修改作品 -->
        <div v-if="isShow2" id="modal" @click="colseShow2">
            <Transition name="bounce">
                <div class="container" @click.stop>
                    <el-card id="detailCard2">
                        <el-form :model="editFrom" ref="ruleForm" label-width="100px" class="demo-ruleForm">
                            <el-form-item label="照片" prop="images">
                                <el-upload class="upload-demo" action="/api/admin/edmitUser" :http-request="submitForm"
                                    :on-change="handleChange" :show-file-list="false" :auto-upload="false">
                                    <el-button type="primary">选择图片</el-button>
                                </el-upload>
                                <img v-if="imageData" :src="imageData" alt="Uploaded Image" width="200px"
                                    height="200px" />
                            </el-form-item>
                            <el-form-item label="正文标题" prop="title">
                                <el-input v-model="editFrom.post_title"></el-input>
                            </el-form-item>
                            <el-form-item label="正文内容" prop="content">
                                <el-input v-model="editFrom.post_describe"></el-input>
                            </el-form-item>
                            <el-form-item label="帖子类别" prop="post_type">
                                <el-select v-model="editFrom.post_type" placeholder="请选择帖子类别">
                                    <el-option label="科普类" value="科普类"></el-option>
                                    <el-option label="分享类" value="分享类"></el-option>
                                    <el-option label="求助类" value="求助类"></el-option>
                                </el-select>
                            </el-form-item>
                            <el-form-item label="备注" prop="notes">
                                <el-input v-model="editFrom.post_notes"></el-input>
                            </el-form-item>
                            <el-form-item>
                                <el-button type="primary" @click="submitForm()">完成</el-button>
                                <el-button @click="resetForm('ruleForm')">重置</el-button>
                            </el-form-item>
                        </el-form>
                    </el-card>
                </div>
            </Transition>
        </div>
    </div>
</template>
<script>
// import {Masonry} from 'vue-masonry-css';
// import VueWaterfall from 'vue-waterfall';
import { mapState } from 'vuex';
export default {
    components:{
        // Masonry
    //    'vue-waterfall': VueWaterfall
    },
    data() {
        return {
            currentDate: new Date(),
            isShow: false,
            isShow2: false,
            focusNum: null,
            likeNum: null,
            workDate: null,
            postDetail: null,
            comments: null,
            commentN: null,
            editFrom: null,
            imageData: null,
            fileImage: null
        };
    },
    methods: {
        getworkData() {
            this.axios.get(`/api/admin/getUserWork?uid=${this.user.uid}`).then(res => {
                if (res.data.code == 200) {
                    this.focusNum = res.data.data.focus[0].num;
                    this.likeNum = res.data.data.like[0].allnum;
                    console.log(this.focusNum);
                    // console.log(this.likeNum);
                    this.workDate = res.data.data.works;
                    // console.log(this.workDate);

                }
            })
        },
        showDetail(pid) {
            // console.log("打开");
            // console.log(pid);
            this.axios.get(`/api/admin/postDetail?post_id=${pid}`).then(res => {
                if (res.data.code = 200) {
                    this.postDetail = res.data.data.detail
                    this.commentN = res.data.data.comment
                    this.comments = res.data.data.comments
                    this.isShow = true
                    console.log(this.postDetail[0]);
                    
                }
            })
        },
        closeShow() {
            // console.log("关闭");

            this.isShow = false
        },
        deleteWork(pid) {
            // console.log(pid);
            this.$confirm('确定删除作品吗', '提示', {
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
                        this.getworkData()
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

        },
        openEdit() {
            this.editFrom = this.postDetail[0];
            this.isShow2 = true
        },
        colseShow2() {
            this.isShow2 = false
        },
        handleChange(file) {
            // console.log('wwww');
            // console.log(file);

            // 当文件状态改变时（例如选择文件后），读取文件并显示
            const reader = new FileReader();
            reader.readAsDataURL(file.raw);
            reader.onload = () => {
                this.imageData = reader.result; // 将读取到的base64编码设置为imageUrl
                this.fileImage = file.raw; // 保存文件对象以便后续上传
            };
        },
        submitForm() {
            console.log(this.editFrom);
            const formData = new FormData();
            formData.append('title', this.editFrom.post_title);
            formData.append('image', this.editFrom.post_image);
            formData.append('des', this.editFrom.post_describe);
            formData.append('type', this.editFrom.post_type)
            formData.append('notes', this.editFrom.post_notes)
            formData.append('post_id', this.editFrom.post_id)
            formData.append('files', this.fileImage);
            this.axios.post("/api/admin/edmitWork", formData
                , { headers: { 'Content-Type': 'multipart/form-data' } }).then(res => {
                    if (res.data.code == 200) {
                        this.$message({
                            type: 'success',
                            message: '修改成功!'
                        });
                        this.getworkData()
                    } else {
                        this.$message({
                            type: 'info',
                            message: '修改失败!'
                        });

                    }
                })
        }
    },
    computed: {
        ...mapState('user', ['user'])
    },
    created() {
        this.getworkData()
        // console.log(this.user.imageUrl);
        
    }
}
</script>
<style scoped>
#content{
    overflow-y: hidden;
    padding-bottom: 30px;
    scrollbar-width: 5px;
}
.masonry-item {
  background-color: #fff;
  margin-bottom: 30px; /* 与gutter值一致，确保垂直间距正确 */
  /* 其他样式，如边框、阴影等 */
}
#div2{
    background-color: #f0f0f0;
    /* height: 450px;  */
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-start;
   align-content: flex-start;
   /* column-count: 5;
   justify-content: center; */
 
}
#workCard{
    margin: 5px;
    padding: 10px;
    border-radius: 10px;
}
#detailCard {
    background-color: white;
    width: 800px;
    height: 500px;
}

#detailCard2 {
    background-color: rgb(203, 238, 29);
    width: 800px;
    height: 500px;
    overflow: auto;
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
    font-size: larger;
    text-align: center;
    line-height: 60px;
    width: 100%;
}
</style>