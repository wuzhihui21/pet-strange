<template>
    <div>
        <el-header>奇异怪宠后台管理——发布作品</el-header>
        <!-- 管理员发布作品页面 -->
        <!-- 作品发布表单 -->
         <div style="width: 100%;">
        <el-form :model="ruleForm" :rules="rules" ref="ruleForm" style="width: 500px;justify-content: center;margin-left: 400px;" class="demo-ruleForm">
            <el-form-item label="照片" prop="images">
                <el-upload class="upload-demo" action="/api/admin/edmitUser" :http-request="submitForm"
                    :on-change="handleChange" :show-file-list="false" :auto-upload="false">
                    <el-button type="primary">选择图片</el-button>
                </el-upload>
                <img v-if="imageData" :src="imageData" alt="Uploaded Image" width="200px" height="200px" />
            </el-form-item>
            <el-form-item label="正文标题" prop="title">
                <el-input style="width: 300px;" v-model="ruleForm.title" ></el-input>
            </el-form-item>
            <el-form-item label="正文内容" prop="content">
                <el-input type="textarea" style="width: 300px;" v-model="ruleForm.content"></el-input>
            </el-form-item>
            <el-form-item label="帖子类别" prop="type">
                <el-select v-model="ruleForm.type" placeholder="请选择活动区域">
                    <el-option label="科普类" value="科普类"></el-option>
                    <el-option label="分享类" value="分享类"></el-option>
                    <el-option label="求助类" value="求助类"></el-option>
                </el-select>
            </el-form-item>
            <el-form-item label="备注" prop="notes">
                <el-input style="width: 300px;" v-model="ruleForm.notes"></el-input>
            </el-form-item>
            <el-form-item>
                <el-button type="primary" @click="submitForm('ruleForm')">立即创建</el-button>
                <el-button @click="resetForm('ruleForm')">重置</el-button>
            </el-form-item>
        </el-form>
    </div>
    </div>
</template>
<script>
import {  mapState } from 'vuex';
export default {
    data() {
        return {
            imageData: null,
            fileImage: null,
            ruleForm: {
                images: null,
                title: null,
                content: null,
                type: null,
                notes: ''
            },
            rules: {
                images: [
                { required: true, message: '请选择图片', trigger: 'blur' }
                ],
                title: [
                    { required: true, message: '请输入正文标题', trigger: 'blur' },
                ],
                content: [
                    { required: true, message: '请输入正文内容', trigger: 'blur' }
                ],
                type: [
                    { required: true, message: '请至少选择一个活动性质', trigger: 'blur' }
                ],

            }
        };
    },
    methods: {
        submitForm(formName) {
            const formData = new FormData();
            formData.append('title', this.ruleForm.title);
            formData.append('des',this.ruleForm.content);
            formData.append('type',this.ruleForm.type)
            formData.append('notes',this.ruleForm.notes)
            formData.append('uid',this.user.uid)
            formData.append('files', this.ruleForm.images);
        this.$refs[formName].validate((valid) => {
          if (valid) {
            // alert('submit!');
            this.axios.post("/api/admin/addPost", formData
                , { headers: { 'Content-Type': 'multipart/form-data' } }
            )
                .then(res => {
                    if (res.data.code == 200) {
                        this.$message({
                            type: 'success',
                            message: '发布成功!'
                        });
                      
                    }else{
                        this.$message({
                        type: 'info',
                        message: '发布失败'
                    });
                    }
                })
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
        // submitForm(){
        //     // console.log(this.ruleForm);
        //     // console.log(this.fileImage);
        //     const formData = new FormData();
        //     formData.append('title', this.ruleForm.title);
        //     formData.append('des',this.ruleForm.content);
        //     formData.append('type',this.ruleForm.type)
        //     formData.append('notes',this.ruleForm.notes)
        //     formData.append('uid',this.user.uid)
        //     formData.append('files', this.ruleForm.images);

        //     this.axios.post("/api/admin/addPost", formData
        //         , { headers: { 'Content-Type': 'multipart/form-data' } }
        //     )
        //         .then(res => {
        //             if (res.data.code == 200) {
        //                 this.$message({
        //                     type: 'success',
        //                     message: '新增成功!'
        //                 });
        //                 this.resetForm()
        //             }else{
        //                 this.$message({
        //                 type: 'info',
        //                 message: '新增失败'
        //             });
        //             }
        //         })

        // },
        handleChange(file) {
            // console.log('wwww');
            // console.log(file);

            // 当文件状态改变时（例如选择文件后），读取文件并显示
            const reader = new FileReader();
            reader.readAsDataURL(file.raw);
            reader.onload = () => {
                this.imageData = reader.result; // 将读取到的base64编码设置为imageUrl
                this.ruleForm.images = file.raw; // 保存文件对象以便后续上传
            };
        },
        resetForm(formName) {
        this.$refs[formName].resetFields();
      }
    },
    computed: {
        ...mapState('user', ['user'])
    }
}
</script>
<style scoped>
.el-header {
    color: #333;
  font-weight: bold;
  font-size:larger;
  text-align: center;
  line-height: 60px;
  width: 100%;
}
.el-input__inner{
    width: 20%;
}
</style>