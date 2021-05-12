<template>
  <div class="container">
    <div class="head-row" style="margin: auto">
      <h1
        style="
          size: 2em;
          color: #ffffff;
          margin: 50px auto;
          padding: 20px;
          float: left;
        "
      >
        <span>Whatsapp Chat Generator</span>
        <div class="print-button">
          <button class="print-button__content" @click="makeScreen">
            Screenshot erstellen und Herunterladen
          </button>
          <a
            style="display: none"
            id="create_screenshot_and_print"
            download="screenshot.png"
          ></a>
        </div>
      </h1>
    </div>
    <div class="save-button">
      <button class="save-button__content" @click="makeSave">Save</button>
    </div>
    <div class="json-button">
      <button class="json-button__content" @click="makeJson">Json</button>
    </div>
    <div class="load-button">
      <button class="load-button__content" @click="makeLoad">Load</button>
    </div>
    <div class="head-row" style="margin: auto; width: 100%">
      <nav class="actions">
        <input type="radio" v-model="selectedOS" id="android" value="android" />
        <label for="android">Android</label>
        <input type="radio" v-model="selectedOS" id="ios" value="ios" />
        <label for="ios">iOS</label>
      </nav>
    </div>
    <div class="editor-row">
      <ChatInput
        :selectedOs="selectedOS"
        :emojis="IconList"
        :is-sender="false"
        @input="generateChat"
        :value="chatLeft"
        headline="Links"
        identifier="left"
      />
      <AndroidChat
        :emojis="IconListAndroid"
        :profile-picture="profilePicture"
        :background-image="background"
        :time="time"
        :lastSeen="lastSeen"
        :name="name"
        v-show="selectedOS === 'android'"
        id="chat_to_print_android"
        :chats="chats"
      />
      <iOSChat
        :emojis="IconList"
        :profile-picture="profilePicture"
        :background-image="background"
        :time="time"
        :lastSeen="lastSeen"
        :name="name"
        v-show="selectedOS === 'ios'"
        id="chat_to_print_ios"
        :chats="chats"
      />
      <ChatInput
        :selectedOs="selectedOS"
        :emojis="IconList"
        :is-sender="true"
        @input="generateChat"
        :value="chatRight"
        headline="Rechts"
        identifier="right"
      />
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
import axios from "axios";

