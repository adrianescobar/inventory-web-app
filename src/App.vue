<template>
  <div id="app">
    <Navbar />
    <div class="container mt-4">
      <router-view />
    </div>
  </div>
</template>

<script setup lang="ts">
  import Navbar from './components/Navbar.vue';
</script>

<style>
body {
  font-family: Arial, sans-serif;
}
.container {
  padding: 20px;
}
</style>

