import Vue from 'vue'
import VueRouter from 'vue-router'

import BackendHome from '../views/BackendHome.vue'

Vue.use(VueRouter)

const routes = [

  {
    path: '/bkHome',
    name: 'home',
    component: BackendHome
  },
  {
    path:'/',
    name:'adminlogin',
    component: ()=>import('../views/AdminLogin.vue')
  }

]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
