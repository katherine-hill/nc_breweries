(function() {
    "use strict";
    const brewModule = function() {
        const searchBar = document.querySelector('.search-nav');
        const searchBrews = document.querySelector('.search-breweries');
        const breweryButton = document.querySelector('.show-breweries');
        const beerButton = document.querySelector('.beer-button');
        const heroSection = document.querySelector('.hero');
        const returnHomeBtn = document.querySelector('.return-home');

        class Breweries {
            constructor(details) {
                this.id = details.id;
                this.name = details.name;
                this.location = details.location;
                this.build();
            }

            build() {
                const source = $('#brewery-template').html();
                const template = Handlebars.compile(source);
                const context = {
                    id: "Brewery ID: " + this.id,
                    name: this.name,
                    location: this.location + ", NC",
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
                    rating: this.rating,
                    brewery_id: this.brewery_id

                };
                const html = template(context);
                $('.legit-brewery-container').prepend(html);

            }
        }

        function bindEvents() {
            // getSearchValue();
            showBreweries();
            showBeers();
            returnHome();
            searchTheSite();

        }


        function getBreweries() {
            const settings = {
                "async": true,
                "crossDomain": true,
                "url": '/api/brewery',
                "method": "GET"
            };

            $.ajax(settings).then(function(response) {
                let results = JSON.parse(response);
                for (let i = 0; i < results.length; i++) {
                    new Breweries(results[i]);
                }
                createCarousel();
                console.log(results);
            });

        }

        function getBreweries2(arg) {
            const settings = {
                "async": true,
                "crossDomain": true,
                "url": `/api/brewery`,
                "method": "GET"
            };

            $.ajax(settings).then(function(response) {
                let results = JSON.parse(response);
                for (let i = 0; i < response.length; i++) {
                  if (arg == results[i].location.toLowerCase()) {
                    new Breweries(results[i]);
                  } else if (arg == results[i].name.toLowerCase()) {
                    new Breweries(results[i]);
                  } else {
                    console.log('nada');
                  }
                }
            });

        }

        function getBeers(arg) {
            const settings = {
                "async": true,
                "crossDomain": true,
                "url": '/api/beer',
                "method": "GET"
            };
            $.ajax(settings).then(function(response) {
              let results = JSON.parse(response);
                for (let i = 0; i < response.length; i++) {
                  if (arg == results[i].kind.toLowerCase()) {
                    console.log(results[i]);
                    new Beers(results[i]);
                  }
                }
            });
        }

        function showBreweries() {

            breweryButton.addEventListener('click', () => {
                event.preventDefault();
                getBreweries();
                displayCarousel();
                $('.hero').toggleClass('hide');
                $('.carousel-nav').toggleClass('hide');

            });
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

        function showBeers() {
            $('.legit-brewery-container').on('click', '.beer-button', function() {
                event.preventDefault();
                let beerBtnId = $(this).attr("data-id");
                getBeers(beerBtnId);
            });
        }

        function createCarousel() {
            // $(document).ready(() => {
            //     $('.legit-brewery-container').slick({
            //         infinite: true,
            //         slidesToShow: 15,
            //         slidesToScroll: 5
            //     });
            //
            // });
        }

        function displayCarousel() {


            $('.beer-and-brewery-container').toggleClass('hide');

        }

        function searchTheSite() {
            searchBrews.addEventListener('submit', () => {
              event.preventDefault();
              $('.legit-brewery-container').html('');
              console.log(event.target[0].value);
              let searchTerm = event.target[0].value;
              let flexTerm = searchTerm.toLowerCase();
              getBreweries2(flexTerm);
              getBeers(flexTerm);
              searchBrews.reset();
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
