$(document).ready(function() {

  // Check for click events on the navbar burger icon
  $(".navbar-burger").click(function() {
      // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
      $(".navbar-burger").toggleClass("is-active");
      $(".navbar-menu").toggleClass("is-active");

  });

  $(".navbar-burger-2").click(function() {
      // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
      $(".navbar-burger-2").toggleClass("is-active");
      $(".navbar-menu-2").toggleClass("is-active");

  });
});
