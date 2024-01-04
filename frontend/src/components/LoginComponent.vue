<template>
    <h3>Login</h3>
    <br>
    <div class="row d-flex justify-content-center">
      <div class="col-8">
        <form @submit.prevent="login">
          <div class="mb-3">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-control" id="username" v-model="username">
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" v-model="password">
          </div>
          <button type="submit" name="action" class="btn btn-warning">Iniciar Sesión</button>
        </form>
        <router-link to="/register"><button type="button" class="btn btn-link">Create profile</button></router-link>
      </div>
    </div>
</template>
<script>
import {useLoginStore} from '../stores/loginStore'
import {useAlertStore} from '../stores/alertStore'
import router from "../router";
import { axiosService } from "../axios";
export default {  
  name: 'LoginComponent',
  setup() {
      const loginStore = useLoginStore();
      const alertStore = useAlertStore();
  return { loginStore, alertStore };
  },
  data() {
    return {
      username: "",
      password: "",
    };
  },
  methods: {
    async login() {
      await this.getUser();
    },
    async getUser() {
      await axiosService
        .post(
          "/login",
          {
            username: this.username,
            password: this.password,
          })
        .then((response) => {
            localStorage.setItem("token", response.data.token);
            this.loginStore.signIn(response.data.token,response.data.username);
            this.alertStore.setInfo("Bienvenido "+response.data.username)
            router.push("/");
        })
        .catch((e) => this.alertStore.setError(e));
    },
  },
};
</script>