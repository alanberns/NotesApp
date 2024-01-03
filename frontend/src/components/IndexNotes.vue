<template>
    <h3> My notes</h3>
    <div class="">
        <div class="d-grid gap-2 d-md-block d-md-flex justify-content-md-center p-2">
            <router-link to="/archived"><button type="button" class="btn btn-warning">Archived notes</button></router-link>
        </div>
        <div v-if="data" class="row justify-content-start p-2 m-0">
            <NoteBox
                v-for="note in data"
                v-bind:note="note"
                v-bind:key="note.id"
            ></NoteBox>
        </div>
        <div v-else >
            Aún no hay notas
        </div>

        
    </div>
</template>
<script>
import { axiosService } from "../axios";
import NoteBox from './NoteBox.vue'
export default {
    components: {
        NoteBox,
    },
    data() {
        return {
            data: [],
            errors: []
        }
    },
    // Fetches posts when the component is created.
    mounted() {
        axiosService.get("/notes", {
            headers: {
                Authorization: `${localStorage.getItem("token")}`,
            },
        })
        .then(response => {
            // JSON responses are automatically parsed.
            this.data = response.data;
        })
        .catch(e => {
            this.errors.push(e)
        })
    }
}
</script>