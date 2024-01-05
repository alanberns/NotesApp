<template>
  <nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
      <div class="collapse navbar-collapse" id="navbarText">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="/">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="/new">New note</a>
          </li>
        </ul>
          <div class="dropdown-center" v-if="loginStore.isAuthenticated">
            <a class="nav-link dropdown-toggle" href="#" role="button" 
              data-bs-toggle="dropdown" aria-expanded="false">
              {{ loginStore.user }}
            </a>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="/me">Mi perfil</a></li>
              <li><hr class="dropdown-divider"></li>
              <li>      
                <a
                  class="dropdown-item"
                  href="#"
                  @click="signOut()"
                  >Cerrar Sesion
                </a>
              </li>
            </ul>
        </div>
      </div>
    </div>
  </nav>
</template>

<script>
import { useLoginStore } from "../../stores/loginStore";
import {useAlertStore} from '../../stores/alertStore'

export default {
  name: "NavbarComponent",
  setup() {
    const loginStore = useLoginStore();
    const alertStore = useAlertStore();
  return { loginStore, alertStore };
  },
  methods: {
    signOut() {
      this.loginStore.setTokenExpired(null);
      this.loginStore.logOut();
      this.alertStore.setInfo("Sesión cerrada")
    },
  },
};
</script>

<style>
navbar{
  width: 100vh;
  height: 100vh;
}
</style>