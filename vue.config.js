const { defineConfig } = require('@vue/cli-service')
module.exports = defineConfig({
  transpileDependencies: true,
  //配置反向代理
  devServer:{
    proxy:{
      "/api":{
        target:"http://localhost:3000", //使用/api替代target
        changeOrigin:true, //允许跨域
        pathRewrite:{
          "^/api":""
        }
      }
    }
  }
})
