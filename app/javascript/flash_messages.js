// Listen for the 'turbo:load' event
document.addEventListener('turbo:load', () => {
  // Select all HTML elements with the role "alert"
  const flashMessages = document.querySelectorAll('[role="alert"]');

  // Loop through each flash message
  for (const flashMessage of flashMessages) {
    // Wait 5 seconds (5000 milliseconds) before starting the animation
    setTimeout(() => {
      // Set the transition: opacity will change over 0.5 seconds with an ease-in-out effect
      flashMessage.style.transition = 'opacity 0.5s ease';

      // Set the opacity of the flash message to 0, effectively hiding it
      flashMessage.style.opacity = '0';

      // Wait 0.5 seconds (500 milliseconds) before removing the flash message
      setTimeout(() => {
        flashMessage.remove(); // Remove the flash message from the DOM
      }, 500);
    }, 5000);
  }
});
