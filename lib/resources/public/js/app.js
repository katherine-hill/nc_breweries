(function() {
    "use strict";
    const brewModule = function() {
        const searchBarByBrewery = document.querySelector('.search-nav-1');
        const searchBarByBeer = document.querySelector('.search-nav-2');
        const breweryButton = document.querySelector('.show-breweries');
        const beerButton = document.querySelector('.beer-button');
        const heroSection = document.querySelector('.hero');
        const returnHomeBtn = document.querySelector('.return-home');

        class Breweries {
            constructor(details) {
                this.id = details.id;
                this.name = details.name;
                this.location = details.location;
                this.beers = details.beers;
                this.build();
            }

            build() {
                const source = $('#brewery-template').html();
                const template = Handlebars.compile(source);
                const context = {
                    id: "Brewery ID: " + this.id,
                    name: this.name,
                    location: this.location + ", NC",
                    beers: this.beers
                };
                const html = template(context);
                $('.legit-brewery-container').prepend(html);

            }

        }

        class Beers {
            constructor(details) {
                this.id = details.id;
                this.name = details.name;
                this.kind = details.kind;
                this.description = details.description;
                this.rating = details.rating;
                this.build();
            }
            build() {
                const source = $('#beer-template').html();
                const template = Handlebars.compile(source);
                const context = {
                    id: this.id,
                    name: this.name,
                    kind: this.kind,
                    description: this.description,
                    rating: this.rating,
                    brewery_id: this.brewery_id

                };
                const html = template(context);
                $('.beer-actual-container').prepend(html);
                console.log(html);

            }
        }

        function bindEvents() {
            // getSearchValue();
            showBreweries();
            showBeersInsideBreweries();
            returnHome();
            searchTheSiteBreweries();
            searchTheSiteBeers();

        }


        function getBreweries() {
            const settings = {
                "async": true,
                "crossDomain": true,
                // "url": 'https://nc-beers.herokuapp.com/api/brewery',
                "url": 'data/beer-objects.json',
                "method": 'GET',
                "dataType": 'json'
            };

            $.ajax(settings).then(function(results) {
                // let results = JSON.parse(response);

                for (let i = 0; i < results.length; i++) {
                    new Breweries(results[i]);
                }
            });

        }

        function addAbeer() {

        }

        function getBreweriesByCity(arg) {
            // arg = encodeURICompnent(arg);
            const settings = {
                "async": true,
                "dataType": 'json',
                "contentType": 'application/json',
                "crossDomain": true,
                "url": `data/beer-objects.json`,
                "method": "GET"
            };

            $.ajax(settings).then(function(results) {
              // let results = JSON.parse(response);
                for (let i = 0; i < results.length; i++) {
                  if (arg == results[i].location.toLowerCase()) {
                    new Breweries(results[i]);
                  // } else if (arg == response[i].name.toLowerCase()) {
                  //   new Breweries(response[i]);
                  } else {
                    console.log('no results');
                  }
                }
            });

        }

        function getBeersByType(arg) {
            // arg = encodeURICompnent(arg);
            const settings = {
                "async": true,
                "dataType": 'json',
                "contentType": 'application/json',
                "crossDomain": true,
                "url": `data/beers.json`,
                "method": "GET"
            };

            $.ajax(settings).then(function(results) {
              // let results = JSON.parse(response);
                for (let i = 0; i < results.length; i++) {
                  if (arg == results[i].kind.toLowerCase()) {
                    new Beers(results[i]);
                  // } else if (arg == response[i].name.toLowerCase()) {
                  //   new Breweries(response[i]);
                  } else {
                    console.log('no results');
                  }
                }
            });

        }


        function showBreweries() {
            breweryButton.addEventListener('click', () => {
                event.preventDefault();
                getBreweries();
                displaySearchPage();

            });
        }

        function displaySearchPage() {
          displayCarousel();
          $('.hero').toggleClass('hide');
          $('.carousel-nav').toggleClass('hide');
        }

        function returnHome() {

            returnHomeBtn.addEventListener('click', () => {
                event.preventDefault();
                $('.hero').toggleClass('hide');
                $('.carousel-nav').toggleClass('hide');
                $('.beer-and-brewery-container').toggleClass('hide');
                $('.beer-actual-container').html('');

            });
        }

        function showBeersInsideBreweries() {
            $('.legit-brewery-container').on('click', '.beer-button', function() {
                event.preventDefault();
                console.log('here');
                $(this).siblings().toggleClass('hide');
            });
        }

        function displayCarousel() {
            $('.beer-and-brewery-container').toggleClass('hide');

        }

        function searchTheSiteBreweries() {
            searchBarByBrewery.addEventListener('submit', () => {
              event.preventDefault();
              $('.legit-brewery-container').html('');
              displaySearchPage();
              let searchTerm = event.target[0].value;
              let flexTerm = searchTerm.toLowerCase();
              getBreweriesByCity(flexTerm);
              searchBarByBrewery.reset();
            });
        }

        function searchTheSiteBeers() {
            searchBarByBeer.addEventListener('submit', () => {
              event.preventDefault();
              $('.legit-brewery-container').html('');
              displaySearchPage();
              let searchTerm = event.target[0].value;
              let flexTerm = searchTerm.toLowerCase();
              getBeersByType(flexTerm);
              searchBarByBeer.reset();
            });
        }


        function init() {
            bindEvents();
        }

        return {
            init: init
        };

    };

    const brewApp = brewModule();
    brewApp.init();

})();
