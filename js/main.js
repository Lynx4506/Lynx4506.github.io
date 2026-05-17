document.addEventListener("DOMContentLoaded", () => {
  const filterButtons = document.querySelectorAll("[data-filter]");
  const albumCards = document.querySelectorAll("[data-category]");

  filterButtons.forEach((button) => {
    button.addEventListener("click", () => {
      const category = button.dataset.filter;

      filterButtons.forEach((item) => item.classList.remove("active"));
      button.classList.add("active");

      albumCards.forEach((card) => {
        const matches = category === "all" || card.dataset.category === category;
        card.style.display = matches ? "" : "none";
      });
    });
  });
});
