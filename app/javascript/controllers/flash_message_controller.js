import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("✅ FlashMessageController が実行されたよ！");
    this.showMessage();
  }

  showMessage() {
    const flashMessage = document.getElementById("flash-message");

    if (flashMessage && flashMessage.textContent.trim() !== "") {
      console.log("📌 flashMessage が見つかった！", flashMessage.textContent);

      flashMessage.classList.remove("hidden");

      setTimeout(() => {
        flashMessage.classList.add("hidden");
      }, 5000);
    } else {
      console.log("⚠️ flashMessage にメッセージが設定されていない...");
    }
  }
}