<template>
    <h3> New note </h3>
    <div class="row d-flex justify-content-center">
        <div class="col-9">
            <form @submit.prevent="createNote">
                <div class="mb-3">
                    <label for="title" class="form-label">Title</label>
                    <input type="text" class="form-control" id="title" v-model="note.title">
                </div>
                <div class="mb-3">
                    <label for="content" class="form-label">Content</label>
                    <textarea class="form-control" id="content" rows="3" v-model="note.content"></textarea>
                </div>
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
                <button type="submit" name="action" class="btn btn-warning">Create</button>
            </form>
            <div class="d-grid gap-2 d-md-block d-md-flex justify-content-md-center p-2">
                <router-link to="/"><button type="button" class="btn btn-warning">Cancel</button></router-link>
            </div>        
        </div>
    </div>
</template>
<script>
import { axiosService } from "../../axios";
import {useAlertStore} from '../../stores/alertStore'
export default {
    name:"NewNote",
    setup() {
        const alertStore = useAlertStore();
        return { alertStore };
    },
    data() {
        return {
            categories: [],
            note: {
                title:"",
                content:"",
            },
            note_categories: []
        }
    },
    mounted(){
        axiosService.get("/categories", {
            headers: {
                Authorization: `${localStorage.getItem("token")}`,
            },
            })
            .then(response => {
                this.categories = response.data
            })
            .catch(e => {
                this.alertStore.setError(e);
            })
    },
    methods: {
        createNote: async function(){
            let validationResult = this.validateNote(this.note)
            if ( validationResult != "true"){
                this.alertStore.setError(validationResult);
            }
            else{
                await axiosService.post("/notes",
                    {   
                        note: this.note,
                        categories: this.note_categories
                    },
                    {   
                        headers: {
                            Authorization: `${localStorage.getItem("token")}`,
                        },
                    })
                    .then(() => {
                        this.alertStore.setInfo("Note created");
                        this.$router.push("/");
                    })
                    .catch(e => {
                        this.alertStore.setError(e);
                    })
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
            
            var regexTitle = /^[a-zA-Z0-9.,*?¿¡!#$]{3,100}$/;
            var regexContent = /^[a-zA-Z0-9.,*?¿¡!#$]{0,1000}$/;
            
            if(!regexTitle.test(note.title)) validez = "Ingrese un title válido.";
            else if(!regexContent.test(note.content)) validez = "Ingrese un content válido.";
            
            
            return validez
        }
    }
}
</script>