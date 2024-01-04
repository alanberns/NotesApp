<template>
  <NavbarComponent></NavbarComponent>
  <AlertsComponent></AlertsComponent>
  <br>
  <h1>Notes app</h1>
  <br>
  <router-view></router-view>
</template>

<script>
import NavbarComponent from './components/partials/NavbarComponent';
import AlertsComponent from './components/partials/AlertsComponent.vue';
export default {
  name: 'App',
  components: {
    NavbarComponent,
    AlertsComponent
  }
}
</script>

<style>
</style>
