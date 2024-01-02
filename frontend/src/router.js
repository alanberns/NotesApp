import { createRouter, createWebHistory } from "vue-router";

// Componentes
import IndexNotes from "./components/IndexNotes.vue";
import ArchivedNotes from "./components/ArchivedNotes.vue";
import LoginComponent from "./components/LoginComponent.vue";

// definir objeto rutas
const routes = [
  {
    path: "/",
    component: IndexNotes,
  },
  {
    path: "/archived",
    component: ArchivedNotes,
  },
  {
    path: "/login",
    component: LoginComponent,
  },

];

// crear objeto rutas
const router = createRouter({
  history: createWebHistory(),
  routes,
});


export default router;