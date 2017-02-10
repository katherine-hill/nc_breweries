(function() {
    "use strict";
    const brewModule = function() {
        const searchBar = document.querySelector('.search-nav');
        const breweryButton = document.querySelector('.show-breweries');
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
                    rating: this.rating

                };
                const html = template(context);
                $('.beer-actual-container').append(html);
            }
        }

        function bindEvents() {
            // getSearchValue();
            getBreweries();
            getBeers();

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
                console.log(response);
            });

        }

        function getBeers() {
            const settings = {
                "async": true,
                "crossDomain": true,
                "url": `data/beers.json`,
                "method": "GET"
            };
            $.ajax(settings).then(function(response) {
                for (let i = 0; i < response.length; i++) {
                    new Beers(response[i]);
                }
                console.log(response);
            });
        }

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
        };

    };

    const brewApp = brewModule();
    brewApp.init();

})();
