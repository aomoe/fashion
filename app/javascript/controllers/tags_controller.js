import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "list", "hidden"]

    connect() {
        this.tags = []
        this.syncHidden()
    }

    handleKeydown(event) {
        if (event.isComposing) return
        if (event.key === "Enter" || event.key === ",") {
        event.preventDefault()
        this.add()
        }
    }

    add() {
        const raw = this.inputTarget.value || ""
        const newNames = raw
        .split(/[,\s　]+/)
        .map((n) => n.trim())
        .filter((n) => n.length > 0)

        for (const name of newNames) {
        if (!this.tags.includes(name)) this.tags.push(name)
        }

        this.inputTarget.value = ""
        this.render()
        this.syncHidden()
    }

    remove(event) {
        const name = event.currentTarget.dataset.name
        this.tags = this.tags.filter((t) => t !== name)
        this.render()
        this.syncHidden()
    }

    render() {
        this.listTarget.innerHTML = ""
        for (const name of this.tags) {
        const chip = document.createElement("span")
        chip.className = "tag-chip"
        chip.textContent = name + " "

        const btn = document.createElement("button")
        btn.type = "button"
        btn.textContent = "×"
        btn.dataset.name = name
        btn.addEventListener("click", this.remove.bind(this))

        chip.appendChild(btn)
        this.listTarget.appendChild(chip)
        }
    }

    syncHidden() {
        if (this.hasHiddenTarget) {
        this.hiddenTarget.value = this.tags.join(", ")
        }
    }
}