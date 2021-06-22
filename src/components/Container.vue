<template>
  <div class="container">
    <vue-element-loading
      :active="loadingBar"
      spinner="bar-fade-scale"
      color="#FF6700"
    />
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
          <div class="preview-thumb">
            <div
              v-for="(screen, index) in screens"
              :key="'chatmessage_' + index"
              class="thumb-gallery"
            >
              <img
                class="thumb-image"
                @click="modalThumb(screen)"
                :key="index"
                :src="screen.file_path"
              />
            </div>
          </div>

          <a
            style="display: none"
            id="create_screenshot_and_print"
            download="screenshot.png"
          ></a>
          <a
            style="display: none"
            id="download_video"
            download="video.mp4"
          ></a>
        </div>
      </h1>
    </div>
    <div class="save-button">
      <button class="save-button__content" @click="makeSave">Save</button>
    </div>
    <div class="video-button">
      <button class="video-button__content" @click="makeVideo">Video</button>
    </div>
    <div class="json-button">
      <input type="text" v-model="jsonTip" id="jsontip" value="" />
      <button class="json-button__content" @click="makeJson">Json</button>
    </div>
    <div class="load-button">
      <vSelect
        :options="loadOptions"
        class="chooser"
        id="loadoption"
        @input="setSelected"
      >
        <template slot="option" slot-scope="option">
          {{ option.label }}
        </template>
      </vSelect>
      <span
        class="del"
        @click="deleteList"
        v-bind:style="{
          display: delCss,
        }"
      >
        X
      </span>
      <button class="load-button__content" @click="makeLoad">Load</button>
    </div>
    <div class="screen-setting-panel">
      <div class="panel">
        <span>Width: </span>
        <input type="number" v-model="screenWidth" id="screen-width" value="" />
      </div>
      <div class="panel">
        <span>Height: </span>
        <input
          type="number"
          v-model="screenHeight"
          id="screen-height"
          value=""
        />
      </div>
    </div>
    <div class="head-row" style="margin: auto; width: 100%">
      <nav class="actions">
        <input type="radio" v-model="selectedOS" id="android" value="android" />
        <label for="android">Android</label>
        <input type="radio" v-model="selectedOS" id="ios" value="ios" />
        <label for="ios">iOS</label>
      </nav>
    </div>
    <div
      class="editor-row"
      v-bind:style="{
        gridTemplateColumns: '1fr calc(' + screenWidth + 'px) 1fr',
      }"
    >
    <iOSChat
        :emojis="IconList"
        :profile-picture="profilePicture"
        :background-image="background"
        :time="time"
        :lastSeen="lastSeen"
        :name="name"
        class="colGrid2"
        v-show="selectedOS === 'ios'"
        id="chat_to_print_ios"
        :chats="chats"
        :chatsHeight="screenHeight"
        :icons="iosIcons"
        :initIcons="iosIcons"
        ref="ioschat"
        @update="onIOSIconsUpdate"
        v-bind:style="{
          height: Number(screenHeight) + 26 + 5 + 'px',
        }"
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
        :chatsHeight="screenHeight"
        :iconState:="iconState"
        :initIcons="androidIcons"
        ref="androidchat"
        class="colGrid2"
        @update="onAndroidIconsUpdate"
        v-bind:style="{
          height: Number(screenHeight) + 26 + 'px',
        }"
      />
      

      <div class="colGrid1">
        <ChatInput
          :selectedOs="selectedOS"
          :emojis="IconList"
          :is-sender="false"
          @input="generateChat"
          :value="chatLeft"
          headline="Links"
          identifier="left"
        />
      </div>
      <div class="colGrid3">
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
    <canvas
      id="background-canvas"
      style="position: absolute; top: -99999999px; left: -9999999999px"
    ></canvas>
    <vue-confirm-dialog />
    <modal
      :height="500"
      :width="400"
      :shiftY="0.4"
      :clickToClose="true"
      name="thumb-preview-modal"
    >
      <div class="modal-content">
        <img class="thumb-image" :src="selectThumb.file_path" />
      </div>
      <div class="modal-footer">
        <button @click="removeThumb">Remove</button>
      </div>
    </modal>
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

import vSelect from "vue-select";
import "vue-select/dist/vue-select.css";
import * as RecordRTC from "../RecordRTC";

