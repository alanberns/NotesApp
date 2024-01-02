import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import pinia from './pinia.js'
import 'bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'

const app = createApp(App)
    .use(router)
    .use(pinia)

app.mount('#app')