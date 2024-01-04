<template>
    <h3> My profile</h3>
    <div class="row d-flex justify-content-center">
        <div class="col-8 p-2">
            <table class="table table-bordered table-hover">
                <tbody>
                    <tr>
                    <th scope="row">Username</th>
                        <td>{{data.username}}</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="d-grid gap-2 d-md-block d-md-flex justify-content-md-center p-2">
            <router-link to="/me/edit"><button type="button" class="btn btn-warning">Edit</button></router-link>
            <router-link to="/"><button type="button" class="btn btn-danger" v-on:click.prevent="confirmDelete">Delete profile</button></router-link>
        </div>
    </div>
</template>
<script>
import { axiosService } from "../../axios";
import router from "../../router";
export default {
    name: "MyProfile",
    data() {
        return {
            data: [],
            errors: []
        }
    },
    // Fetches posts when the component is created.
    mounted() {
        axiosService.get("/user/", {
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
    },
    methods: {
        confirmDelete: function (){
            if (confirm("¿Estás seguro de eliminar tu cuenta?") == true){
                axiosService.delete("/user/", {
                    headers: {
                        Authorization: `${localStorage.getItem("token")}`,
                    },
                })
                .then(response => {
                    // JSON responses are automatically parsed.
                    this.data = response.data;
                    router.push("/");
                })
                .catch(e => {
                    this.errors.push(e)
                })
            }
        }
    }
}
</script>