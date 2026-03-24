import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static targets = ["item"]
  static values = { url: String }

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: "[data-sortable-target='item']",
      onEnd: this.reorder.bind(this)
    })
  }

  disconnect() {
    this.sortable.destroy()
  }

  reorder() {
    const ids = this.itemTargets.map(el => el.id.replace("bookmark_", ""))

    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ ids })
    })
  }
}
