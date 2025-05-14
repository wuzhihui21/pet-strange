<template>
    <div style="width: auto;height: 225px" id="sectorChart">
    </div>
</template>
<script>
// import echarts from 'echarts';
import * as echarts from 'echarts';
export default {
    name: "sectorChart",
    data() {
        return {
            workSecChartData:null
        }
    },
    mounted() {
        this.getSecData1()
      
    },
    methods: {
        getSecData1(){
        this.axios.get("/api/admin/workSectorCharDate")
        .then(res=>{
            if(res.data.code==200){
                // console.log(res.data.data);
                this.workSecChartData=res.data.data
                // console.log(this.workSecChartData);
                this.echartsInit()
            }
        })
        },
        echartsInit() {
            // console.log(this.workUectorData);
            
            var  option={
                title: {
                    text: '作品占比',
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
                        data:this.workSecChartData,
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
            echarts.init(document.getElementById('sectorChart')).setOption(option)
        }
    }
}
</script>