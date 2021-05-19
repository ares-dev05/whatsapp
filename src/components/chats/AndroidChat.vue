<template>
  <div @contextmenu="openContextMenu" @click="closeContextMenu">
    <div class="android-headbar" @contextmenu="contextmenuValue='headbar-context'">
      <span class="time align-left" id="layout_time_android"  @input="timeChanged" contenteditable="true">{{ time }}</span>
      <span class="align-right" v-if="icons.battery==='charge'"><i
          class="material-icons">battery_charging_full</i></span>
      <span class="align-right" v-else-if="icons.battery==='full'">
        <div class="batteryContainer">
          <div class="batteryOuter"><div id="batteryLevel" :style="batteryCharge"></div></div>
          <div class="batteryBump"></div>
        </div>
      </span>
      <span class="time align-right" contenteditable="true" id="batterytext" v-show="icons.showbatterytext">100 %</span>
      <span class="align-right" v-if="icons.sim==='none'"><i class="material-icons">signal_cellular_no_sim</i></span>
      <span class="align-right" v-if="icons.sim==='off'"><i class="material-icons">signal_cellular_off</i></span>
      <span class="align-right" v-if="icons.sim==='full'"><i class="material-icons">signal_cellular_4_bar</i></span>
      <span class="align-right" v-if="icons.wifi==='full'"><i class="material-icons">network_wifi</i></span>
      <span class="align-right" v-else-if="icons.wifi==='off'"><i class="material-icons">signal_wifi_off</i></span>
      <span class="align-right" v-if="icons.rotate==='on'"><i class="material-icons">screen_rotation</i></span>
      <span class="align-right" v-else-if="icons.rotate==='locked'"><i
          class="material-icons">screen_lock_rotation</i></span>
    </div>
    <div class="whatsapp-chat" v-bind:style="{ background: 'url(' + backgroundImage + ') no-repeat center center/cover', height: chatsHeight + 'px'}">
      <div class="whatsapp-chat-header" @contextmenu="contextmenuValue='name-context'">
        <div class="whatsapp-chat-header__back">
          <i class="material-icons">&#xe5c4;</i>
          <input accept="image/*" style="display: none;" id="profile-picture" type="file" @change="onFileChange"/>
          <label for="profile-picture">
            <img class="whatsapp-chat-header__back-photo" :src="profilePicture" alt="">
          </label>
        </div>

        <div class="whatsapp-chat-header__name">
          <p id="contactname_android" contenteditable="true" @input="nameChanged" v-html="replaceEmojis(name)"></p>
          <p id="conection_android" contenteditable="true" v-if="icons.displayLastOnline" @input="lastSeenChanged">{{ lastSeen }}</p>
        </div>

        <div class="whatsapp-chat-header__calls">
          <ul class="whatsapp-chat-header__calls-items">
            <li><i class="material-icons">&#xe04b;</i></li>
            <li><i class="material-icons">&#xe0b0;</i></li>
            <li><i class="material-icons">&#xe5d4;</i></li>
          </ul>
        </div>
      </div>

      <div class="whatsapp-chat-messages" @contextmenu="contextmenuValue='chat-context'">
        <div class="chats" id="chats">
          <div class="whatsapp-chat-messages__protection" v-if="displayEndToEnd">
            <i class="material-icons">lock</i> Nachrichten in diesem Chat sowie Anrufe sind jetzt mit
            Ende-zu-Ende-Verschlüsselung geschützt. Tippe für mehr Infos.
          </div>

          <div v-for="(chat, indx) in chats" :key="'chatmessage_'+indx"
               :class="['whatsapp-chat-message',(chat.sender)?'whatsapp-chat-messages__sender':'whatsapp-chat-messages__receiver']">
            <div class="whatsapp-image" v-if="chat.images.length === 1">
              <div class="overlay" v-if="chat.message.length <=0"></div>
              <img style="width: 100%;" :src="chat.images[0]" />
            </div>
            <div class="whatsapp-image" v-else-if="chat.images.length > 1">
              <div class="sub-image" v-for="(img, imgindx) in chat.images.slice(0,4)" :key="'image_display_'+indx+'_'+imgindx" style="position:relative;float:left;width: 146px; margin: 1.3px; border-radius: 5px; height: 146.78px">
                <div class="overlay" v-if="chat.images.length <= 4 || imgindx < 3"></div>
                <div class="overlay-plus" v-else>+ {{ chat.images.length - 4 }}</div>
                <span :class="['whatsapp-chat-messages__datetime','multiple-images']">{{ chat.time.slice(0,5) }}
                <span v-if="chat.sender">
                <i class="material-icons checkmark" v-if="chat.state==='read'">&#xe877;</i>
                <i class="material-icons" v-else-if="chat.state==='received'">&#xe877;</i>
                <i class="material-icons" v-else>&#xe876;</i>
                </span></span>
                <img :class="[(chat.images.length > 4 && imgindx === 3)?'imgage-blur':'']" :src="img" style="width: 100%; height: 100%; object-fit: cover"/>
              </div>
            </div>
            <span v-html="replaceEmojis(chat.message) + generateMessageTime(chat)">
            </span>
            <span v-if="chat.message.length >0 || chat.images.length <= 1" :class="['whatsapp-chat-messages__datetime',(chat.message.length <=0 && chat.images.length > 0)?'no-text':'']">
              {{ chat.time.slice(0,5) }}
              <span v-if="chat.sender">
                <i class="material-icons checkmark" v-if="chat.state==='read'">&#xe877;</i>
                <i class="material-icons" v-else-if="chat.state==='received'">&#xe877;</i>
                <i class="material-icons" v-else>&#xe876;</i>
              </span>
            </span>
          </div>
          <div class="whatsapp-chat-message whatsapp-chat-messages__receiver" id="last-chat-element-android" style="height: 1px;margin-top:30px;visibility: hidden">
            <span class="whatsapp-chat-messages__datetime">
            </span>
          </div>
        </div>
      </div>

      <div class="whatsapp-chat-send">
        <div class="whatsapp-chat-send__write">
			<span>
				<i class="material-icons">&#xe24e;</i>
			</span>
          <input type="text" placeholder="">
          <ul>
            <li>
              <i class="material-icons rt">attach_file</i>
            </li>
            <li class="material-icons">camera_alt</li>
          </ul>
        </div>

        <div class="whatsapp-chat-send__record">
          <i class="material-icons">&#xe31d;</i>
        </div>
      </div>
    </div>

    <input type="file" accept="image/*" id="background-upload" @change="onFileChangeBackground" style="display: none"/>

    <context-menu :display="showContextMenu" ref="menu">
      <div v-if="contextmenuValue==='chat-context'">
        <ul class="menu-list">
          <li class="menu-item" v-if="displayEndToEnd">
            <button @click="displayEndToEnd = false" class="menu-button"><i class="material-icons">visibility_off</i>Ende-zu-Ende
              ausblenden
            </button>
          </li>
          <li class="menu-item" v-else>
            <button @click="displayEndToEnd = true" class="menu-button"><i class="material-icons">visibility</i>Ende-zu-Ende
              einblenden
            </button>
          </li>
          <li class="menu-item">
            <button @click="selectBackground" class="menu-button"><i class="material-icons">image</i>Hintergrundbild
              ändern
            </button>
          </li>
        </ul>
      </div>
      <div v-if="contextmenuValue==='name-context'">
        <ul class="menu-list">
          <li class="menu-item" v-if="icons.displayLastOnline">
            <button @click="icons.displayLastOnline = false" class="menu-button"><i class="material-icons">visibility_off</i>Zuletzt Online
              ausblenden
            </button>
          </li>
          <li class="menu-item" v-else>
            <button @click="icons.displayLastOnline = true" class="menu-button"><i class="material-icons">visibility</i>Zuletzt Online
              einblenden
            </button>
          </li>
        </ul>
      </div>
      <div v-else-if="contextmenuValue==='headbar-context'">
        <ul class="menu-list">
          <li class="menu-item" v-if="icons.wifi!=='full'">
            <button @click="icons.wifi='full';" class="menu-button"><i
                class="material-icons">network_wifi</i>WLAN Anzeigen
            </button>
          </li>
          <li class="menu-button" v-if="icons.wifi!=='off'">
            <button @click="icons.wifi='off';" class="menu-button"><i
                class="material-icons">signal_wifi_off</i>WLAN ausgestellt Anzeigen
            </button>
          </li>
          <li class="menu-button" v-if="icons.wifi!==''">
            <button @click="icons.wifi='';" class="menu-button"><i
                class="material-icons">visibility_off</i>WLAN nicht Anzeigen
            </button>
          </li>
        </ul>
        <ul class="menu-list">
          <li class="menu-item" v-if="icons.battery!=='full'">
            <button @click="icons.battery='full';"
                    class="menu-button"><i class="material-icons">battery_full</i>Batterie Regulär Anzeigen
            </button>
          </li>
          <li class="menu-item" v-if="icons.battery!=='charge'">
            <button @click="icons.battery='charge';"
                    class="menu-button"><i class="material-icons">battery_charging_full</i>Batterie Lädt
            </button>
          </li>
          <li class="menu-item" v-if="icons.battery!==''">
            <button @click="icons.battery='';" class="menu-button"><i
                class="material-icons">visibility_off</i>Batterie nicht Anzeigen
            </button>
          </li>
        </ul>
        <ul class="menu-list">
          <li class="menu-item">
            <button v-if="!icons.showbatterytext" @click="icons.showbatterytext=true;"
                    class="menu-button"><i class="material-icons">visibility</i>Batterie % Anzeigen
            </button>
            <button v-else @click="icons.showbatterytext=false;" class="menu-button"><i
                class="material-icons">visibility_off</i>Batterie % nicht Anzeigen
            </button>
          </li>
        </ul>
        <ul class="menu-list">
          <li class="menu-item" v-if="icons.sim!=='none'">
            <button @click="icons.sim='none';"
                    class="menu-button"><i class="material-icons">signal_cellular_no_sim</i>Keine Simkarte
            </button>
          </li>
          <li class="menu-item" v-if="icons.sim!=='off'">
            <button @click="icons.sim='off';"
                    class="menu-button"><i class="material-icons">signal_cellular_off</i>Sim aus
            </button>
          </li>
          <li class="menu-item" v-if="icons.sim!=='full'">
            <button @click="icons.sim='full';"
                    class="menu-button"><i class="material-icons">signal_cellular_4_bar</i>Sim an
            </button>
          </li>
          <li class="menu-item" v-if="icons.sim!==''">
            <button @click="icons.sim='';" class="menu-button"><i
                class="material-icons">visibility_off</i>Sim nicht Anzeigen
            </button>
          </li>
        </ul>
        <ul class="menu-list">
          <li class="menu-item">
            <button v-if="icons.rotate!=='on'" @click="icons.rotate='on';"
                    class="menu-button"><i class="material-icons">screen_rotation</i>Rotation Anzeigen
            </button>
            <button v-if="icons.rotate!=='locked'" @click="icons.rotate='locked';"
                    class="menu-button"><i class="material-icons">screen_lock_rotation</i>Gesperrte Rotation Anzeigen
            </button>
            <button v-if="icons.rotate!==''" @click="icons.rotate='';"
                    class="menu-button"><i class="material-icons">visibility_off</i>Rotation nicht Anzeigen
            </button>
          </li>
        </ul>
      </div>
    </context-menu>
  </div>
