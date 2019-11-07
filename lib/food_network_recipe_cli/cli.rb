class FoodNetworkRecipeCli::CLI

    def call
        welcome
    end

    def welcome
        puts <<~DOC
        ------------------------------------------------------------------------------------------------------
        GREETING:

        Hello from The Food Network Recipies CLI! In this CLI app, you will be able to search for
        recipies using a keyword such as 'chicken', then see a list of recipies featured on The Food Network's
        website. See one you like? you can then request more details on the recipie! Lets get started!
        ------------------------------------------------------------------------------------------------------
        DOC
    end

end