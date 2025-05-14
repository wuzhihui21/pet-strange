<template>
    <div>
        <el-header>奇异怪宠后台管理——用户信息</el-header>
        <el-table :data="tableData" style="width: 100%">
            <el-table-column type="expand">
                <template slot-scope="props">
                    <el-form v-if="!isBanned" label-position="left" inline class="demo-table-expand">
                        <el-form-item label="ID" prop="uid">
                            <span>{{ props.row.uid }}</span>
                        </el-form-item>
                        <el-form-item label="电话" prop="uphone">
                            <span>{{ props.row.uphone }}</span>
                        </el-form-item>
                        <el-form-item label="密码" prop="upass">
                            <el-input v-model="props.row.upass" :disabled="!isEditing"></el-input>
                            <!-- <span>{{ props.row.upass }}</span> -->
                        </el-form-item>
                        <el-form-item label="名字" prop="uname">
                            <el-input v-model="props.row.uname" :disabled="!isEditing"></el-input>
                            <!-- <span>{{ props.row.uname }}</span> -->
                        </el-form-item>
                        <el-form-item label="头像" prop="imageUrl">
                            <el-upload class="upload-demo" action="/api/admin/edmitUser" :http-request="submitForm"
                                :on-change="handleChange" :show-file-list="false" :auto-upload="false">
                                <el-button type="primary" :disabled="!isEditing">选择图片</el-button>
                            </el-upload>
                               <img v-if="imageData == null && props.row.imageUrl != null"
                                :src="'http://localhost:3000/images/' + props.row.imageUrl" alt="old Image" width="100px" />
                            <img v-if="imageData" width="100px" :src="imageData" alt="Uploaded Image" />

                            <!-- <el-input v-model="props.row.imageUrl" :disabled="!isEditing"></el-input> -->
                            <!-- <span>{{ props.row.imageUrl }}</span> -->
                        </el-form-item>
                        <el-form-item label="性别" prop="usex">
                            <el-input v-model="props.row.usex" :disabled="!isEditing"></el-input>
                            <!-- <span>{{ props.row.usex }}</span> -->
                        </el-form-item>
                        <el-form-item label="年龄" prop="uage">
                            <el-input v-model="props.row.uage" :disabled="!isEditing"></el-input>
                            <!-- <span>{{ props.row.uage }}</span> -->
                        </el-form-item>
                        <el-form-item label="状态" prop="ustatus">

                            <span>{{ props.row.ustatus }}</span>
                        </el-form-item>
                        <el-form-item label="注册时间" prop="utime">
                            <span>{{ props.row.utime }}</span>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="startEditing" v-if="!isEditing">修改</el-button>
                            <el-button type="primary" @click="startbannedUser"
                                v-if="isEditing == false && props.row.ustatus == '正常'">封禁</el-button>
                            <el-button type="primary" @click="submitForm(props.row)" v-if="isEditing">完成</el-button>
                            <el-button @click="cancelEditing" v-if="isEditing">取消</el-button>
                        </el-form-item>
                    </el-form>
                    <el-form v-if="isBanned" label-width="80px">
                        <el-form-item label="ID">
                            <span>{{ props.row.uid }}</span>
                        </el-form-item>
                        <el-form-item label="电话">
                            <span>{{ props.row.uphone }}</span>
                        </el-form-item>
                        <el-form-item label="名字">
                            <span>{{ props.row.uname }}</span>
                        </el-form-item>
                        <el-form-item label="封禁原因">
                            <el-radio-group v-model="bannedcase" v-removeAriaHidden>
                                <el-radio
                                    label="用户账号存在发布违反国家法律法规、颠覆国家政权、危害国家安全、泄露国家秘密、损害国家尊严等内容或恶搞、歪曲英雄烈士事迹和精神">用户账号存在发布违反国家法律法规、颠覆国家政权、危害国家安全、泄露国家秘密、损害国家尊严等内容或恶搞、歪曲英雄烈士事迹和精神</el-radio>
                                <el-radio
                                    label="用户账号存在在用户头像或个人简介中直接加入导流内容，意图引导观众至其他平台">用户账号存在在用户头像或个人简介中直接加入导流内容，意图引导观众至其他平台</el-radio>
                                <el-radio
                                    label="用户账号存在包括生产传播谣言、侵犯他人隐私、侵犯知识产权、从事网络诈骗以及进行网络暴力等行为">用户账号存在包括生产传播谣言、侵犯他人隐私、侵犯知识产权、从事网络诈骗以及进行网络暴力</el-radio>
                                <el-radio label="用户账号存在经常发布涉及敏感或争议性话题内容">用户账号存在经常发布涉及敏感或争议性话题内容</el-radio>
                                <el-radio label="用户账号存在经常发布不良信息，如自杀自残、虐待动物等">用户账号存在经常发布不良信息，如自杀自残、虐待动物等</el-radio>
                            </el-radio-group>
                        </el-form-item>
                        <el-form-item label="封禁时间">
                            <el-col :span="10">
                                <el-date-picker value-format="yyyy-MM-dd" type="date" placeholder="选择日期" v-model="date1"
                                    style="width: 100%;"></el-date-picker>
                            </el-col>
                            <el-col class="line" :span="2">-</el-col>
                            <el-col :span="10">
                                <el-time-picker value-format="HH:mm:ss" placeholder="选择时间" v-model="date2"
                                    style="width: 100%;"></el-time-picker>
                            </el-col>
                        </el-form-item>
                        <el-form-item>
                            <el-button type="primary" @click="bannedUser(props.row)" v-if="isBanned">完成</el-button>
                            <el-button @click="cancelBanned" v-if="isBanned">取消</el-button>
                        </el-form-item>
                    </el-form>
                </template>
            </el-table-column>
            <el-table-column prop="uphone" label="账号">
            </el-table-column>
            <el-table-column prop="imageUrl" label="头像">
                  <template slot-scope="scope">
                        <el-avatar v-if="scope.row.imageUrl==null" shape="square" size="large" src="https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png"></el-avatar>
                        <img v-else :src="'http://localhost:3000/images/'+scope.row.imageUrl" alt="" style="width: 80px; height: auto;" />
                    </template>
            </el-table-column>
            <el-table-column prop="uname" label="用户名">
            </el-table-column>
            <el-table-column prop="utime" label="注册时间">
            </el-table-column>
            <el-table-column prop="ustatus" label="用户状态时间">
            </el-table-column>
        </el-table>
    </div>