</template>

<script>
import ContextMenu from "@/components/ContextMenu";
import axios from "axios";

export default {
  name: "AndroidChat",
  components: {ContextMenu},
  props: {
    chats: Array,
    name: String,
    time: String,
    lastSeen: String,
    profilePicture: String,
    backgroundImage: String,
    emojis: Array,
    chatsHeight: String
  },
  data() {
    return {
      showContextMenu: false,
      displayEndToEnd: true,
      contextmenuValue: '',
      icons: {
        wifi: 'full',
        battery: 'full',
        showbatterytext: true,
        sim: 'full',
        rotate: 'on',
        displayLastOnline: true
      },
      batteryCharge: {
        width: '10px'
      },
      bounce: {
        name: '',
        lastSeen: '',
        time: ''
      },
      serverIp: "http://192.168.109.22/whatsapp_backend"
    }
  },
  watch: {
    chats() {
      let last_chat_element = document.getElementById("last-chat-element-android")
      last_chat_element.scrollIntoView({behavior: 'smooth'});
    }
  },
  mounted() {
    let batteryElement = document.getElementById("batterytext")
    let self = this
    batteryElement.addEventListener("input", function() {
      self.rerenderBattery(batteryElement.innerText)
    })
  },
  methods: {
    log(title, message) {
      console.groupCollapsed(title);
      console.log("message", message);
      console.groupEnd();
    },
    timeChanged() {
      let ele = document.getElementById("layout_time_android");
      const time = ele.innerText
      let self = this
      self.bounce.time = time
      setTimeout(function() {
        if(self.bounce.time === time)
        {
          self.$parent.setTime(time)
        }
      },2000)
    },
    lastSeenChanged() {
      let ele = document.getElementById("conection_android");
      const lastSeen = ele.innerText
      let self = this
      self.bounce.lastSeen = lastSeen
      setTimeout(function() {
        if(self.bounce.lastSeen === lastSeen)
        {
          self.$parent.setLastSeen(lastSeen)
        }
      },2000)
    },
    generateMessageTime(chat) {
      // let self = this;
      if(chat.message.length > 0 || chat.images.length <= 1) {
        let messageTime = '';
        let css = 'visibility: hidden;font-size: 12px;margin-left: auto;padding-left: 10px;position: relative;bottom: -4px;margin-top: auto;color: rgba(0, 0, 0, 0.4);float:right;';
        if(chat.message.length <=0 && chat.images.length > 0) {
          css += 'color: #FFFFFF;margin-right: 5px;z-index: 2;';
        }
        
        messageTime += '<div style="' + css + '" >' + chat.time.slice(0,5);
        if(chat.sender) {
          css = 'font-size: 16px;color: rgba(0, 0, 0, 0.4);position: relative;top: 3px;';
          if(chat.state==='read') {
            css += 'color: var(--whatsapp-chat-checkmark);';
            messageTime += "<i class='material-icons checkmark' style='" + css + "'>&#xe877;</i>"
          } else if(chat.state==='received') {
            messageTime += "<i class='material-icons' style='" + css + "'>&#xe877;</i>"
          } else {
            messageTime += "<i class='material-icons' style='" + css + "'>&#xe876;</i>"
          }
        }
        return messageTime + "</div>" + "</div>";
      } else {
        return "" + "</div>";
      }
    },
    replaceEmojis(message) {
      let self = this
      let replaced = message.replace(/:(\d*?):/g, function(a, b){
        if(self.emojis[b]!==undefined) {
          return '<img style="display: inline; height: 22px; margin: 0 2px;position: relative; vertical-align: middle;" src="android/' + self.emojis[b] + '" />';
        } else {
          return message
        }
      })
      if(!replaced.startsWith("<div style"))
      {
        replaced = "<div style='font-size: 18px;float: left; display: inline;'>" + replaced;
      }
      return replaced
    },
    nameChanged() {
      let ele = document.getElementById("contactname_android");
      const name = this.replaceEmojis(ele.innerHTML)
      let self = this
      self.bounce.name = name
      setTimeout(function() {
        if(self.bounce.name === name)
        {
          self.$parent.setName(name)
          ele.innerHTML = name
        }
      },2000)
    },
    rerenderBattery(percent) {
      let pn = parseInt(percent)
      if(!isNaN(pn)) {
        let pnd = pn / 100
        if(pnd >= 1)
        {
          pnd = 1
        }
        let bg='#73AD21'
        if(pnd <= 0.2) {
          bg = '#e53935'
        } else if(pnd <= 0.5) {
          bg = '#fb8c00'
        }
        this.batteryCharge = {
          width: Math.round(10*pnd)+"px",
          backgroundColor: bg
        }
      }
    },
    selectBackground() {
      document.getElementById('background-upload').click()
    },
    openContextMenu(e) {
      if (this.contextmenuValue === '') {
        return
      }
      this.$refs.menu.open(e);
    },
    closeContextMenu() {
      this.$refs.menu.close();
      this.contextmenuValue = ''
    },
    onFileChange(e) {
      let self = this;
      const file = e.target.files[0];
      let formData = new FormData();
      formData.append("file", file);
      axios
        .post(self.serverIp + "/api/image_insert", formData, {
          headers: {
            "Content-Type": "multipart/form-data"
        }})
        .then(function (response) {
          self.log("response", response);
          let url =  self.serverIp + response.data.file_path;
          self.$parent.setProfilePicture(url)
        })
        .catch(function (error) {
          self.log("error", error);
        });
    },
    onFileChangeBackground(e) {
      let self = this;
      const file = e.target.files[0];
      let formData = new FormData();
      formData.append("file", file);
      axios
        .post(self.serverIp + "/api/image_insert", formData, {
          headers: {
            "Content-Type": "multipart/form-data"
        }})
        .then(function (response) {
          self.log("response", response);
          let url =  self.serverIp + response.data.file_path;
          self.$parent.setBackground(url)
        })
        .catch(function (error) {
          self.log("error", error);
        });
    }
  }
}
</script>
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

