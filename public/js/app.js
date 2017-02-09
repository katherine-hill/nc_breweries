(function () {
  "use strict"
  const brewModule = function () {
    const searchBar = document.querySelector('.search-nav');
    const breweryButton = document.querySelector('.show-breweries');

    function bindEvents() {
      // getSearchValue();
      showBreweries();
    }

    function displayBreweries() {
      $.get('./data/beer-objects.json').then((response) => {
        console.log(response);
      }).catch((error) => {
        console.log(error);
      });
    }

    // function getSearchValue() {
    //   searchBar.addEventListener('submit', () => {
    //     event.preventDefault();
    //     console.log(event.target[0].value);
    //   })
    // }

    function showBreweries() {
      breweryButton.addEventListener('click', () => {
          event.preventDefault();
          displayBreweries();
        });
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
