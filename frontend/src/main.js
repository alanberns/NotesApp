import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import axios from 'axios'
import 'bootstrap'
import 'bootstrap/dist/css/bootstrap.min.css'

const app = createApp(App)
    .use(router)

app.config.globalProperties.axios=axios

axios.defaults.baseURL = 'http://localhost:3000/api';

app.mount('#app')