:root {
  --whatsapp-light-green: #128C7E;
  --whatsapp-teal-green: #075e54;
  --android-dark-green: #064841;
  --whatsapp-chat-bubble: #fff;
  --whatsapp-chat-protection: #FDF9C5;
  --whatsapp-chat-checkmark: #34B7F1;
}
</style>
<style scoped>
.android-headbar {
  background: var(--android-dark-green);
  height: 26px;
  color: #FFFFFF;
}

.android-headbar .time {
  padding: 5px;
  font-size: 0.9em;
}

.android-headbar i {
  padding: 5px;
  font-size: 1em;
}

.android-headbar .align-left {
  float: left;
}

.android-headbar .align-right {
  float: right;
}

input, button, textarea {
  border: none;
  outline: none;
  font-family: "Lato", sans-serif;
}

.whatsapp-chat {
  width: 100%;
  background-size: cover;
  margin: 0 auto;
  position: relative;
  display: flex;
  flex-direction: column;
}

.whatsapp-chat i {
  color: #FFF;
  padding-top: 3px;
}

.whatsapp-chat-header {
  background-color: var(--whatsapp-teal-green);
  display: flex;
  align-items: center;
}

.whatsapp-chat-header__back {
  display: flex;
  align-items: center;
  padding: 10px 5px;
}

