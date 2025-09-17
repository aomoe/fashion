import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "preview", "placeholder", "brightnessSlider"]

    connect() {
        this.debounceTimer = null
        this.initializeBrightness()
    }

    adjustBrightness() {
        const postId = this.previewTarget.dataset.postId

        if (postId && this.previewTarget.src && !this.previewTarget.src.startsWith('data:')) {
            // 既存の投稿編集時：ImageMagickで処理
            clearTimeout(this.debounceTimer)
            this.debounceTimer = setTimeout(() => {
                this.processImageMagickBrightness()
            }, 300)
        } else {
            // 新しい画像アップロード時：CSS filterで即座に処理
            this.applyCSSBrightness()
        }
    }

    async processImageMagickBrightness() {
        const postId = this.previewTarget.dataset.postId
        const brightnessValue = this.brightnessSliderTarget.value

        if (!postId) return

        try {
            this.showLoadingState()

            const response = await fetch(`/posts/${postId}/preview_brightness`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
                },
                body: JSON.stringify({
                    brightness_level: brightnessValue
                })
            })

            if (response.ok) {
                const data = await response.json()
                this.previewTarget.src = data.preview_url
            } else {
                console.error('Failed to generate preview')
            }
        } catch (error) {
            console.error('Error:', error)
        } finally {
            this.hideLoadingState()
        }
    }

    showLoadingState() {
        this.previewTarget.style.opacity = '0.5'
    }

    hideLoadingState() {
        this.previewTarget.style.opacity = '1'
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
            // 新しい画像アップロード時はCSS filterで即座に調整
            this.applyCSSBrightness()
        }
        reader.readAsDataURL(file)
    }

    applyCSSBrightness() {
        if (!this.hasBrightnessSliderTarget || !this.hasPreviewTarget) return

        const brightnessValue = this.brightnessSliderTarget.value
        const cssValue = (brightnessValue - 50) / 50 * 0.7 + 1.0
        this.previewTarget.style.filter = `brightness(${cssValue})`
    }

    initializeBrightness() {
        if (this.hasBrightnessSliderTarget && this.hasPreviewTarget) {
            // 既存の画像に対してCSS filterで初期明度調整を適用
            if (this.previewTarget.src && this.previewTarget.style.display !== "none") {
                this.applyCSSBrightness()
            }
        }
    }
}
