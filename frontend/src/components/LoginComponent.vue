<template>
    <h3>Login</h3>
    <br>
    <span>{{ error_msg }}</span>
    <form @submit.prevent="login">
        <div class="row">
            <div class="input-field">
            <input id="username"
                type="text"
                v-model="username"
            />
            <label for="username">Username</label>
            </div>
        </div>
        <div class="row">
          <div class="input-field">
            <input
              id="password"
              type="password"
              v-model="password"
            />
            <label for="password">Contraseña</label>
          </div>
        </div>
        <div class="row">
          <button
            type="submit"
            name="action"
          >
            Iniciar Sesion
          </button>
        </div>
      </form>
</template>
<script>
import {useLoginStore} from '../stores/loginStore'
import router from "../router";
import { axiosService } from "../axios";
export default {  
  name: 'LoginComponent',
  setup() {
      const loginStore = useLoginStore();
  return { loginStore };
  },
  data() {
    return {
      username: "",
      password: "",
      error_msg: "",
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
        }
        )
        .then((response) => {
            localStorage.setItem("token", response.data.token);
            this.loginStore.signIn(response.data.token,response.data.username);
            router.push("/");
        })
        .catch((error) => (this.error_msg=error));
    },
  },
};
</script>