.whatsapp-chat-header__back-photo {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: block;
}

.whatsapp-chat-header__name {
  width: 40%;
  color: #FFF;
  text-align: left;
  padding-left: 5px;
  flex-shrink: 0;
}

.whatsapp-chat-header__name p {
  width: 100%;
  min-width: 0;
  line-height: 1.3;
  font-weight: 600;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  margin-right: 0;
}

.whatsapp-chat-header__name #conection_android {
  font-size: 12px;
}

.whatsapp-chat-header__calls {
  margin-left: auto;
}

.whatsapp-chat-header__calls-items {
  display: flex;
  list-style: none;
}

.whatsapp-chat-header__calls-items li {
  padding: 0 10px;
}

.whatsapp-chat-messages {
  width: calc(100% + 17px);;
  height: calc(100% - 50px);
  position: relative;
  overflow-y: scroll;
  overflow-x: hidden;
  padding-right: 18px;
  box-sizing: content-box;
  padding-left: 0px;
  padding-bottom: 0px;
}

.whatsapp-chat-messages .chats {
  display: flex;
  text-align: left;
  flex-direction: column;
}

.whatsapp-chat-messages__protection {
  max-width: 92%;
  display: block;
  padding: 5px 0 10px;
  margin-left: auto;
  margin-right: auto;
  background-color: var(--whatsapp-chat-protection);
  font-size: 13px;
  margin-top: 10px;
  border-radius: 5px;
  text-align: center;
  color: rgba(0, 0, 0, 0.6);
  line-height: 1.3;
}

