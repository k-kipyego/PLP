console.log("JavaScript file loaded successfully!");

// Function to validate email format
function isValidEmail(email) {
    // Basic regex for email validation
    const emailRegex = /^\S+@\S+\.\S+$/;
    return emailRegex.test(email);
}

// --- Image Slider Logic ---
let slideIndex = 1;
let slideInterval; // For auto-sliding

// Function to be called to initialize the slider
function initializeImageSlider() {
    console.log("Initializing image slider...");
    showSlides(slideIndex);
    // Uncomment to enable auto-sliding
    // startSlideInterval(); 
}

// Next/previous controls
function plusSlides(n) {
    showSlides(slideIndex += n);
    // If you have auto-sliding, reset the interval on manual navigation
    // resetSlideInterval(); 
}

// Thumbnail image controls
function currentSlide(n) {
    showSlides(slideIndex = n);
    // resetSlideInterval();
}

function showSlides(n) {
    let i;
    let slides = document.getElementsByClassName("slide");
    let dots = document.getElementsByClassName("dot");
    if (!slides.length || !dots.length) return; // Do nothing if slider elements are not found

    if (n > slides.length) {slideIndex = 1}
    if (n < 1) {slideIndex = slides.length}

    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active-dot", "");
    }

    slides[slideIndex-1].style.display = "block";
    dots[slideIndex-1].className += " active-dot";
}

// Optional: Auto-sliding functionality
/* 
function startSlideInterval() {
    slideInterval = setInterval(function() {
        plusSlides(1);
    }, 5000); // Change image every 5 seconds
}

function resetSlideInterval() {
    clearInterval(slideInterval);
    startSlideInterval();
}
*/

// --- End Image Slider Logic ---

document.addEventListener('DOMContentLoaded', function() {
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', function(event) {
            event.preventDefault(); // Prevent actual submission

            const nameInput = document.getElementById('name');
            const emailInput = document.getElementById('email');
            const messageInput = document.getElementById('message');

            const name = nameInput.value.trim();
            const email = emailInput.value.trim();
            const message = messageInput.value.trim();
            let isValid = true;
            let errors = [];

            if (name === '') {
                isValid = false;
                errors.push('Name is required.');
                // You could also add an error class to the input: nameInput.classList.add('error');
            }

            if (email === '') {
                isValid = false;
                errors.push('Email is required.');
            } else if (!isValidEmail(email)) {
                isValid = false;
                errors.push('Please enter a valid email address.');
            }

            if (message === '') {
                isValid = false;
                errors.push('Message is required.');
            }

            if (isValid) {
                alert('Form submitted successfully (placeholder)!\nName: ' + name + '\nEmail: ' + email + '\nMessage: ' + message);
                contactForm.reset(); // Reset form fields
                // Clear any error messages or styles here
            } else {
                alert('Please correct the following errors:\n' + errors.join('\n'));
                // Display errors more gracefully in the UI in a real application
            }
        });
    }

    // Initialize image slider if it exists on the page
    if (document.getElementById('hero-slider')) {
        initializeImageSlider();
    }
}); 