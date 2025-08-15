import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["panel"]

    connect() {
        // 初期状態: .is-active を持つパネルだけ表示
        this.showPanel(this.activeName() || "photo")
    }

    switch(event) {
        const name = event.currentTarget.dataset.tabsName
        this.showPanel(name)
        // 見出しの active 表示切替
        event.currentTarget.closest(".tab-list").querySelectorAll(".tab").forEach(btn => {
        btn.classList.toggle("is-active", btn.dataset.tabsName === name)
        })
    }

    showPanel(name) {
        this.panelTargets.forEach(panel => {
        panel.classList.toggle("is-active", panel.dataset.tabsName === name)
        })
    }

    activeName() {
        const activePanel = this.panelTargets.find(p => p.classList.contains("is-active"))
        return activePanel?.dataset.tabsName
    }
}