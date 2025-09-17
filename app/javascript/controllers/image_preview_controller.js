import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "preview", "placeholder", "brightnessSlider"]

    connect() {
        this.updateDisplay()
        this.initializeBrightness()
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
            this.applyBrightness()
        }
        reader.readAsDataURL(file)
    }

    initializeBrightness() {
        if (this.hasBrightnessSliderTarget) {
            this.applyBrightness()
        }
    }
    adjustBrightness() {
        this.applyBrightness()
    }

    applyBrightness() {
        if (!this.hasBrightnessSliderTarget || !this.hasPreviewTarget) return

        const brightnessValue = this.brightnessSliderTarget.value
        // スライダー値50を基準点とし、正確に標準の明るさ（1.0）に設定
        const cssValue = (brightnessValue - 50) / 50 * 0.7 + 1.0
        this.previewTarget.style.filter = `brightness(${cssValue})`
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
