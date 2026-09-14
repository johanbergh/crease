// Variables (to make it 10x easier)
var element = document.body;
var x = document.getElementById("icon");

// Checks Localstorage if prefence is saved
if (localStorage.getItem('color-theme') === 'dark') {
    element.className = 'dark-mode';
    x.innerHTML = '<i class="fa-solid fa-moon fa-xl"></i>'

    // White
} else if (localStorage.getItem('color-theme') === 'white') {
    element.className = '#';
    x.innerHTML = '<i class="fa-solid fa-sun fa-xl"></i>'

    // If no localstorage prefrence is saved
} else {
    localStorage.setItem('color-theme', 'white')
    element.className = '#';
    x.innerHTML = '<i class="fa-solid fa-sun fa-xl"></i>'
}



function color_mode() {
    // Gets Localstorage value
    theme = localStorage.getItem('color-theme')

    // Changes CSS & Icons accordingly
    if (theme === 'white') {
        localStorage.setItem('color-theme', 'dark')
        element.className = 'dark-mode';
        x.innerHTML = '<i class="fa-solid fa-moon fa-xl"></i>'

    } else if (theme === 'dark') {
        localStorage.setItem('color-theme', 'white')
        element.className = '#';
        x.innerHTML = '<i class="fa-solid fa-sun fa-xl"></i>'
    }




}