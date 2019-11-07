class FoodNetworkRecipeCli::CLI

    def call
        welcome
        menu
    end

    def welcome
        puts <<~DOC
        ------------------------------------------------------------------------------------------------------
        GREETING:

        Hello from The Food Network Recipes CLI! In this CLI app, you will be able to search for
        recipes using a keyword such as 'chicken', then see a list of recipes featured on The Food Network's
        website. See one you like? you can then request more details on the recipe! Lets get started!
        ------------------------------------------------------------------------------------------------------
        DOC
    end

    def search
        print "Enter a keyword you would like to search for (eg. chicken, stew, or beef burger): "
        @search_term = gets

        FoodNetworkRecipeCli::Scraper.search_url_generator(@search_term)
        puts "Getting recipes for #{@search_term}"
    end

    def list_recipes
        recipes = FoodNetworkRecipeCli::Recipe.all

        if recipes == []
            puts "There are currently no recipes to list. Please search a recipe first."
        else
            puts "------------------------------------------------------------------------------------------------------"
            recipes.each.with_index(1) { |recipe, i|
                puts "#{i}. #{recipe.name} - #{recipe.total_time}"
            }
            puts "------------------------------------------------------------------------------------------------------"
        end

    end

    def goodbye
        puts "Thanks for using!"
    end

    def menu
        input = nil

        while input != "exit"
            puts <<~DOC
            ------------------------------------------------------------------------------------------------------
            MENU:

            Type 'search' to use a search term to lookup recipes.
            Type the number of the recipe you would like more info on.
            Type 'list' to list recipes.
            Type 'exit' to exit application.
            ------------------------------------------------------------------------------------------------------
            DOC

            input = gets.strip.downcase

            if input == "search"
                search
            elsif input == "list"
                list_recipes
            elsif input == "exit"
                goodbye
            elsif input.to_i > 0
                if input.to_i <= FoodNetworkRecipeCli::Recipe.all.size
                    recipe = FoodNetworkRecipeCli::Recipe.all[input.to_i-1]
                    puts "#{recipe.name} - #{recipe.total_time}"
                else
                    puts "Invalid index."
                end
            else
                puts "Invalid command. Please type a valid command."
            end
        end
    end
end