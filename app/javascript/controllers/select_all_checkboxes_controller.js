import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "checkbox", "toggleCheckbox" ]

  toggle_option_checkbox({ srcElement }) {
    var allChecked = this.checkboxTargets.every((checkboxTarget) => checkboxTarget.checked) 
    this.toggleCheckboxTarget.checked = allChecked
  }

  toggle_select_all_checkbox({ srcElement }) {
    var is_checked = this.toggleCheckboxTarget.checked
    this.checkboxTargets.forEach((checkboxTarget) => {
      checkboxTarget.checked = is_checked
    })
  }
}
