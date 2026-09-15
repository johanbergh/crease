// Theme toggle (stored in localStorage)
(function () {
    const root = document.documentElement;
    const iconEl = document.getElementById("theme-icon");

    function applyTheme(theme) {
        if (theme === "dark") {
            root.setAttribute("data-theme", "dark");
            if (iconEl) iconEl.className = "fa-solid fa-sun fa-lg";
        } else {
            root.removeAttribute("data-theme");
            if (iconEl) iconEl.className = "fa-solid fa-moon fa-lg";
        }
    }

    const saved = localStorage.getItem("crease-theme") || "light";
    applyTheme(saved);

    window.toggleTheme = function () {
        const current = localStorage.getItem("crease-theme") || "light";
        const next = current === "dark" ? "light" : "dark";
        localStorage.setItem("crease-theme", next);
        applyTheme(next);
    };
})();