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
                    <label for="categories" class="form-label">Categories</label>
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
            data:[],
            note: {
                title:"",
                content:""
            },
        }
    },
    methods: {
        createNote: async function(){
            await axiosService.post("/notes",
                {   
                    note: this.note
                },
                {   
                headers: {
                    Authorization: `${localStorage.getItem("token")}`,
                },
                })
            .then(response => {
                this.data = response.data
                this.alertStore.setInfo("Note created");
                this.$router.push("/");
                })
                .catch(e => {
                    this.alertStore.setError(e);
                })
            }
        }
}
</script>