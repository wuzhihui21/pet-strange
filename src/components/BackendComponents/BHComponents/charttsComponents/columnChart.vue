<template>
    <div style="width: auto;height: 470px" id="columnchart">
    </div>

</template>
<script>
// import echarts from 'echarts';
import * as echarts from 'echarts';
export default {
    name: "columnchart",
    data() {
        return {
            columnData:null
        }
    },
    mounted() {
        this.getColDate()
        
    },
    methods: {
        getColDate() {
            // console.log(111);
            this.axios.get("/api/admin/columnCharDate")
                .then(res => {
                    if (res.data.code == 200) {
                        this.columnData = res.data.data.column
                        console.log(this.columnData);
                        this.updateChart()
                    }
                })
        },
        updateChart() {
            // console.log(222);
            // console.log(this.colChartDate);
            // console.log(this.columnData);
            var option = {
                title: {
                    text: '最近一周作品发布',
                },
                xAxis: {
                    type: 'category',
                    data: this.columnData[0]
                },
                yAxis: {
                    type: 'value',
                    min: 0,
                    max: 100
                },
                series: [
                    {
                        data: this.columnData[1],
                        type: 'bar',
                        itemStyle: {
                            color: "green"
                        }
                    }
                ]
            };
            echarts.init(document.getElementById('columnchart')).setOption(option)
        },


    },
    

}
</script>