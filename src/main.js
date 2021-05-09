import Vue from 'vue'
import App from './App.vue'

require('@/assets/css/material_icons.css')
require('@/assets/css/font-awesome.css')
require('@/assets/css/arimo.css')

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
}).$mount('#app')
