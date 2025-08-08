import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "preview", "placeholder"]

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
}