export default {
  name: "Container",
  components: { ChatInput, AndroidChat, iOSChat, vSelect },
  created() {
    let self = this;
    axios
      .post(self.serverIp + "/api/conversation_getAll", {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      })
      .then(function (response) {
        if (response.data === "database error!") {
          return;
        }
        response.data.forEach((element) => {
          self.loadOptions.push(element.date);
        });
      })
      .catch(function (error) {
        self.log("error", error);
      });

    this.androidIcons = {
      wifi: "off",
      battery: "full",
      showbatterytext: true,
      sim: "full",
      rotate: "on",
      displayLastOnline: true,
      batteryPercent: 100,
    };
    this.iosIcons = {
      showbatterytext: true,
      signal: "on",
      displayLastOnline: true,
      batteryPercent: 100,
      signalStrengt: 4,
      battery: "full",
      network: "wifi",
    };
  },
  data() {
    return {
      chatLeft: [],
      chatRight: [],
      chats: [],
      screens: [],
      conversations: [],
      loadOptions: [],
      name: "Name",
      lastSeen: "zuletzt online heute 11:21",
      profilePicture: `${require("@/assets/images/no_profile_picture.png")}`,
      profilePath: "",
      background: `${require("@/assets/images/default_wallpaper_android.png")}`,
      time: "11:50",
      selectedOS: "android",
      IconList,
      IconListAndroid,
      serverIp: "http://192.168.109.22/whatsapp_backend",
      videoServerIp: "http://192.168.109.22:3000/",
      jsonTip: "",
      loadmode: "",
      curLoadMode: "",
      screenWidth: "421",
      screenHeight: "572",
      delCss: "none",
      postIndex: 0,
      loadingBar: false,
      selectThumb: [],
      videoFlag: false,
      videoIndex: 0,
      lastVideoIndex: 0,
      videoThumbCount: 0,
      androidIcons: {},
      iosIcons: {},
      iconState: {},
      androidIcon: {
        battery: "full",
        displayLastOnline: true,
        rotate: "on",
        showbatterytext: true,
        sim: "full",
        wifi: "",
      },
      iosIcon: {
        battery: "full",
        batteryPercent: "61",
        displayLastOnline: true,
        network: "wifi",
        showbatterytext: true,
        signal: "on",
        signalStrengt: "2",
      },
      tempChats: [],
      recorder: null,
      isStoppedRecording: true,
      isRecordingStarted: false,
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
    onAndroidIconsUpdate(newValue) {
      this.androidIcons = newValue;
      this.log("onAndroidIconsUpdate", this.androidIcons);
    },
    onIOSIconsUpdate(newValue) {
      this.iosIcons = newValue;
      this.log("onIOSIconsUpdate", this.iosIcons);
    },
    padLeadingZeros(num, size) {
      var s = num + "";
      while (s.length < size) s = "0" + s;
      return s;
    },
    showModal() {
      this.$modal.show("thumb-preview-modal");
    },
    hideModal() {
      this.$modal.hide("thumb-preview-modal");
    },
    setTime(time) {
      this.time = time;
    },
    setBackground(background) {
      this.background = background;
    },
    setProfilePicture(profilePicture) {
      this.log("setProfilePicture", profilePicture);
      this.profilePicture = profilePicture;
      this.profilePath = profilePicture;
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
      this.previewScreen();
      this.previewScreen();
      this.previewScreen();
      this.previewScreen();
      this.generateScreen(0, 0);
    },
    previewScreen() {
      let link = document.getElementById("create_screenshot_and_print");

      html2canvas(document.querySelector("#chat_to_print_" + this.selectedOS), {
        scale: 3,
        allowTaint: true,
        useCORS: true,
        letterRendering: true,
        backgroundColor: "#000",
      }).then((canvas) => {
        let url = canvas.toDataURL("image/jpeg");
        link.href = url;
      });
    },
    modalThumb(screen) {
      let self = this;
      self.selectThumb = screen;
      self.showModal();
    },
    removeThumb() {
      let delIndex = 0;
      let self = this;
      self.screens.forEach((screen, index) => {
        if (screen.file_path === self.selectThumb.file_path) {
          delIndex = index;
        }
      });
      self.screens.splice(delIndex, 1);
      self.hideModal();
      // self.showAlert("Successfully removed!");
    },
    generateScreen(mode, order) {
      let link = document.getElementById("create_screenshot_and_print");
      let self = this;

      html2canvas(document.querySelector("#chat_to_print_" + this.selectedOS), {
        scale: 3,
        allowTaint: true,
        useCORS: true,
        letterRendering: true,
        backgroundColor: "#000",
      })
        .then((canvas) => {
          console.log("canvas", canvas);
          let url = canvas.toDataURL("image/jpeg");
          link.href = url;

          canvas.toBlob(function (blob) {
            var formData = new FormData();
            if (mode == 0) {
              formData.append("file", blob, "image.png");
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
                  // link.click();
                  self.showAlert("Successfully uploaded the image! :)");
                })
                .catch(function (error) {
                  self.log("error", error);
                });
            } else {
              formData.append(
                "file",
                blob,
                "frame-" + self.padLeadingZeros(order, 6) + ".jpeg"
              );
              axios
                .post(self.serverIp + "/api/screen_video_insert", formData, {
                  headers: {
                    "Content-Type": "multipart/form-data",
                  },
                })
                .then(function (response) {
                  // link.click();
                  self.log("resposne", response);
                  // self.videoIndex += 10;
                  self.videoThumbCount++;
                  self.video_post();
                })
                .catch(function (error) {
                  self.log("error", error);
                });
            }
          }, "image/jpeg");
        })
        .catch((e) => {
          self.log("error", e);
          if (mode == 1) {
            self.video_post();
          }
        });
    },
    deleteList() {
      let self = this;
      self.handleDeleteList();
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
        this.log("jsontip", this.jsonTip);
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
      str += '"desc": "' + this.jsonTip + '",';
      str += '"questions": [';
      this.screens.forEach((screen, index) => {
        if (index == 0) {
          str += "{";
        } else {
          str += ", {";
        }
        str += '"images": [' + screen.file_id + ', ""],';
        str += '"question": "' + this.jsonTip + '",';
        str += '"answers": ["Weiter"]';
        str += "}";
      });
      str += '],"results": "",  "lang": "ST","is_wpquiz_export": true}';
      this.download(txtFile, str);
    },
    generateToday() {
      var today = new Date();
      var dd = String(today.getDate()).padStart(2, "0");
      var mm = String(today.getMonth() + 1).padStart(2, "0"); //January is 0!
      var yyyy = today.getFullYear();
      var hh = String(today.getHours()).padStart(2, "0");
      var min = String(today.getMinutes()).padStart(2, "0");
      var ss = String(today.getSeconds()).padStart(2, "0");

      today = mm + "/" + dd + "/" + yyyy + " " + hh + ":" + min + ":" + ss;
      return today;
    },
    makeSave() {
      let self = this;
      if (self.chats.length === 0) {
        self.showAlert("Please insert messages.");
        return;
      }
      self.handleConfirm();
    },
    makeLoad() {
      let self = this;
      if (self.loadmode === "") {
        self.showAlert("Please select the conversation date.");
        return;
      }
      var formData = new FormData();
      formData.append("date", self.loadmode);
      axios
        .post(self.serverIp + "/api/message_getByDate", formData, {
          headers: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then(function (response) {
          while (self.chatRight.length > 0) {
            self.chatRight.pop();
          }
          while (self.chatLeft.length > 0) {
            self.chatLeft.pop();
          }
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
          self.curLoadMode = self.loadmode;

          axios
            .post(self.serverIp + "/api/conversation_getDataByTime", formData, {
              headers: {
                "Content-Type": "multipart/form-data",
              },
            })
            .then(function (response) {
              self.profilePath = response.data.avatar;
              if (self.profilePath !== "") {
                self.profilePicture = response.data.avatar;
              } else {
                self.profilePicture = `${require("@/assets/images/no_profile_picture.png")}`;
              }
              self.background = response.data.background;
              if (self.background === "") {
                self.background = `${require("@/assets/images/default_wallpaper_android.png")}`;
              }
              self.name = response.data.name;
              self.lastSeen = response.data.lastseen;

              self.androidIcons = JSON.parse(response.data.androidIcons);
              self.iosIcons = JSON.parse(response.data.iosIcons);

              self.$refs.androidchat.refreshIcons(self.androidIcons);
              self.$refs.ioschat.refreshIcons(self.iosIcons);

              self.setTime(response.data.time);
            })
            .catch(function (error) {
              self.log("conversation_getDataByTime -> error", error);
            });
        })
        .catch(function (error) {
          self.log("error", error);
        });
    },
    generateChat() {
      let self = this;

      let tmpChatRight = this.chatRight;
      for (let j = 0; j < tmpChatRight.length; j++) {
        tmpChatRight[j].sender = true;
      }

      let tmpChatLeft = this.chatLeft;
      for (let i = 0; i < tmpChatLeft.length; i++) {
        tmpChatLeft[i].sender = false;
      }

      let fullchat = tmpChatRight.concat(tmpChatLeft);
      fullchat.sort(this.compareTwoTimes);

      while (self.chats.length > 0) {
        self.chats.pop();
      }

      let preNode = null;
      let check = false;
      fullchat.forEach((element, index) => {
        if (index === 0) {
          check = true;
        } else if (element.sender === preNode.sender) {
          check = false;
        } else {
          check = true;
        }
        element.check = check;
        self.chats.push(element);
        preNode = element;
      });
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
    setSelected(value) {
      this.loadmode = value;
      this.delCss = "";
    },
    showAlert(msg) {
      this.$notify({
        message: msg,
        type: "",
        top: true,
        bottom: false,
        left: true,
        right: false,
        showClose: true,
        closeDelay: 4500,
      });
    },
    sleep(ms) {
      return new Promise((resolve) => setTimeout(resolve, ms));
    },
    async init() {
      let self = this;
      while (self.chats.length > 0) {
        let msg = self.chats.pop();
        self.tempChats.push(msg);
      }

      while (self.chatRight.length > 0) {
        self.chatRight.pop();
      }
      while (self.chatLeft.length > 0) {
        self.chatLeft.pop();
      }
    },
    async demo() {
      // Sleep in loop

      let self = this;

      while (self.tempChats.length > 0) {
        await this.sleep(2500);
        let msg = self.tempChats.pop();
        if (msg.sender === false) {
          self.chatLeft.push(msg);
        } else {
          self.chatRight.push(msg);
        }

        var element = document.getElementsByClassName(
          "whatsapp-chat-messages"
        )[1];

        if( this.selectedOS != "android") {
          element = document.getElementsByClassName(
            "whatsapp-chat-messages"
          )[0];
        }

        console.log("element",element)

        var topPos = element.offsetTop;
        // var bottomPos = topPos + element.scrollHeight;

        var last = document.getElementById("last-chat-element-" + self.selectedOS);

        var dif = last.scrollHeight + last.offsetTop - topPos + 200;

        console.log("topPos", topPos);
        console.log("last.scrollHeight", last.scrollHeight);
        console.log("last.offsetTo", last.offsetTop);

        var i = 0;
        var pros = [20, 20, 12, 10, 10, 10, 12, 16, 20];
        while (i < 9) {
          let position = dif / pros[i];
          if (isNaN(position)) {
            break;
          }
          element.scrollTop += position;
          last.scrollIntoView({ behavior: "smooth", block: "end" });
          i++;
          await this.sleep(25);
        }
      }
      
      await this.sleep(2500);
      self.recorder.stopRecording(function () {
        self.isStoppedRecording = true;
        self.isRecordingStarted = false;
        let link = document.getElementById("download_video");
        var blob = self.recorder.getBlob();
        link.href = URL.createObjectURL(blob);
        link.click();

        // window.open(URL.createObjectURL(blob));
      });
    },
    makeVideo() {
      let self = this;

      while (self.chatRight.length > 0) {
        self.chatRight.pop();
      }
      while (self.chatLeft.length > 0) {
        self.chatLeft.pop();
      }

      while (self.tempChats.length > 0) {
        self.tempChats.pop();
      }

      while (self.chats.length > 0) {
        let msg = self.chats.pop();
        self.tempChats.push(msg);
      }

      var elementToRecord = document.querySelector("#chat_to_print_" + self.selectedOS)
      console.log("elementToRecord", elementToRecord)

      var canvas2d = document.getElementById("background-canvas");
      var context = canvas2d.getContext("2d");
      // canvas2d.width = elementToRecord.clientWidth * 3;
      // canvas2d.height = elementToRecord.clientHeight * 3;
      canvas2d.width = elementToRecord.clientWidth * 2;
      canvas2d.height = elementToRecord.clientHeight * 2;

      (function looper() {
        if (!self.isRecordingStarted) {
          return setTimeout(looper, 100);
        }

        html2canvas(elementToRecord, {
          scale: 3,
          allowTaint: true,
          useCORS: true,
          letterRendering: true,
          backgroundColor: "#000",
        }).then(function (canvas) {
          // let link = document.getElementById("create_screenshot_and_print");
          // let url = canvas.toDataURL("image/jpeg");
          // link.href = url;
          // link.click();
          // return;
          context.clearRect(0, 0, canvas2d.width, canvas2d.height);
          context.drawImage(canvas, 0, 0, canvas2d.width, canvas2d.height);
          
          if (self.isStoppedRecording) {
            return;
          }

          requestAnimationFrame(looper);
        });
      })();

      this.recorder = new RecordRTC(canvas2d, {
        type: "canvas",
      });

      this.disabled = true;

      self.isStoppedRecording = false;
      self.isRecordingStarted = true;

      this.recorder.startRecording();

      self.demo();
    },
    async post(formData, curTime) {
      let self = this;
      await axios.post(self.serverIp + "/api/message_insert", formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });

      self.postIndex -= 1;
      if (self.postIndex === 0) {
        self.loadingBar = false;
        if (curTime !== null) {
          self.loadOptions.push(curTime);
          self.showAlert("saved sdfsdf successfully!");
        } else {
          self.showAlert("updated successfully!");
        }
      }
    },
    handleConfirm() {
      let self = this;
      this.$confirm({
        message: `Would you like to save it as a new conversation?`,
        button: {
          no: "No",
          yes: "Yes",
        },
        /**
         * Callback Function
         * @param {Boolean} confirm
         */
        callback: (confirm) => {
          var formData = new FormData();
          if (confirm) {
            // ... do something
            this.$prompt("Input your name").then((text) => {
              // do somthing with text
              self.loadingBar = true;
              let curTime = text + " (" + this.generateToday() + ")";

              formData.append("time", curTime);
              formData.append("avatar", self.profilePath);
              formData.append("background", self.background);
              formData.append("name", self.name);
              formData.append("lastseen", self.lastSeen);
              formData.append("ptime", self.time);

              formData.append(
                "androidIcons",
                JSON.stringify(self.androidIcons)
              );
              formData.append("iosIcons", JSON.stringify(self.iosIcons));

              axios
                .post(self.serverIp + "/api/conversation_insert", formData, {
                  headers: {
                    "Content-Type": "multipart/form-data",
                  },
                })
                .then(function (response) {
                  self.postIndex = self.chats.length;
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
                    formData.append("con_id", response.data);
                    self.post(formData, curTime);
                  });
                })
                .catch(function (error) {
                  self.log("error", error);
                  self.showAlert("Save failed :(");
                  self.loadingBar = false;
                });
            });
          } else {
            self.loadingBar = true;
            if (self.curLoadMode === "") {
              self.showAlert("Please load the conversation! :(");
              self.loadingBar = false;
              return;
            }
            formData.append("time", self.curLoadMode);
            formData.append("avatar", self.profilePath);
            formData.append("background", self.background);
            formData.append("name", self.name);
            formData.append("lastseen", self.lastSeen);
            formData.append("androidIcons", JSON.stringify(self.androidIcons));
            formData.append("iosIcons", JSON.stringify(self.iosIcons));
            formData.append("ptime", self.time);

            axios
              .post(self.serverIp + "/api/conversation_getByTime", formData, {
                headers: {
                  "Content-Type": "multipart/form-data",
                },
              })
              .then(function (response) {
                self.postIndex = self.chats.length;
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
                  formData.append("con_id", response.data);
                  self.post(formData, null);
                });
              })
              .catch(function (error) {
                self.log("error", error);
                self.showAlert("Save failed :(");
              });
          }
        },
      });
    },
    handleDeleteList() {
      let self = this;
      this.$confirm({
        message: `Would you like to delete it?`,
        button: {
          no: "No",
          yes: "Yes",
        },
        /**
         * Callback Function
         * @param {Boolean} confirm
         */
        callback: (confirm) => {
          var formData = new FormData();
          if (confirm) {
            // ... do something

            formData.append("time", self.loadmode);

            axios
              .post(self.serverIp + "/api/conversation_delByTime", formData, {
                headers: {
                  "Content-Type": "multipart/form-data",
                },
              })
              .then(function (response) {
                if (response.data === "success") {
                  self.showAlert("Successfully deleted.");
                  self.curLoadMode = "";
                  self.loadmode = "";
                  while (self.chatRight.length > 0) {
                    self.chatRight.pop();
                  }
                  while (self.chatLeft.length > 0) {
                    self.chatLeft.pop();
                  }
                  while (self.chats.length > 0) {
                    self.chats.pop();
                  }
                  window.location.href = "http://192.168.109.22:8080";
                }
              })
              .catch(function (error) {
                self.log("error", error);
              });
          }
        },
      });
    },
  },
};
</script>
<style>
.vs__clear {
  display: none;
}
.chooser .vs__dropdown-menu {
  background: white;
  border: none;
  color: white;
  text-transform: lowercase;
  font-variant: small-caps;
}
.chooser .vs__search::placeholder,
.chooser .vs__dropdown-toggle {
  background: transparent;
  border: none;
  color: white;
  text-transform: lowercase;
  font-variant: small-caps;
  height: 3.3rem;
}

