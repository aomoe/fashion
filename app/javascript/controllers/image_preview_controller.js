import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "preview", "placeholder"]

    connect() {
        this.updateDisplay()
    }

    show() {
        const file = this.inputTarget.files[0]
        if (!file) {
            this.previewTarget.src = ""
            this.previewTarget.style.display = "none"
            if (this.hasPlaceholderTarget) this.placeholderTarget.style.display = ""
            return
        }

        const reader = new FileReader()
        reader.onload = (e) => {
            this.previewTarget.src = e.target.result
            this.previewTarget.style.display = ""
            if (this.hasPlaceholderTarget) this.placeholderTarget.style.display = "none"
        }
        reader.readAsDataURL(file)
    }

    updateDisplay() {
        // 初期表示時の表示制御
        if (this.previewTarget.src && this.previewTarget.src !== window.location.href) {
            // 画像が設定されている場合
            this.previewTarget.style.display = ""
            this.placeholderTarget.style.display = "none"
        } else {
            // 画像が設定されていない場合
            this.previewTarget.style.display = "none"
            this.placeholderTarget.style.display = ""
        }
    }
}