.whatsapp-chat-messages__protection i {
  color: rgba(0, 0, 0, 0.5);
  font-size: 14px;
  position: relative;
  top: 2px;
}

.whatsapp-chat-messages__sender, .whatsapp-chat-messages__receiver {
  --margin: 15px;
  max-width: 80%;
  line-height: 1.3;
  padding: 7px;
  display: flex;
  flex-wrap: wrap;
  margin-top: 8px;
  border-radius: 5px;
  
  position: relative;
}

.whatsapp-chat-messages__sender:before, .whatsapp-chat-messages__receiver:before {
  content: "";
  width: 0;
  height: 0;
}

.whatsapp-chat-messages__sender .whatsapp-chat-messages__datetime, .whatsapp-chat-messages__receiver .whatsapp-chat-messages__datetime {
  font-size: 12px;
  margin-left: auto;
  padding-left: 10px;
  position: absolute;
  bottom: 4px;
  margin-top: auto;
  color: rgba(0, 0, 0, 0.4);
  right: 10px;
}

.whatsapp-image {
  width: 100%;
  height: auto;
  overflow: hidden;
  position: relative;
}

.whatsapp-chat-messages__sender .whatsapp-chat-messages__datetime i, .whatsapp-chat-messages__receiver .whatsapp-chat-messages__datetime i {
  font-size: 16px;
  color: rgba(0, 0, 0, 0.4);
  position: relative;
  top: 3px;
}

.whatsapp-chat-messages__sender .whatsapp-chat-messages__datetime i.checkmark, .whatsapp-chat-messages__receiver .whatsapp-chat-messages__datetime i.checkmark {
  color: var(--whatsapp-chat-checkmark);
}

