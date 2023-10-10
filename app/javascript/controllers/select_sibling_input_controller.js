import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "radio", "checkbox" ]

  selectRadio() {
    this.radioTarget.checked = true
  }

  selectCheckbox() {
    this.checkboxTarget.checked = true
  }
}
