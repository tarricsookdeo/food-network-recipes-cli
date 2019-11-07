class FoodNetworkRecipeCli::Scraper

    def self.search_url_generator(search_term)
        search_url = "https://www.foodnetwork.com/search/"
        recipies_only_filter = "/CUSTOM_FACET:RECIPE_FACET"

        split_term = search_term.split(" ")

        split_term.each { |term|
            search_url << term + "-"
        }

        search_url << recipies_only_filter
        #get_page_and_recipies(search_url, search_term)
    end

end