console.log("JavaScript file loaded successfully!");

// Function to validate email format
function isValidEmail(email) {
    // Basic regex for email validation
    const emailRegex = /^\S+@\S+\.\S+$/;
    return emailRegex.test(email);
}

// Placeholder for image slider initialization
function initializeImageSlider() {
    console.log("Image slider initialization placeholder - to be implemented.");
    // Later, you would add code here to find the slider element (e.g., by id 'hero-slider')
    // and implement its functionality (e.g., changing images, adding controls).
}

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