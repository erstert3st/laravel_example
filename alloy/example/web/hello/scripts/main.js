// This file contains JavaScript code that adds interactivity to the site. 
// It includes a function to display an alert with the "Hello World" message.

document.addEventListener('DOMContentLoaded', function() {
    const helloButton = document.getElementById('helloButton');
    
    if (helloButton) {
        helloButton.addEventListener('click', function() {
            alert('Hello World');
        });
    }
});