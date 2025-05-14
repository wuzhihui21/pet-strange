<template>
    <div style="width: auto;height: 225px" id="usersectorChart">
    </div>
</template>
<script>
// import echarts from 'echarts';
import * as echarts from 'echarts';
export default {
    name: "usersectorChart",
    data() {
        return {
            userSectorData:null
        }
    },
   
    mounted() {
        this.getSecData2()
       
    },
    methods: {
       
        echartsInit() {
            // console.log(this.userSectorData);
            
            var  option={
                title: {
                    text: '用户占比',
                    subtext: 'Fake Data',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    bottom:"bottom"
                },
                series: [
                    {
                        name: 'Access From',
                        type: 'pie',
                        radius: '50%',
                        data:this.userSectorData,
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            }
            // 在生命周期中挂载
            echarts.init(document.getElementById('usersectorChart')).setOption(option)
        },
        getSecData2(){
        this.axios.get("/api/admin/userSectorCharDate")
        .then(res=>{
            if(res.data.code==200){
                // console.log(res.data.data);
                this.userSectorData=res.data.data
                // console.log(this.userSectorData);
                this.echartsInit()
            }
        })
        }
    }
}
</script>