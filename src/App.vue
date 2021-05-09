<template>
  <div id="app">
    <Container />
  </div>
</template>

<script>

import Container from "@/components/Container";
export default {
  name: 'App',
  components: {
    Container
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  height: 100vh;
  width: 100%;
  overflow: hidden;
  position: relative;
  background-image: linear-gradient(to right top, #051937, #131a31, #1b1c2c, #1f1e26, #212121);
}
</style>
