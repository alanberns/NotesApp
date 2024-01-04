<template>
    <h3> My profile</h3>
    <div class="row d-flex justify-content-center">
        <div class="col-8 p-2">
            <form @submit.prevent="editProfile">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" v-model="data.username">
                </div>
                <button type="submit" name="action" class="btn btn-warning">Edit</button>
                </form>
        </div>
        <div class="d-grid gap-2 d-md-block d-md-flex justify-content-md-center p-2">
            <router-link to="/me"><button type="button" class="btn btn-warning">Cancel</button></router-link>
        </div>
    </div>
</template>
<script>
import { axiosService } from "../../axios";
import {useLoginStore} from '../../stores/loginStore'
import {useAlertStore} from '../../stores/alertStore'
import router from "../../router";
export default {
    name: "EditProfile",
    setup() {
        const loginStore = useLoginStore();
        const alertStore = useAlertStore();
        return { loginStore, alertStore };
    },
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
        editProfile: async function(){
            await axiosService.put("/user",{
                username: this.data.username},
                {   
                    headers: {
                        Authorization: `${localStorage.getItem("token")}`,
                    },
                })
            .then(response => {
                    // JSON responses are automatically parsed.
                    this.data = response.data;
                    this.loginStore.user=this.data.username
                    this.alertStore.setInfo("Cambios guardados");
                    router.push("/me");
                })
                .catch(e => {
                    this.errors.push(e)
                })
            }
        }
    }
</script>