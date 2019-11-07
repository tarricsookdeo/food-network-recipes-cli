class FoodNetworkRecipeCli::Recipe

    attr_accessor :name, :total_time, :url, :search_term
    @@all = []

    def initialize
        @@all << self
    end

    def self.new_from_scrape(recipe_hash)
        recipe = self.new
        recipe.name = recipe_hash["name"]
        recipe.total_time = recipe_hash["total_time"]
        recipe.url = recipe_hash["url"]
        recipe.search_term = recipe_hash["search_term"]
    end

    def self.find_by_search_term(search_term)
        @@all.collect { |r| r.search_term == search_term }
    end

    def self.all
        @@all
    end
end