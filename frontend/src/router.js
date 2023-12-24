import { createRouter, createWebHistory } from "vue-router";

// Componentes
import IndexNotes from "./components/IndexNotes.vue";
import ArchivedNotes from "./components/ArchivedNotes.vue";

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

];

// crear objeto rutas
const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;