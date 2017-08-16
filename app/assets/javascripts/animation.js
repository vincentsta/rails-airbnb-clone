const animateFilterBtn = () => {
  var filterBtn = document.getElementById("filter-btn");
  var filterVisibility = -1;
  filterBtn.addEventListener("click", (event) => {
    event.preventDefault;
    var filterForm = document.getElementById("filter");
    var criteriaHome = document.getElementById("home-search-criteria");
    filterVisibility = filterVisibility * -1;
    if (filterVisibility === 1) TweenLite.to(filterForm, 0.5, {className:"-=collapse"});
    if (filterVisibility === -1) TweenLite.to(filterForm, 0.5, {className:"+=collapse"});
    TweenLite.to(criteriaHome, 0.5, {className:"+=collapse"});
  });
};

const rotateCards = () => {
  var cards = document.querySelectorAll(".card");
  cards.forEach((card) => {
    TweenLite.set(".card", {perspective:800});
    TweenLite.set(".card-main", {transformStyle:"preserve-3d"});
    TweenLite.set(".back", {rotationY:-180});
    TweenLite.set([".back", ".front"], {backfaceVisibility:"hidden"});
    $(".card").hover(
      function() {
        TweenLite.to($(this).find(".card-main"), 1.2, {rotationY:180, ease:Back.easeOut});
      },
      function() {
        TweenLite.to($(this).find(".card-main"), 1.2, {rotationY:0, ease:Back.easeOut});
      }
    );
  });
};