.overlay {
  background: rgb(57,57,57);
  background: linear-gradient(138deg, rgba(57,57,57,0) 0%, rgba(9,9,121,0) 83%, rgba(64,64,64,1) 100%);
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 99%;
  width: 100%;
  z-index: 1;
}

.overlay-plus {
  background: rgba(0,0,0,0.5);
  position: absolute;
  color: #FFFFFF;
  line-height: 147px;
  text-align: center;
  font-size: 2.5em;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 147px;
  width: 147px;
  z-index: 1;
}

.imgage-blur {
  filter: blur(5px);
  -webkit-filter: blur(5px);
}

.whatsapp-chat-messages__datetime.no-text {
  color: #FFFFFF;
  margin-right: 5px;
  z-index: 2;
}

.whatsapp-chat-messages__datetime.multiple-images {
  color: #FFFFFF;
  position: absolute;
  bottom: 15px;
  height: 10px;
  right: 5px;
  z-index: 2;
}

.whatsapp-chat-messages__datetime.no-text i {
  color: #ffffff;
}

.whatsapp-chat-messages__sender .whatsapp-chat-messages__datetime.no-text {
  margin-top: -33px;
}

.whatsapp-chat-messages__receiver .whatsapp-chat-messages__datetime.no-text {
  margin-top: -25px;
}

.whatsapp-chat-messages__sender {
  margin-left: auto;
  margin-right: var(--margin);
  background-color: #DCF8C6;
}

.whatsapp-chat-messages__sender:before {
  border-bottom: 17px solid rgba(255, 255, 255, 0);
  border-left: 13px solid #DCF8C6;
  border-right: 10px solid rgba(255, 255, 255, 0);
  position: absolute;
  left: calc(100% - 5px);
  top: 0;
}

.whatsapp-chat-messages__receiver {
  margin-right: auto;
  margin-left: var(--margin);
  background-color: #FFF;
}

.whatsapp-chat-messages__receiver:before {
  border-bottom: 17px solid rgba(255, 255, 255, 0);
  border-left: 13px solid rgba(255, 255, 255, 0);
  border-right: 13px solid #FFF;
  position: absolute;
  right: calc(100% - 5px);
  top: 0;
}

.whatsapp-chat-send {
  width: 100%;
  height: 55px;
  background-color: transparent;
  overflow: hidden;
  margin-top: auto;
  padding: 5px 5px 10px;
  display: flex;
  align-items: center;
}

.whatsapp-chat-send__write {
  width: calc(100% - 45px);
  height: 40px;
  background-color: #FFF;
  border-radius: 30px;
  display: flex;
  align-items: center;
}

.whatsapp-chat-send__write i {
  color: rgba(0, 0, 0, 0.5);
  padding-left: 10px;
}

.whatsapp-chat-send__write input[type=text] {
  width: 55%;
  font-size: 15px;
  padding-left: 5px;
}

.whatsapp-chat-send__write ul {
  display: flex;
  list-style: none;
  align-items: center;
  margin-left: auto;
  padding-right: 10px;
}

.whatsapp-chat-send__write ul li {
  color: rgba(0, 0, 0, 0.5);
}

.whatsapp-chat-send__write ul li:last-child {
  padding-top: 2px;
}

.whatsapp-chat-send__write ul li i.rt {
  transform: rotate(-45deg);
  padding-right: 20px;
  position: relative;
  top: -4px;
}

.whatsapp-chat-send__record {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  margin-left: auto;
  background-color: var(--whatsapp-light-green);
  display: flex;
  align-items: center;
  justify-content: center;
}

.whatsapp-chat-send__record i {
  position: relative;
  top: -2px;
}
.batteryContainer {
  display: -webkit-box;
  display: -moz-box;
  display: -ms-flexbox;
  display: -webkit-flex;
  display: flex;
  flex-direction: row;
  align-items: center;
  transform: rotate(270deg);
  margin-top:7.9px;
  padding: 0 5px;
}

.batteryOuter {
  border-radius: 3px;
  border: 1px solid #FFFFFF;
  padding: 1px;
  width: 14px;
  height: 9px;
}

.batteryBump {
  border-radius: 2px;
  background-color: #FFFFFF;
  margin: 0;
  width: 1px;
  height: 3px;
}

#batteryLevel {
  border-radius: 2px;
  background-color: #73AD21;
  width: 10px;
  height: 5px;
}
</style>