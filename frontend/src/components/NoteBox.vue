<template>
  <div class="col-6">
    <div class="card-body border border-warning-subtle border-4 grid gap-3 m-2 p-2">
      <div class="row">
        <div class="col-8">
          <h5 class="card-title">{{ note.title }}</h5>
          <p class="card-text text-truncate">{{ note.content }}</p>
        </div>
        <div class="col-4 border-start border-warning-subtle border-2">
          <button type="button" class="btn" @click="deleteNote(); $emit('refresh');">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash-fill" viewBox="0 0 16 16">
              <path d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1H2.5zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5zM8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5zm3 .5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 1 0z"/>
            </svg>
          </button>
          <router-link :to="'/show/' + note.id"><button type="button" class="btn">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
              <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
              <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
            </svg>  
          </button></router-link>

          <button v-if="note.isActive" type="button" class="btn" @click="$emit('refresh');changeState();">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-archive-fill" viewBox="0 0 16 16">
              <path d="M12.643 15C13.979 15 15 13.845 15 12.5V5H1v7.5C1 13.845 2.021 15 3.357 15h9.286zM5.5 7h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1zM.8 1a.8.8 0 0 0-.8.8V3a.8.8 0 0 0 .8.8h14.4A.8.8 0 0 0 16 3V1.8a.8.8 0 0 0-.8-.8H.8z"/>
            </svg>
          </button>
          <button v-if="!note.isActive" type="button" class="btn" @click="$emit('refresh');changeState();">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-capslock-fill" viewBox="0 0 16 16">
              <path d="M7.27 1.047a1 1 0 0 1 1.46 0l6.345 6.77c.6.638.146 1.683-.73 1.683H11.5v1a1 1 0 0 1-1 1h-5a1 1 0 0 1-1-1v-1H1.654C.78 9.5.326 8.455.924 7.816L7.27 1.047zM4.5 13.5a1 1 0 0 1 1-1h5a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1h-5a1 1 0 0 1-1-1v-1z"/>
            </svg>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import { axiosService } from "../axios";
import {useAlertStore} from '../stores/alertStore'
export default {  
  name: 'NoteBox',
  setup() {
    const alertStore = useAlertStore();
    return { alertStore };
  },
  props: {
    note: Object
  },
  data(){
    return{
        modified_note: {
          title:"",
          content:""
        }
    }
  },
  methods: {
    async changeState() {
      await axiosService.patch("/notes/"+this.note.id+"/toggle",{
        note: this.note
      },
      {   
        headers: {
          Authorization: `${localStorage.getItem("token")}`,
        },
      })
      .then(() => {
        this.alertStore.setInfo("Note was updated");
      })
      .catch((e) => {
        this.alertStore.setError(e);
      });
    },
    async deleteNote(){
      await axiosService.delete("/notes/"+this.note.id,
      {   
        headers: {
          Authorization: `${localStorage.getItem("token")}`,
        },
      })
      .then(() => {
        this.alertStore.setInfo("Note was deleted");
      })
      .catch((e) => {
        this.alertStore.setError(e);
      });
    },
    editNote: async function(){
      await axiosService.put("/notes/"+this.modified_note.id,{
        note: this.modified_note
      },
      {   
          headers: {
              Authorization: `${localStorage.getItem("token")}`,
          },
      })
      .then(() => {
        this.alertStore.setInfo("Note was updated");
      })
      .catch((e) => {
        this.alertStore.setError(e);
      });
    },
  },
};
</script>