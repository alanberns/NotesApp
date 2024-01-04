<template>
    <div class="row d-flex justify-content-center" v-if="alertStore.info || alertStore.error">
        <div class="p-1 col-9">
            <div class="alert alert-success alert-dismissible fade show" role="alert" v-if="alertStore.info">
                {{alertStore.info}}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" @click="closeAlert"></button>
            </div>
            <div class="alert alert-danger alert-dismissible fade show" role="alert" v-if="alertStore.error">
                {{alertStore.error}}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" @click="closeAlert"></button>
            </div>
        </div>
    </div>
</template>

<script>
import {useAlertStore} from '../../stores/alertStore'

export default {
    name: "AlertsComponent",
    setup() {
      const alertStore = useAlertStore();
      return { alertStore };
    },
    methods: {
        closeAlert: function(){
            this.alertStore.error="";
            this.alertStore.info="";
        }
    }
}
</script>