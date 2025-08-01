import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.fadeOut();
    }, 2000);
  }

  fadeOut() {
    let opacity = 1;
    const fadeInterval = setInterval(() => {
      if (opacity <= 0) {
        clearInterval(fadeInterval);
        this.element.remove();
      } else {
        opacity -= 0.1;
        this.element.style.opacity = opacity;
      }
    }, 50); 
  }
}