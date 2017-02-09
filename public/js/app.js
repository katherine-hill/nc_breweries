(function () {
  "use strict"
  const brewModule = function () {
    const searchBar = document.querySelector('.search-nav');

    function bindEvents() {
      getSearchValue();
    }

    function getSearchValue() {
      searchBar.addEventListener('submit', () => {
        event.preventDefault();
        console.log(event.target[0].value);
      })
    }

    function init() {
      bindEvents();
    }

    return {
      init: init
    }

  }

  const brewApp = brewModule();
  brewApp.init();

})();
