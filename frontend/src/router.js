import { createRouter, createWebHistory } from "vue-router";

// Components
import IndexNotes from "./components/IndexNotes.vue";
import ArchivedNotes from "./components/ArchivedNotes.vue";
import LoginComponent from "./components/LoginComponent.vue";

// routes object
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

// router object
const router = createRouter({
  history: createWebHistory(),
  routes,
});


export default router;