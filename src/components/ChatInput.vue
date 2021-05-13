<template>
  <div class="ChatInput">
    <h1>{{ headline }}</h1>
    <hr>
    <div class="scroll-container">
      <input :id="'upload-image-to-message-'+identifier" :ref="'upload-image-to-message-'+identifier" accept="image/*" style="display: none;" type="file"
             @change="addImageToMessage"/>
      <div class="text-line" v-for="(item, indx) in localValue" :key="'chat_'+identifier+'_'+indx">
        <i class="material-icons red-icon" @click="removeElement(indx)">delete</i>
        <select v-if="isSender===true" @change="updateState(indx, $event.target.value)" :class="['state-select','material-icons',(item.state==='read')?'checkmark':'']" >
          <option value="send" class="material-icons" style="color: #000000" :selected="item.state==='send'">&#xe876;</option>
          <option value="received" style="color: #000000" class="material-icons" :selected="item.state==='received'">&#xe877;</option>
          <option class="material-icons checkmark" value="read" :selected="item.state==='read'">&#xe877;</option>
        </select>
        <input class="empty-input" @change="updateValue" v-model="localValue[indx].message"/>
        <input
          @change="updateValue"
          class="empty-input"
          placeholder="Nachricht einfügen"
          v-model="localValue[indx].time"/>
        <br>
        <div class="image-display">
          <div class="add-image" @click="addMessageImage(indx)">
            <i class="material-icons">add</i>
          </div>
          <img v-for="(img, i) in item.images" @click="removeImage(indx,i)" :src="img" :key="'temp_image_display_message_'+i+'_'+indx"/>
        </div>
      </div>
      <div :id="'empty-container-'+identifier" style="height: 20px;visibility: hidden">
        <i class="material-icons red-icon">delete</i>
        <input class="empty-input" value=""/><input
          class="empty-input"
          value=""/>
      </div>
    </div>
    <div class="temp-image-display">
      <img v-for="(img, indx) in tmpFiles" :src="img" :key="'temp_image_display_'+indx"/>
    </div>
    <input :id="'upload-image-'+identifier" accept="image/*" multiple style="display: none;" type="file"
           @change="addimage"/>
    <label :for="'upload-image-'+identifier">
    <span class="text-input-icon">
      <i class="material-icons">image</i>
    </span>
    </label>
    <form v-on:submit="submitform">
      <input type="text" ref="newmessageinput" v-model="newmessageinput" class="text-input-message" placeholder="Nachricht"/>
    </form>
    <span class="text-input-icon right" @click="addmessage">
      <i class="material-icons">send</i>
    </span>
    <span class="text-input-icon right next" @click="displayicon=!displayicon;">
      <i class="material-icons">emoji_emotions</i>
    </span>
    <div class="icons" v-if="displayicon">
      <span class="material-icons" v-show="page > 0" @click="page--">navigate_before</span>
      <span class="material-icons" v-show="page < maxPages" @click="page++">navigate_next</span>
      <img :src="selectedOs + '/' + value" @click="selectEmojis(indx)" :title="value" v-for="(value, indx) in displayIcons" :key="'icon_'+indx" width="32px" height="32px"/>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "ChatInput",
  props: {
    value: Array,
    selectedOs: String,
    headline: String,
    emojis: Array,
    identifier: String,
    isSender: Boolean,    
  },
  data() {
    return {
      localValue: this.value,
      newmessageinput: "",
      showContextMenu: false,
      tmpFiles: [],
      displayicon: false,
      localSelectedMessage: -1,
      page: 0,
      serverIp: "http://192.168.109.22"
    }
  },
  watch: {
    localValue(val) {
      this.$emit('input', val)
    }
  },
  computed: {
    maxPages() {
      let perPage = 47;
      return this.emojis.length / perPage
    },
    displayIcons() {
      let result = {}
      let counter = 0;
      let perPage = 47;
      let counterStart = this.page*perPage
      let counterEnd = counterStart+perPage
      for(const key in this.emojis) {
        if(counter++ > counterEnd) {
          return result
        }
        if(counter > counterStart)
        {
          result[key] = this.emojis[key]
        }
      }
      return result
    }
  },
  methods: {
    log(title, message) {
      console.groupCollapsed(title);
      console.log("message", message);
      console.groupEnd();
    },
    addMessageImage(indx) {
      this.localSelectedMessage = indx
      this.$refs['upload-image-to-message-'+this.identifier].click();
    },
    addImageToMessage(e) {
      let self = this;
      for (let i = 0; i < e.target.files.length; i++) {
        let formData = new FormData();
        formData.append("file", e.target.files[i]);
        axios
          .post(self.serverIp + "/api/image_insert", formData, {
            headers: {
              "Content-Type": "multipart/form-data"
          }})
          .then(function (response) {
            let url =  self.serverIp + response.data.file_path;
            self.localValue[self.localSelectedMessage].images.push(url)
          })
          .catch(function (error) {
            self.log("error", error);
          });
        
      }
    },
    removeElement(i) {
      this.localValue.splice(i, 1)
    },
    submitform(e) {
      e.preventDefault()
      this.addmessage()
      return false;
    },
    addmessage() {
      let message = this.newmessageinput
      if(message.length <= 0 && this.tmpFiles.length <= 0)
      {
        return
      }
      let date = new Date()
      this.localValue.push({
        message: message,
        time: ("0" + date.getHours()).slice(-2) + ":" + ("0" + date.getMinutes()).slice(-2) + ":" + ("0" + date.getSeconds()).slice(-2),
        images: this.tmpFiles,
        state: 'send'
      })
      let last_chat_element = document.getElementById("empty-container-" + this.identifier)
      last_chat_element.scrollIntoView({behavior: 'smooth'});
      this.newmessageinput = ""
      this.displayicon = false
      this.tmpFiles = []
    },
    addimage(e) {
      let self = this;
      for (let i = 0; i < e.target.files.length; i++) {
        let formData = new FormData();
        formData.append("file", e.target.files[i]);
        axios
          .post(self.serverIp + "/api/image_insert", formData, {
            headers: {
              "Content-Type": "multipart/form-data"
          }})
          .then(function (response) {
            let url =  self.serverIp + response.data.file_path;
            self.tmpFiles.push(url);
          })
          .catch(function (error) {
            self.log("error", error);
          });
      }
    },
    removeImage(indx, i) {
      this.localValue[indx].images.splice(i,1)
    },
    updateValue() {
      this.$emit('input', this.localValue)
    },
    updateState(indx, value) {
      this.localValue[indx].state = value
      this.$emit('input', this.localValue)
    },
    selectEmojis(indx) {
      let messageInput = this.$refs.newmessageinput;
      let cursorPosition = messageInput.selectionStart;
      this.newmessageinput = this.newmessageinput.substr(0, cursorPosition) + ':' + indx + ':' + this.newmessageinput.substr(cursorPosition, messageInput.length);
    }
  }
}
</script>

