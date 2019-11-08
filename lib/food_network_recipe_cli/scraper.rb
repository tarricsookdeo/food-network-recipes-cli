class FoodNetworkRecipeCli::Scraper

    def self.search_url_generator(search_term)
        search_url = "https://www.foodnetwork.com/search/"
        recipies_only_filter = "/CUSTOM_FACET:RECIPE_FACET"

        split_term = search_term.split(" ")

        split_term.each { |term|
            search_url << term + "-"
        }

        search_url << recipies_only_filter
        get_page_and_recipes(search_url, search_term)
    end

    def self.get_page_and_recipes(url, search_term)
        doc = Nokogiri::HTML(open(url))
        searched_recipes = doc.css(".o-RecipeResult")

        searched_recipes.each do |recipe|
            new_recipe = {}
            new_recipe["name"] = recipe.search(".m-MediaBlock__a-HeadlineText").text
            new_recipe["total_time"]= recipe.search("dd").text
            new_recipe["url"] = recipe.search(".m-MediaBlock__a-Headline a").attr("href").value.gsub("//", "")
            FoodNetworkRecipeCli::Recipe.new_from_scrape(new_recipe)
        end
    end

    def self.scrape_recipe(recipe)
        doc = Nokogiri::HTML(open("https://#{recipe.url}"))
        recipe.ingredients = []
        recipe.directions = []
        
        ingredients = doc.search(".o-Ingredients__a-Ingredient")
        directions = doc.search(".o-Method__m-Step")

        ingredients.each do |ingredient|
            recipe.ingredients << ingredient.text.strip
        end

        directions.each do |direction|
            recipe.directions << direction.text.strip
        end
    end
end