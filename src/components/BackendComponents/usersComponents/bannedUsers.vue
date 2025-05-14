<template>
    <div>
        <el-header>奇异怪宠后台管理——用户封禁记录</el-header>
        <el-table :data="tableData" style="width: 100%" :default-sort="{ prop: 'date', order: 'descending' }">
            <el-table-column prop="uphone" label="账号" sortable width="180">
            </el-table-column>
            <el-table-column prop="imageUrl" label="头像" sortable width="180">
                <template slot-scope="scope">
                        <el-avatar v-if="scope.row.imageUrl==null" shape="square" size="large" src="https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png"></el-avatar>
                        <img v-else :src="'http://localhost:3000/images/'+scope.row.imageUrl" alt="" style="width: 80px; height: auto;" />
                    </template>
            </el-table-column>
            <el-table-column prop="uname" label="用户名" sortable width="180">
            </el-table-column>
            <el-table-column prop="bannedtime" label="封禁时刻" sortable>
            </el-table-column>
            <el-table-column prop="longtime" label="禁封时间" sortable>
            </el-table-column>
            <el-table-column prop="ustatus" label="禁封状态" sortable>
            </el-table-column>
            <el-table-column fixed="right" label="操作" width="100">
                <template slot-scope="scope">
                    <el-button v-if="scope.row.ustatus == '封禁 '" @click="liftedBannedUser(scope.row)" type="text"
                        size="small">解封</el-button>
                    <el-button v-else-if="scope.row.ustatus == '已解封'" @click="deleteBannedUser(scope.row)" type="text"
                        size="small">删除</el-button>
                </template>
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
        }
    },
    computed: {
        ...mapState('user', ['user'])
    },
    methods: {
        getData() {
            this.axios("/api/admin/getBannedUser").then(res => {
                if (res.data.code == 200) {
                    this.tableData = res.data.data
                    console.log(this.tableData);
                    
                }
            })
        },
        liftedBannedUser(data) {
            // console.log(data);
            
            this.$confirm('确定解除封禁', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.axios.get(`/api/admin/liftecBannedUser?uid=${data.uid}&suid=${this.user.uid}`).then(res => {
                    if (res.data.code == 200) {
                        this.getData()
                        this.$message({
                            type: 'success',
                            message: '解封成功'
                        });
                       
                    } else {
                        this.$message({
                            type: 'info',
                            message: '解封失败'
                        });
                    }
                })
            }).catch(() => {
                this.$message({
                    type: 'info',
                    message: '已取消'
                });
            });

        },
        deleteBannedUser(data) {
            this.$confirm('确定删除封禁用户记录吗', '提示', {
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(() => {
                this.axios.get(`/api/admin/deleteBannedUser?bu_id=${data.bu_id}`).then(res => {
                    if (res.data.code == 200) {
                        this.$message({
                            type: 'success',
                            message: '删除成功'
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
                    message: '已取消'
                });
            });
                
           

        }
    },
    created() {
        this.getData()
    }
}
</script>