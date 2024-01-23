<template>
    <h3> My notes</h3>
    <div class="">
        <div class="d-grid gap-2 d-md-block d-md-flex justify-content-md-center p-2">
            <router-link to="/archived"><button type="button" class="btn btn-warning">Archived notes</button></router-link>
        </div>
        <div class="row d-flex justify-content-center p-3">
            <div class="col-6 form-floating">
                <select id="floatingSelect" class="form-select form-select-sm" aria-label="Default select example" v-model="search.category">
                    <option v-for="category in categories" v-bind:key="category.id" :value=category.id>{{category.name}}</option>
                </select>
                <label for="floatingSelect">Select a category</label>
            </div>
            <div class="col-1">
                <button class="btn btn-outline-warning" type="button" @click="searchNotes">Search</button>
            </div>
        </div>
        <div v-if="data.length" class="row justify-content-start p-2 m-0">
            <NoteBox
                v-for="(note, index) in data"
                v-bind:note="note"
                v-bind:key="note.id"
                @refresh="updateNotes(index)"
            ></NoteBox>
        </div>
        <div v-else >
            Aún no hay notas
        </div>
    </div>
</template>
<script>
import { axiosService } from "../axios";
import {useAlertStore} from '../stores/alertStore'
import NoteBox from './NoteBox.vue'
export default {
    name: "IndexNotes",
    setup() {
        const alertStore = useAlertStore();
        return { alertStore };
    },
    components: {
        NoteBox,
    },
    data() {
        return {
            categories: [],
            data: [],
            search:{
                category: String
            }
        }
    },
    mounted() {
        axiosService.get("/notes", {
            headers: {
                Authorization: `${localStorage.getItem("token")}`,
            },
        })
        .then(response => {
            this.data = response.data;
        })
        .catch(e => {
            this.alertStore.setError(e);
        })
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
        updateNotes: function (index) {
            this.data.splice(index,1)
        },
        searchNotes: function (){
            axiosService.get("/notes", {
                params: {
                    search: this.search
                },
                headers: {
                    Authorization: `${localStorage.getItem("token")}`,
                },
            })
            .then(response => {
                this.data = response.data;
            })
            .catch(e => {
                this.alertStore.setError(e);
            })
        }  
    },
}
</script>