// Innings switch for the scorecard panel
document.addEventListener("click", function (event) {
  const btn = event.target.closest("[data-innings-btn]");
  if (!btn) return;

  const scope = btn.closest("[data-scorecard]");
  if (!scope) return;

  const target = btn.getAttribute("data-innings-btn");

  scope.querySelectorAll("[data-innings-btn]").forEach((b) =>
    b.classList.remove("is-selected")
  );
  btn.classList.add("is-selected");

  scope.querySelectorAll("[data-innings-panel]").forEach((panel) => {
    panel.classList.toggle(
      "is-active",
      panel.getAttribute("data-innings-panel") === target
    );
  });
});
