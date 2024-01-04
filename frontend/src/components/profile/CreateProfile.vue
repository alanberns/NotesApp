<template>
    <h3> Create your account </h3>
    <div class="row d-flex justify-content-center">
        <div class="col-8 p-2">
            <form @submit.prevent="createProfile">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" v-model="data.username">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" v-model="data.password">
                </div>
                <button type="submit" name="action" class="btn btn-warning">Create</button>
            </form>
        </div>
    </div>
</template>
<script>
import { axiosService } from "../../axios";
import {useLoginStore} from '../../stores/loginStore'
import {useAlertStore} from '../../stores/alertStore'
import router from "../../router";
export default {
    name: "CreateProfile",
    setup() {
        const loginStore = useLoginStore();
        const alertStore = useAlertStore();
        return { loginStore, alertStore };
    },
    data() {
        return {
            data: [],
        }
    },
    methods: {
        createProfile: async function(){
            await axiosService.post("/user/create",
                {   
                    username: this.data.username,
                    password: this.data.password,
                })
            .then(response => {
                this.data = response.data
                this.alertStore.setInfo("Bienvenido a Notes app, inicie sesión");
                router.push("/");
                })
                .catch(e => {
                    this.alertStore.setError(e);
                })
            }
        }
    }
</script>