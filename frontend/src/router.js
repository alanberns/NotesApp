import { createRouter, createWebHistory } from "vue-router";

// Components
import IndexNotes from "./components/IndexNotes.vue";
import ArchivedNotes from "./components/ArchivedNotes.vue";
import LoginComponent from "./components/LoginComponent.vue";
import MyProfile from './components/profile/MyProfile.vue';
import EditProfile from './components/profile/EditProfile.vue';
import CreateProfile from './components/profile/CreateProfile.vue';
import NewNote from './components/notes/NewNote'

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
  {
    path: "/me",
    component: MyProfile,
  },
  {
    path: "/me/edit",
    component: EditProfile,
  },
  {
    path: "/register",
    component: CreateProfile,
  },
  {
    path: "/new",
    component: NewNote,
  },

];

// router object
const router = createRouter({
  history: createWebHistory(),
  routes,
});


export default router;