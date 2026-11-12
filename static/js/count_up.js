document.addEventListener("DOMContentLoaded", () => {
    const counters = document.querySelectorAll(".count-up");
    const duration = 1200;

    counters.forEach(counter => {
        const target = parseInt(counter.dataset.target, 10);
        const startTime = performance.now();

        function updateCounter(currentTime) {
            const progress = Math.min((currentTime - startTime) / duration, 1);

            // Ease-out animation
            const easedProgress = 1 - Math.pow(1 - progress, 3);

            const currentValue = Math.floor(easedProgress * target);

            counter.textContent = currentValue.toLocaleString();

            if (progress < 1) {
                requestAnimationFrame(updateCounter);
            } else {
                counter.textContent = target.toLocaleString();
            }
        }

        requestAnimationFrame(updateCounter);
    });
});