export default {
  name: "Container",
  components: { ChatInput, AndroidChat, iOSChat },
  data() {
    return {
      chatLeft: [],
      chatRight: [],
      chats: [],
      screens: [],
      name: "Name",
      lastSeen: "zuletzt online heute 11:21",
      profilePicture: `${require("@/assets/images/no_profile_picture.png")}`,
      background: `${require("@/assets/images/default_wallpaper_android.png")}`,
      time: "11:50",
      selectedOS: "android",
      IconList,
      IconListAndroid,
      serverIp: "http://192.168.109.22",
    };
  },
  watch: {
    chatLeft() {
      this.generateChat();
    },
    chatRight() {
      this.generateChat();
    },
  },
  methods: {
    log(title, message) {
      console.groupCollapsed(title);
      console.log("message", message);
      console.groupEnd();
    },
    setTime(time) {
      this.time = time;
    },
    setBackground(background) {
      this.background = background;
    },
    setProfilePicture(profilePicture) {
      this.profilePicture = profilePicture;
    },
    setName(name) {
      this.name = name;
    },
    setLastSeen(lastSeen) {
      this.lastSeen = lastSeen;
    },
    dataURItoBlob(dataURI) {
      var byteString;
      if (dataURI.split(",")[0].indexOf("base64") >= 0)
        byteString = atob(dataURI.split(",")[1]);
      else byteString = unescape(dataURI.split(",")[1]);

      var mimeString = dataURI.split(",")[0].split(":")[1].split(";")[0];

      var ia = new Uint8Array(byteString.length);
      for (var i = 0; i < byteString.length; i++) {
        ia[i] = byteString.charCodeAt(i);
      }

      return new Blob([ia], { type: mimeString });
    },
    makeScreen() {
      let link = document.getElementById("create_screenshot_and_print");
      let self = this;

      html2canvas(document.querySelector("#chat_to_print_" + this.selectedOS), {
        scale: 3,
        allowTaint: true,
        useCORS: true,
        logging: true,
        letterRendering: true,
        backgroundColor: "#000000",
      }).then((canvas) => {
        let url = canvas.toDataURL("image/png");
        link.href = url;

        canvas.toBlob(function (blob) {
          var formData = new FormData();
          formData.append("file", blob, "image.jpg");
          axios
            .post(self.serverIp + "/api/screen_insert", formData, {
              headers: {
                "Content-Type": "multipart/form-data",
              },
            })
            .then(function (response) {
              self.screens.push({
                file_id: response.data.file_id,
                file_path: self.serverIp + response.data.file_path,
                file_name: response.data.file_name,
              });
              link.click();
            })
            .catch(function (error) {
              alert(error);
            });
        }, "image/png");
      });
    },
    download(filename, text) {
      var element = document.createElement("a");
      element.setAttribute(
        "href",
        "data:text/plain;charset=utf-8," + encodeURIComponent(text)
      );
      element.setAttribute("download", filename);
      element.style.display = "none";
      document.body.appendChild(element);
      element.click();
      document.body.removeChild(element);
    },
    makeJson() {
      if (this.screens.length == 0) {
        return;
      }
      var txtFile = new Date().getTime() + ".json";
      var str = '{"images": {';
      this.screens.forEach((screen, index) => {
        if (index == 0) {
          str += '"' + screen.file_id + '": "' + screen.file_path + '"';
        } else {
          str += ',"' + screen.file_id + '": "' + screen.file_path + '"';
        }
      });
      str += '},"thumbnail": "' + this.screens[0].file_id + '",';
      str +=
        '"desc": "Das Makeup begeistert ihn nicht so\\r\\n. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .",';
      str += '"questions": [';
      this.screens.forEach((screen, index) => {
        if (index == 0) {
          str += "{";
        } else {
          str += ", {";
        }
        str += '"images": [' + screen.file_id + ', ""],';
        str +=
          '"question": "Das Makeup begeistert ihn nicht so\\r\\n. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .",';
        str += '"answers": ["Weiter"]';
        str += "}";
      });
      str += '],"results": "",  "lang": "ST","is_wpquiz_export": true}';
      this.download(txtFile, str);
    },
    makeSave() {
      let self = this;

      axios
        .post(self.serverIp + "/api/message_deleteAll", {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then(function () {
          self.chats.forEach((chat) => {
            var formData = new FormData();
            let images = "";
            chat.images.forEach((image) => {
              images += image + ":::";
            });
            formData.append("images", images);
            formData.append("sender", chat.sender === true ? "1" : "0");
            formData.append("state", chat.state);
            formData.append("time", chat.time);
            formData.append("message", chat.message);
            axios
              .post(self.serverIp + "/api/message_insert", formData, {
                headers: {
                  "Content-Type": "multipart/form-data",
                },
              })
              .then(function (response) {
                self.screens.push({
                  file_id: response.data.file_id,
                  file_path: self.serverIp + response.data.file_path,
                  file_name: response.data.file_name,
                });
              })
              .catch(function (error) {
                alert(error);
              });
          });
        })
        .catch(function (error) {
          alert(error);
        });
    },
    makeLoad() {
      let self = this;
      axios
        .post(self.serverIp + "/api/message_getAll", {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then(function (response) {
          response.data.forEach((message) => {
            let images = message.images.split(":::");
            images.pop();
            if (message.sender === "1") {
              self.chatRight.push({
                message: message.message,
                time: message.time,
                images: images,
                state: message.state,
                sender: true,
              });
            } else {
              self.chatLeft.push({
                message: message.message,
                time: message.time,
                images: images,
                state: message.state,
                sender: false,
              });
            }
          });
          self.chatLeft.sort(self.compareTwoTimes);
          self.chatRight.sort(self.compareTwoTimes);
          self.generateChat();
        })
        .catch(function (error) {
          alert(error);
        });
    },
    generateChat() {
      let tmpChatLeft = this.chatLeft;
      for (let i = 0; i < tmpChatLeft.length; i++) {
        tmpChatLeft[i].sender = false;
      }
      let tmpChatRight = this.chatRight;
      for (let j = 0; j < tmpChatRight.length; j++) {
        tmpChatRight[j].sender = true;
      }
      let fullchat = tmpChatLeft.concat(tmpChatRight);
      fullchat.sort(this.compareTwoTimes);
      this.chats = fullchat;
    },
    compareTwoTimes(a, b) {
      const time_a = Date.parse("01/01/2011 " + a.time);
      const time_b = Date.parse("01/01/2011 " + b.time);
      if (time_a < time_b) {
        return -1;
      }
      if (time_a > time_b) {
        return 1;
      }
      return 0;
    },
  },
};
</script>
<style scoped>
.container {
  display: grid;
  height: 100%;
  grid-template-rows: 1fr 70px 600px 30px;
  position: relative;
}

.container .editor-row {
  display: grid;
  grid-template-columns: 1fr calc(68.7mm * 1.62) 1fr;
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
  border: 1px solid #ffffff;
  border-radius: 3px;
  transition: 0.3s;
  background: transparent;
}

.save-button {
  position: absolute;
  right: -5rem;
  top: 7rem;
}

.save-button:hover {
  right: -2rem;
}

.save-button__content:hover {
  background-color: #c40004;
}

.save-button__content {
  display: inline-block;
  cursor: pointer;
  padding: 0.8rem 5.5rem 0.8rem 2.5rem;
  color: white;
  text-decoration: none;
  font-size: 25px;
  box-shadow: none;
  border: 1px solid #ffffff;
  border-radius: 3px;
  transition: 0.3s;
  background: transparent;
}

.json-button {
  position: absolute;
  right: -4.8rem;
  top: 12rem;
}

.json-button:hover {
  right: -2rem;
}

.json-button__content:hover {
  background-color: #c40004;
}

.json-button__content {
  display: inline-block;
  cursor: pointer;
  padding: 0.8rem 5.5rem 0.8rem 2.5rem;
  color: white;
  text-decoration: none;
  font-size: 25px;
  box-shadow: none;
  border: 1px solid #ffffff;
  border-radius: 3px;
  transition: 0.3s;
  background: transparent;
}

.load-button {
  position: absolute;
  right: -5rem;
  top: 17rem;
}

.load-button:hover {
  right: -2rem;
}

.load-button__content:hover {
  background-color: #c40004;
}

.load-button__content {
  display: inline-block;
  cursor: pointer;
  padding: 0.8rem 5.5rem 0.8rem 2.5rem;
  color: white;
  text-decoration: none;
  font-size: 25px;
  box-shadow: none;
  border: 1px solid #ffffff;
  border-radius: 3px;
  transition: 0.3s;
  background: transparent;
}

.print-button__content:hover {
  background-color: #c40004;
}

input[type="radio"] {
  display: none;
}

label {
  padding: 10px;
  cursor: pointer;
  color: #ffffff;
  border: 1px solid rgba(254, 254, 254, 0.6);
  border-radius: 0;
}
input[type="radio"]:checked + label {
  background: #ffffff;
  color: #3a3c42;
}
.icons {
  position: absolute;
  top: 0;
  padding: 20px;
  left: 0;
  background: #ffffff;
  width: 100%;
  margin: auto;
}
</style>
