<template>
      <div class="row d-flex justify-content-center">
        <div class="col-9 border border-warning-subtle border-4">
            <div class="mb-3 border-bottom border-warning-subtle border-3 p-2">
                <h4>{{ note.title }}</h4>
            </div>
            <div class="mb-3 text-start">
                {{ note.content }}
            </div>
          </div>
          <div class="d-grid gap-2 d-md-block d-md-flex justify-content-md-center p-2">
              <router-link to="/"><button type="button" class="btn btn-warning">Back</button></router-link>
              <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editNote">Edit</button>
          </div>        
      </div>


        <div class="modal fade" id="editNote" tabindex="-1" aria-labelledby="editNoteLabel" aria-hidden="true">
          <div class="modal-dialog modal-dialog-scrollable modal-xl">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="editNoteLabel">Edit note</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                <form>
                  <div class="mb-3">
                    <label for="recipient-name" class="col-form-label">Title:</label>
                    <input type="text" class="form-control" id="recipient-name" v-model="note.title">
                  </div>
                  <div class="mb-3">
                    <label for="message-text" class="col-form-label">Content:</label>
                    <textarea class="form-control" id="message-text" v-model="note.content"></textarea>
                  </div>
                </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" @click="editNote" data-bs-dismiss="modal">Edit</button>
              </div>
            </div>
          </div>
        </div>


</template>

<script>

import { axiosService } from "../../axios";
import {useAlertStore} from '../../stores/alertStore'
export default {  
  name: 'EditNote',
  setup() {
    const alertStore = useAlertStore();
    return { alertStore };
  },
  data(){
    return{
        note: Object,
    }
  },
  mounted(){
      axiosService.get("/notes/"+this.$route.params.id, {
        headers: {
            Authorization: `${localStorage.getItem("token")}`,
        },
      })
      .then((response) => {
      this.note=response.data
    })
    .catch((e) => {
      this.alertStore.setError(e);
    });
  },
  methods:{
    editNote: async function(){
      await axiosService.put("/notes/"+this.$route.params.id,{
        note: this.note
      }, {
        headers: {
          Authorization: `${localStorage.getItem("token")}`,
        },
      })
      .then((response) => {
        this.note=response.data
      })
      .catch((e) => {
        this.alertStore.setError(e);
      });
    }
  },
}
</script>