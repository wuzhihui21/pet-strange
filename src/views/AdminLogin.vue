<template>
    <el-main>
        <el-card class="box-card">
            <div slot="header" class="clearfix">
                <router-link to="/AdminLogin" class="adminLink">管理员登录</router-link>
            </div>
            <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px"
                class="demo-ruleForm">
                <el-form-item label="手机号" prop="phone">
                    <el-input v-model.number="ruleForm.phone"></el-input>
                </el-form-item>
                <el-form-item label="密码" prop="pass">
                    <el-input type="password" v-model="ruleForm.pass" autocomplete="off"></el-input>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
                    <el-button @click="resetForm('ruleForm')">重置</el-button>
                </el-form-item>
            </el-form>
        </el-card>
    </el-main>
</template>

<script>
import { mapMutations } from 'vuex';
export default {
    data() {
        return {
            ruleForm: {
                pass: '',
                phone: ''
            },
            rules: {
                phone: [
                    { required: true, message: "请填入手机号", trigger: 'blur' }
                ],
                pass: [
                    { required: true, message: "请填入密码", trigger: 'blur' }
                ]


            }
        };
    },
    methods: {
        ...mapMutations('user', ["saveUser"]),
        submitForm(formName) {
            this.$refs[formName].validate((valid) => {
                console.log(this.ruleForm.phone + this.ruleForm.pass);

                if (valid) {
                    this.axios.post('/api/admin/login', {
                        phone: this.ruleForm.phone,
                        pass: this.ruleForm.pass
                    }).then(res => {
                        if (res.data.code == 200) {
                            this.saveUser(res.data.data.user)
                            window.localStorage.setItem("token", res.data.data.token);
                            this.$message({
                                message: "登录成功",
                                duration: 2000,
                                type: 'success'
                            });
                            this.$router.push('/bkHome')

                        } else {
                            this.$message({
                                message: "登录失败，用户名或密码错误",
                                duration: 2000,
                                type: 'error'
                            });
                        }
                    })
                } else {
                    console.log('error submit!!');
                    return false;
                }
            });
        },
        resetForm(formName) {
            this.$refs[formName].resetFields();
        }
    }
}
</script>

<style scoped>
.clearfix {
    margin-top: 10px;
    width: 100%;
    height: 50px;
    line-height: 10px;
}


.el-main {
    object-fit: cover;
    height: 100vh;
    background-size: 110% 110%; 
  background-repeat: no-repeat;
  background-image: url("../assets/images/背景图3.jpg");
  background-repeat: no-repeat;
  background-position: center center; 

}

.box-card {
    margin: 0 auto;
    width: 600px;
    height: 400px;
    text-align: center;
    margin-top: 150px;
    background-color: rgba(255, 255, 255, 0.8);
}

.loginLink,
.adminLink {
    display: inline-block;
    margin: 20px;
    padding: 8px 16px;
    text-decoration: none;
    border-radius: 5px;

    opacity: 0.8;
    margin-bottom: 60px;
}

.registerLink {
    text-decoration: none;
}
</style>