import { defineStore } from "pinia";
import router from "../router";
export const useLoginStore = defineStore("loginStore", {
  state: () => ({
    isAuthenticated: false,
    token: null,
    tokenExpired: false,
    user: "",
  }),
  actions: {
    logOut() {
      localStorage.removeItem("token");
      this.token = null;
      this.isAuthenticated = false;
      this.user = "";
      router.push("/login");
    },
    signIn(token,user) {
      this.token = token;
      this.isAuthenticated = true;
      this.tokenExpired = false;
      this.user = user;
    },
    setTokenExpired(value) {
      this.tokenExpired = value;
    },
  },
  getters: {
    getToken: (state) => state.token,
  },
});