import { defineStore } from "pinia";
export const useAlertStore = defineStore("alertStore", {
  state: () => ({
    info: "",
    error: "",
  }),
  actions: {
    setError(value) {
      this.error = value;
    },
    setInfo(value){
        this.info = value;
    }
  },
});