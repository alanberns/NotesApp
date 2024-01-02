import { defineStore } from 'pinia';

export const useLoginStore = defineStore('login', {
    state: () => ({
        msg: 0
    }),

    actions: {
        increment(){
            this.msg++;
        }
    },

    getters: {
        totalMsg() {
            return this.msg
        }
    }
})