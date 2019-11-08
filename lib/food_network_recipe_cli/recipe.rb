class FoodNetworkRecipeCli::Recipe

    attr_accessor :name, :total_time, :url, :ingredients, :directions
    @@all = []

    def initialize
        @@all << self
    end

    def self.new_from_scrape(recipe_hash)
        recipe = self.new

        recipe_hash.each {|key, value| recipe.send("#{key}=", value)}
    end

    def self.all
        @@all
    end
end