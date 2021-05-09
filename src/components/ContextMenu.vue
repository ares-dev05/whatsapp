<template>
  <div class="context-menu" v-show="show" :style="style" ref="context" @blur="close">
    <slot></slot>
  </div>
</template>

<script>
import Vue from 'vue';
export default {
  name: "ContextMenu",
  props: {
    display: Boolean,
  },
  data() {
    return {
      left: 0,
      top: 0,
      show: false,
    };
  },
  computed: {
    style() {
      return {
        top: this.top + 'px',
        left: this.left + 'px',
      };
    },
  },
  methods: {
    close() {
      this.show = false;
      this.left = 0;
      this.top = 0;
    },
    open(evt) {
      this.left = evt.pageX || evt.clientX;
      this.top = evt.pageY || evt.clientY;
      evt.preventDefault()
      Vue.nextTick(() => this.$el.focus());
      this.show = true;
    },
    isOpen() {
      return this.show
    }
  }
}
</script>
<style>
.context-menu {
  position: fixed;
  z-index: 999;
  display: flex;
  flex-direction: column;
  background-color: var(--color-bg-secondary);
  border-radius: 10px;
  box-shadow: 0 10px 20px rgba(64, 64, 64, 0.15);
  cursor: pointer;
  --color-bg-primary: #d0d6df;
  --color-bg-primary-offset: #f1f3f7;
  --color-bg-secondary: #fff;
  --color-text-primary: #3a3c42;
  --color-text-primary-offset: #898c94;
  --color-orange: #dc9960;
  --color-green: #1eb8b1;
  --color-purple: #657cc4;
  --color-black: var(--color-text-primary);
  --color-red: #d92027;
}
.context-menu .menu {
  display: flex;
  flex-direction: column;
  background-color: var(--color-bg-secondary);
  border-radius: 10px;
  box-shadow: 0 10px 20px rgba(64, 64, 64, 0.15);
}

.context-menu .menu-list {
  margin: 0;
  display: block;
  width: 100%;
  padding: 8px;
  list-style: none;
}
.context-menu .menu-list + .menu-list {
  border-top: 1px solid #ddd;
}

.context-menu .menu-sub-list {
  display: none;
  padding: 8px;
  background-color: var(--color-bg-secondary);
  border-radius: 10px;
  box-shadow: 0 10px 20px rgba(64, 64, 64, 0.context-menu .15);
  position: absolute;
  left: 100%;
  right: 0;
  z-index: 100;
  width: 100%;
  top: 0;
  flex-direction: column;
}
.context-menu .menu-sub-list:hover {
  display: flex;
}

.context-menu .menu-item {
  position: relative;
}

.context-menu .menu-button {
  font: inherit;
  border: 0;
  padding: 8px 8px;
  padding-right: 36px;
  width: 100%;
  border-radius: 8px;
  display: flex;
  cursor: pointer;
  align-items: center;
  position: relative;
  background-color: var(--color-bg-secondary);
}
.context-menu .menu-button:hover {
  background-color: var(--color-bg-primary-offset);
}
.context-menu .menu-button:hover + .context-menu .menu-sub-list {
  display: flex;
}
.context-menu .menu-button:hover i {
  color: var(--color-text-primary);
}
.context-menu .menu-button i {
  margin-right: 15px;
  color: var(--color-text-primary-offset);
}
.context-menu .menu-button i:nth-of-type(2) {
  margin-right: 0;
  position: absolute;
  right: 8px;
}
.context-menu .menu-button--delete:hover {
  color: var(--color-red);
}
.context-menu .menu-button--delete:hover i:first-of-type {
  color: var(--color-red);
}
.context-menu .menu-button--orange i:first-of-type {
  color: var(--color-orange);
}
.context-menu .menu-button--green i:first-of-type {
  color: var(--color-green);
}
.context-menu .menu-button--purple i:first-of-type {
  color: var(--color-purple);
}
.context-menu .menu-button--black i:first-of-type {
  color: var(--color-black);
}
.context-menu .menu-button--checked i:nth-of-type(2) {
  color: var(--color-purple);
}
</style>