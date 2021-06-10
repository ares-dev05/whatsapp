import Vue from 'vue'
import App from './App.vue'
import VueConfirmDialog from 'vue-confirm-dialog'
import VueElementLoading from "vue-element-loading";
import VueNotification from '@mathieustan/vue-notification';
import VueSimpleAlert from "vue-simple-alert";
import VModal from 'vue-js-modal'

Vue.use(VueSimpleAlert);
Vue.use(VueNotification);
Vue.use(VueConfirmDialog)
Vue.use(VModal)

Vue.component('vue-confirm-dialog', VueConfirmDialog.default)
Vue.component("VueElementLoading", VueElementLoading);

require('@/assets/css/material_icons.css')
require('@/assets/css/font-awesome.css')
require('@/assets/css/arimo.css')

Vue.config.productionTip = false

new Vue({
  render: h => h(App),
}).$mount('#app')
