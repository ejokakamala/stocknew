import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["content"]
  connect() {
    
  }

  openNavbar(){
    this.contentTarget.hidden = false;
  }
}
