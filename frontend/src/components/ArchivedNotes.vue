<template>
    <h3> Archived notes</h3>
    <div class="">
        <div class="d-grid gap-2 d-md-block d-md-flex justify-content-md-center p-2">
            <router-link to="/"><button type="button" class="btn btn-warning">Active notes</button></router-link>
        </div>
        <div v-if="data" class="row justify-content-start p-2">
            <NoteBox
                v-for="note in data"
                v-bind:key="note.id"
                v-bind:note="note"
            ></NoteBox>
        </div>
        <div v-else >
            Aún no hay notas archivadas
        </div>

        
    </div>
</template>
<script>
import NoteBox from './NoteBox.vue'
export default {
    components: {
        NoteBox,
    },
    data() {
        return {
            data: [],
        }
    },
    // Fetches posts when the component is created.
    mounted() {
        this.axios.get('/notes/archived')
        .then(response => {
            // JSON responses are automatically parsed.
            this.data = response.data;
        })
        .catch(e => {
            console.log(e)//this.alertStore.setError(e);
        })
    }
}
</script>