function showInnings(innings, button) {
    // Show the selected innings and hide the other
    if (innings === 1) {
        document.getElementById('innings-1').style.display = 'block';
        document.getElementById('innings-2').style.display = 'none';
    } else {
        document.getElementById('innings-1').style.display = 'none';
        document.getElementById('innings-2').style.display = 'block';
    }

    // Remove 'selected' class from both buttons
    document.getElementById('btn-1st-inn').classList.remove('selected');
    document.getElementById('btn-2nd-inn').classList.remove('selected');

    // Add 'selected' class to the clicked button
    button.classList.add('selected');
}