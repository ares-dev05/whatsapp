<template>
  <div class="container">
    <div class="head-row" style="margin: auto;">
      <h1 style="size: 2em;color: #FFFFFF;margin:50px auto; padding: 20px;float: left;">
        <span>Whatsapp Chat Generator</span>
        <div class="print-button">
          <button class="print-button__content" @click="makeScreen">Screenshot erstellen und Herunterladen</button>
          <a style="display: none;" id="create_screenshot_and_print" download="screenshot.png"></a>
        </div>
      </h1>
    </div>
    <div class="head-row" style="margin: auto;width: 100%;">
      <nav class="actions">
        <input type="radio" v-model="selectedOS" id="android" value="android">
        <label for="android">Android</label>
        <input type="radio" v-model="selectedOS" id="ios" value="ios">
        <label for="ios">iOS</label>
      </nav>
    </div>
    <div class="editor-row">
      <ChatInput :selectedOs="selectedOS" :emojis="IconList" :is-sender="false" @input="generateChat" :value="chatLeft" headline="Links" identifier="left"/>
      <AndroidChat :emojis="IconListAndroid" :profile-picture="profilePicture" :background-image="background" :time="time" :lastSeen="lastSeen" :name="name" v-show="selectedOS==='android'" id="chat_to_print_android" :chats="chats"/>
      <iOSChat :emojis="IconList" :profile-picture="profilePicture" :background-image="background" :time="time" :lastSeen="lastSeen" :name="name" v-show="selectedOS==='ios'" id="chat_to_print_ios" :chats="chats"/>
      <ChatInput :selectedOs="selectedOS" :emojis="IconList" :is-sender="true" @input="generateChat" :value="chatRight" headline="Rechts" identifier="right"/>
    </div>
  </div>
</template>

<script>
import AndroidChat from "./chats/AndroidChat";
import iOSChat from "./chats/iOSChat";
import ChatInput from "@/components/ChatInput";
import html2canvas from "html2canvas";
import IconList from "../../public/ios/icons.json";
import IconListAndroid from "../../public/android/icons.json";

export default {
  name: 'Container',
  components: {ChatInput, AndroidChat, iOSChat},
  data() {
    return {
      chatLeft: [],
      chatRight: [],
      chats: [],
      name: "Name",
      lastSeen: "zuletzt online heute 11:21",
      profilePicture: `${require('@/assets/images/no_profile_picture.png')}`,
      background: `${require('@/assets/images/default_wallpaper_android.png')}`,
      time: '11:50',
      selectedOS: 'android',
      IconList,
      IconListAndroid
    }
  },
  watch: {
    chatLeft() {
      this.generateChat()
    },
    chatRight() {
      this.generateChat()
    }
  },
  methods: {
    setTime(time) {
      this.time = time
    },
    setBackground(background) {
      this.background = background
    },
    setProfilePicture(profilePicture) {
      this.profilePicture = profilePicture
    },
    setName(name) {
      this.name = name
    },
    setLastSeen(lastSeen) {
      this.lastSeen = lastSeen
    },
    makeScreen() {
      let link = document.getElementById("create_screenshot_and_print")
      html2canvas(document.querySelector("#chat_to_print_"+this.selectedOS),{
        scale: 5,
        letterRendering: true,
        allowTaint: true
      }).then(canvas => {
        link.href = canvas.toDataURL("image/png");
        link.click()
      });
    },
    generateChat() {
      let tmpChatLeft = this.chatLeft
      for (let i = 0; i < tmpChatLeft.length; i++) {
        tmpChatLeft[i].sender = false
      }
      let tmpChatRight = this.chatRight
      for (let j = 0; j < tmpChatRight.length; j++) {
        tmpChatRight[j].sender = true
      }
      let fullchat = tmpChatLeft.concat(tmpChatRight)
      fullchat.sort(this.compareTwoTimes)
      this.chats = fullchat
    },
    compareTwoTimes(a, b) {
      const time_a = Date.parse('01/01/2011 ' + a.time)
      const time_b = Date.parse('01/01/2011 ' + b.time)
      if (time_a < time_b) {
        return -1;
      }
      if (time_a > time_b) {
        return 1;
      }
      return 0;
    }
  }
}
</script>
<style scoped>
.container {
  display: grid;
  height: 100%;
  grid-template-rows: 1fr 70px 600px 30px;
}

.container .editor-row {
  display: grid;
  grid-template-columns: 1fr calc(68.7mm * 1.5) 1fr;
  position: relative;
}

@media screen and (max-width: 1000px) {
  .container .editor-row {
    grid-template-columns: 1fr;
    overflow: auto;
    grid-template-rows: 300px 700px 300px;
  }

  .container .editor-row > div {
    margin: auto;
    height: 90%;
    max-width: calc(68.7mm * 1.5);
  }
}

.print-button {
  text-align: center;
}

.print-button__content {
  display: inline-block;
  cursor: pointer;
  margin-top: 1em;
  padding: 1em;
  color: white;
  text-decoration: none;
  font-size: 25px;
  box-shadow: none;
  border: 1px solid #FFFFFF;
  border-radius: 3px;
  transition: 0.3s;
  background: transparent;
}

.print-button__content:hover {
  background-color: #c40004;
}

input[type='radio'] {
  display: none;
}

label {
  padding: 10px;
  cursor: pointer;
  color: #FFFFFF;
  border: 1px solid rgba(254, 254, 254, 0.6);
  border-radius: 0;
}
input[type="radio"]:checked+label {
  background: #FFFFFF;
  color: #3a3c42;
}
.icons {
  position: absolute;
  top: 0;
  padding: 20px;
  left: 0;
  background: #FFFFFF;
  width: 100%;
  margin: auto;
}
</style>
