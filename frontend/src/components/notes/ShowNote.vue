<template>
      <div class="row d-flex justify-content-center">
        <div class="col-9 border border-warning-subtle border-4">
            <div class="mb-3 border-bottom border-warning-subtle border-3 p-2">
                <h4>{{ note.title }}</h4>
            </div>
            <div class="mb-3 text-start">
              {{ note.content }}
            </div>
            Categories
            <div>
                <span class="badge rounded-pill text-bg-light" v-for="category in note_categories" v-bind:key="category.id">
                    {{ category.name }}
                </span>
                
            </div>
          </div>
          <div class="d-grid gap-2 d-md-block d-md-flex justify-content-md-center p-2">
              <router-link to="/"><button type="button" class="btn btn-warning">Back</button></router-link>
              <router-link to="#"><button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editNote">Edit</button></router-link>
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
                    <input type="text" class="form-control" id="recipient-name" v-model="editedNote.title">
                  </div>
                  <div class="mb-3">
                    <label for="message-text" class="col-form-label">Content:</label>
                    <textarea class="form-control" id="message-text" v-model="editedNote.content"></textarea>
                  </div>
                </form>
                <div class="mb-3">
                    Categories
                    <div>
                        <span class="badge rounded-pill text-bg-light" v-for="category in note_categories" v-bind:key="category.id">
                            {{ category.name }}
                            <button class="btn btn-light btn-sm" type="button" @click="removeCategory(category)">x</button>
                        </span>
                        
                    </div>
                </div>
                <div class="row d-flex justify-content-center p-2" v-if="categories.length > 0">
                    <div class="dropdown-center col-5">
                        <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Add category
                        </button>
                        <ul class="dropdown-menu">
                            <li v-for="category in categories" v-bind:key="category.id" @click="addCategory(category)">
                                <a class="dropdown-item" href="#">{{ category.name }}</a>
                            </li>
                        </ul>
                    </div>
                </div> 
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
        editedNote: {
          title: String,
          content: String,
        },
        categories: [],
        note_categories: []
    }
  },
  mounted(){
    this.fetchNotes()
  },
  methods:{
    fetchNotes: async function(){
      await axiosService.get("/notes/"+this.$route.params.id, {
        headers: {
            Authorization: `${localStorage.getItem("token")}`,
        },
      })
      .then((response) => {
      this.note=response.data.note
      this.editedNote.title = this.note.title
      this.editedNote.content = this.note.content
      this.note_categories=response.data.note_categories
      this.categories = response.data.categories
    })
    .catch((e) => {
      this.alertStore.setError(e);
    });
  },
    editNote: async function(){
      let validationResult = this.validateNote(this.editedNote)
      if ( validationResult != "true"){
        this.alertStore.setError(validationResult);
      }
      else{
        await axiosService.put("/notes/"+this.$route.params.id,{
          note: this.editedNote,
          categories: this.note_categories
        }, {
          headers: {
            Authorization: `${localStorage.getItem("token")}`,
          },
        })
      .then((response) => {
        this.note=response.data.note
        this.editedNote.title = this.note.title
        this.editedNote.content = this.note.content
        this.note_categories=response.data.note_categories
        this.categories=response.data.categories
        this.alertStore.setInfo("Cambios guardados");
      })
      .catch((e) => {
        this.alertStore.setError(e);
      });
    }
  },
    addCategory: function(cat){
        this.categories.splice(this.categories.indexOf(cat),1)
        this.note_categories.push(cat)
    },
    removeCategory: function(cat){
        this.note_categories.splice(this.note_categories.indexOf(cat),1)
        this.categories.push(cat)
      },
    validateNote: function(note){
        var validez = "true";
        
        var regexTitle = /^[a-zA-Z0-9.,*?¿¡ !#$]{3,100}$/;
        var regexContent = /^[a-zA-Z0-9.,*?¿ ¡!#$\n]{0,1000}$/;
        
        if(!regexTitle.test(note.title)) validez = "Ingrese un title válido.";
        else if(!regexContent.test(note.content)) validez = "Ingrese un content válido.";
        
        return validez
    },
  },
}
</script>