.vs__search {
  display: none;
}

.chooser .vs__clear,
.chooser .vs__open-indicator {
  fill: white;
  color: red;
}

.vs__dropdown-toggle {
  border: 1px solid white !important;
  padding-top: 0.8rem !important;
  padding-bottom: 0.7rem !important;
}

.vs__selected {
  color: white;
}

.vs__selected-options {
  display: flex;
  flex-basis: 100%;
  flex-grow: 1;
  /* flex-wrap: wrap; */
  padding: 0 2px;
  position: relative;
  overflow: hidden;
}

.vs__dropdown-option {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 320%;
}

.del {
  color: white;
  font-family: cursive !important;
  cursor: pointer;
  position: absolute;
  left: 10.5rem;
  top: 1.19rem;
}

.del:hover {
  color: #ae1818;
}
</style>
<style scoped>
.container {
  display: grid;
  height: 100%;
  grid-template-rows: 1fr 70px 600px 30px;
  position: relative;
  overflow-y: auto;
  overflow-x: hidden;
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

.hideClass {
  display: none;
}

.video-button {
  position: absolute;
  right: -5.4rem;
  top: 2rem;
}

.video-button:hover {
  right: -2rem;
}

.video-button__content:hover {
  background-color: #c40004;
}

.video-button__content {
  display: inline-block;
  cursor: pointer;
  padding: 0.8rem 5.5rem 0.8rem 2.3rem;
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

#jsontip {
  transition: 0.7s;
  width: 14rem;
  padding: 0.9rem;
  position: relative;
  bottom: 0.05em;
  border-radius: 4px;
  margin-right: 1rem;
  background: transparent;
  border-color: white;
  color: white;
  font-size: 20px;
}

.load-button {
  position: absolute;
  right: -5rem;
  top: 17rem;
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

.colGrid1 {
  grid-column: 1;
  grid-row: 1;
}

.colGrid2 {
  grid-column: 2;
}

.colGrid3 {
  grid-column: 3;
  grid-row: 1;
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

#loadoption {
  float: left;
  width: 14rem;
  position: relative;
  top: 2.5px;
  right: 1rem;
}

.screen-setting-panel {
  position: absolute;
  left: 23px;
  top: 7.6rem;
}

.panel {
  margin-top: 10px;
  margin-bottom: 10px;
}

.panel span {
  color: white;
  font-size: 22px;
}

#screen-width {
  line-height: 26px;
  font-size: 18px;
  background: transparent;
  border: 1px solid white;
  height: 37px;
  color: white;
  margin-left: 7px;
}

#screen-height {
  line-height: 26px;
  font-size: 18px;
  background: transparent;
  border: 1px solid white;
  height: 37px;
  color: white;
}

.preview-thumb {
  width: 500px;
}

.thumb-gallery {
  display: inline;
}

.thumb-image {
  cursor: pointer;
  display: inline;
  height: 42px;
  margin: 0 4px;
  position: relative;
  vertical-align: middle;
  margin-top: 1rem;
}

.modal-content {
  margin-top: 1rem;
}

.modal-content .thumb-image {
  height: 400px;
}

.modal-footer button {
  border: none;
  display: inline-block;
  padding: 8px 16px;
  vertical-align: middle;
  overflow: hidden;
  text-decoration: none;
  color: inherit;
  background-color: inherit;
  text-align: center;
  cursor: pointer;
  white-space: nowrap;
  background-color: #04aa6d !important;
  color: white !important;
  font-size: 17px;
  border: 1px solid #cccccc;
  border-radius: 5px;
  margin-top: 1rem;
}

.modal-footer button:hover {
  background-color: rgb(86, 214, 167) !important;
}
</style>
