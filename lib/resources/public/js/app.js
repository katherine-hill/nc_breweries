(function() {
    "use strict";
    const brewModule = function() {
        const searchBar = document.querySelector('.search-nav');
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
                    id: this.id,
                    name: this.name,
                    location: this.location
                };
                const html = template(context);
                $('.legit-brewery-container').append(html);
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
                $('.beer-actual-container[data-id=1]').append(html);

            }
        }

        function bindEvents() {
            // getSearchValue();
            showBreweries();
            showBeers();
            returnHome();

        }


        function getBreweries() {
            const settings = {
                "async": true,
                "crossDomain": true,
                "url": `data/beer-objects.json`,
                "method": "GET"
            };

            $.ajax(settings).then(function(response) {
                for (let i = 0; i < response.length; i++) {
                    new Breweries(response[i]);
                }
                createCarousel();
                console.log(response);
            });

        }

        function getBeers(arg) {
            const settings = {
                "async": true,
                "crossDomain": true,
                "url": `data/beers.json`,
                "method": "GET"
            };
            $.ajax(settings).then(function(response) {
                for (let i = 0; i < response.length; i++) {
                  if (arg == response[i].brewery_id) {
                    new Beers(response[i]);
                  } else {
                    console.log('not gon do it');
                  }
                }
            });
        }

        function showBreweries() {

            breweryButton.addEventListener('click', () => {
                event.preventDefault();
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
            $(document).ready(() => {
                $('.legit-brewery-container').slick({
                    infinite: true,
                    slidesToShow: 1,
                    slidesToScroll: 1
                });

            });
        }

        function displayCarousel() {


            $('.beer-and-brewery-container').toggleClass('hide');

        }

        function init() {
            bindEvents();
            getBreweries();
        }

        return {
            init: init
        };

    };

    const brewApp = brewModule();
    brewApp.init();

})();
