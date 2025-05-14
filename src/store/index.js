import Vue from 'vue'
import Vuex from 'vuex'
//导入模块js
import user from './user'


//导入仓库持久化
import createPersistedState from 'vuex-persistedstate'


Vue.use(createPersistedState)
Vue.use(Vuex)

export default new Vuex.Store({
  state: {
  },
  getters: {
  },
  mutations: {
  },
  actions: {
  },
  modules: {
    //注册模块
    user,
   
    
  
  },

  //配置仓库持久化
  plugins: [createPersistedState()]  
})

