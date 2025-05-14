import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
import echarts from 'echarts'
import VueRouter from 'vue-router'
import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.config.productionTip = false
Vue.use(ElementUI)
Vue.prototype.$echarts=echarts
Vue.use(VueRouter)
Vue.use(VueAxios,axios);




//请求拦截器，手动在每个请求的报文头部添加token
axios.interceptors.request.use((config)=>{
  config.headers.Authorization="Bearer "+window.localStorage.getItem("token");
   return config;
});

//响应拦截器
axios.interceptors.response.use((res)=>{
   let data=res.data;
   if(data.code==401){
        window.alert("请先登录");
   }
   return res;
},(err)=>{
    return Promise.reject(err);
});

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
