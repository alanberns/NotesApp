import { createRouter, createWebHistory } from "vue-router";

// Components
import IndexNotes from "./components/IndexNotes.vue";
import ArchivedNotes from "./components/ArchivedNotes.vue";
import LoginComponent from "./components/LoginComponent.vue";
import MyProfile from './components/profile/MyProfile.vue';
import EditProfile from './components/profile/EditProfile.vue';
import CreateProfile from './components/profile/CreateProfile.vue';
import NewNote from './components/notes/NewNote'
import ShowNote from './components/notes/ShowNote'

const baseName = "NotesApp | "
// routes object
const routes = [
  {
    path: "/",
    component: IndexNotes,
    name: baseName+"My notes",
  },
  {
    path: "/archived",
    component: ArchivedNotes,
    name: baseName+"Archived notes",
  },
  {
    path: "/login",
    component: LoginComponent,
    name: baseName+"Login",
  },
  {
    path: "/me",
    component: MyProfile,
    name: baseName+"My profile",
  },
  {
    path: "/me/edit",
    component: EditProfile,
    name: baseName+"Edit profile",
  },
  {
    path: "/register",
    component: CreateProfile,
    name: baseName+"Register",
  },
  {
    path: "/new",
    component: NewNote,
    name: baseName+"New note",
  },
  {
    path: "/show/:id",
    component: ShowNote,
    name: baseName+"Note",
  }

];

// router object
const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  document.title = to.name;
  next();
});

export default router;