</template>
<script>
import { mapState } from 'vuex';
export default {
    data() {
        return {
            tableData: null,
            isEditing: false,
            imageData: null,
            fileImage: null,
            isBanned: false,
            date1: null,
            date2: null,
            bannedcase: null
        }
    },
    computed: {
        ...mapState('user', ['user'])
    },
    methods: {
        getData() {
            this.axios.get("/api/admin/getUser").then(res => {
                if (res.data.code = 200) {
                    this.tableData = res.data.data
                }
            })
        },
        startEditing() {
            this.isEditing = true;
        },
        submitForm(data) {
            // console.log(data);
            // console.log(this.fileImage);
            const formData = new FormData();
            formData.append('uid', data.uid);
            formData.append('uname', data.uname);
            formData.append('imageUrl', data.imageUrl);
            formData.append('upass', data.upass);
            formData.append('usex', data.usex);
            formData.append('uage', data.uage);
            formData.append('files', this.fileImage);
            // console.log(formData);
            this.axios.post("/api/admin/edmitUser", formData
                , { headers: { 'Content-Type': 'multipart/form-data' } }
            )
                .then(res => {
                    if (res.data.code == 200) {
                        this.$message({
                            type: 'success',
                            message: '修改成功!'
                        });
                        this.isEditing = false;
                    }
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '修改失败'
                    });
                });

        },
        cancelEditing() {
            this.isEditing = false;
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
        startbannedUser() {
            this.isBanned = true
        },
        bannedUser(data) {
            var expireTime = this.date1 + ' ' + this.date2
            // console.log(expireTime);
            // console.log(data);

            this.axios.post('/api/admin/handleBannedUser', { expireTime: expireTime, b_uid: data.uid,case: this.bannedcase,uid:this.user.uid }).then(res => {
                if (res.data.code == 200) {
                    this.$message({
                        type: 'success',
                        message: '封禁成功'
                    });
                    this.isBanned = false
                    this.getData()
                } else {
                    this.$message({
                        type: 'info',
                        message: '封禁失败'
                    });
                }
            })

        },
        cancelBanned() {
            this.isBanned = false
        }
    },
    created() {
        this.getData()
    }
}
</script>
<style>
.demo-table-expand {
    font-size: 0;
}

.demo-table-expand label {
    width: 90px;
    color: #99a9bf;
}

.demo-table-expand .el-form-item {
    margin-right: 0;
    margin-bottom: 0;
    width: 50%;
}
</style>