<style scoped>
.icons {
  position: absolute;
  bottom: 50px;
  width: 100%;
  padding: 20px;
  background: #FFFFFF;
  left: 0;
}
.icons > span {
  color: #333333;
  position: absolute;
  left: 0;
  top: 40%;
  cursor: pointer;
  font-size: 2.5em;
}
.icons >span:nth-child(2) {
  right: 0;
  left: auto;
}
.icons > img {
  margin: 10px;
}
.ChatInput {
  width: 90%;
  position: relative;
  margin: 0 auto;
  color: #FFFFFF;
  overflow: hidden;
}

.image-display {
  height: 50px;
  cursor: pointer;
}

.image-display .add-image {
  height: 50px;
  border: 1px solid #FFFFFF;
  width: 50px;
  line-height: 70px;
  float: left;
  text-align: center;
}

.image-display .add-image i {
  font-size: 3em;
}

.image-display img {
  height: 100%;
  margin: 0 2px;
  border: 2px solid #FFFFFF;
}

.temp-image-display {
  position: absolute;
  bottom: 50px;
  height: 50px;
}

.temp-image-display img {
  height: 100%;
  margin: 0 2px;
  border: 2px solid #FFFFFF;
}

.scroll-container {
  height: 80%;
  overflow: auto;
}

.text-line {
  text-align: left;
  position: relative;
  margin: 20px 0;
}

.red-icon {
  color: #ff7961;
  cursor: pointer;
  top: 0;
  left: 15px;
  font-size: 1em;
  position: absolute;
}

.state-select {
  cursor: pointer;
  top: 15px;
  font-size: 1.1em;
  background: transparent;
  position: absolute;
  border:none;
  color: #FFFFFF;
}

.state-select:focus {
  outline: none;
  border:none;
}

.empty-input {
  font-size: 16px;
  background: transparent;
  color: #fff;
  border: none;
  width: calc(100% - 54px);
  margin-left: 54px;
}

.text-input-message {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  box-shadow: none;
  font-size: 1.5em;
  background: transparent;
  border: 0;
  border-bottom: 2px solid #FFFFFF;
  color: #ffffff;
  padding: 5px 40px;
}

input:focus {
  box-shadow: none;
  outline: none;
}

.text-input-icon {
  position: absolute;
  bottom: 0;
  left: 0;
  cursor: pointer;
  z-index: 5;
  padding: 5px 0;
}

.text-input-icon i {
  font-size: 2em;
  cursor: pointer;
}

.text-input-icon.right {
  right: 0;
  left: auto;
}
.text-input-icon.right.next {
  right: 50px;
  left: auto;
}
.checkmark {
  color: var(--whatsapp-chat-checkmark);
}
</style>