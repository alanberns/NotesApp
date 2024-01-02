<template>
  <h3>Login</h3>
  <h2>{{loginStore.msg}}</h2>
  <button type="button" @click="loginStore.increment()">Increment</button>
  <br>
</template>
<script>
export default {  
  name: 'LoginComponent',
}
</script>

<script setup>
import { useLoginStore } from '../stores/loginStore';
const loginStore = useLoginStore();
</script>