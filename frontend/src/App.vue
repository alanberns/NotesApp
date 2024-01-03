<template>
  <NavbarComponent></NavbarComponent>
  <br>
  <h1>Notes app</h1>
  <br>
  <router-view></router-view>
</template>

<script>
import NavbarComponent from './components/partials/NavbarComponent';
export default {
  name: 'App',
  components: {
    NavbarComponent
  }
}
</script>

<style>
</style>
