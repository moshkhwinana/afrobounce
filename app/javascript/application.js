// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load",() => {
  const flashes = document.querySelectorAll(".alert");

  flashes.forEach(flash => {
    setTimeout(() => {
      flash.style.display = "none";
    }, 3000); // Adjust time if needed
  });
});



// const flash = document.querySelector(".alert");
// if (flash) {
//   setTimeout(() => {
//     flash.style.display = "none";
//   }, 3000);
// }
// });
// turbo:load is better to use, rather than DOMContentLoaded (better for non-turbo apps), for turbo apps.
