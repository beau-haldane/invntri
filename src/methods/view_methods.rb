module ViewMethods

    #                               ! Feature - View Inventory !
    def view_inventory(prompt, inventory, categories)
        
        puts "You need to #{"add at least one item".colorize(:light_green)} to your inventory before you can use the 'View Inventory' functions." ; return if inventory == []

        # View navigation
        view_nav = ['Item Search', 'Inventory View', 'Category View', 'Sub-Cagtegory View']
        
        system 'clear'
        
        navigation = prompt.select("How would you like to view your inventory?", view_nav)
        
        case navigation
        when view_nav[0]                                # Item Search
            search_results = search_function(inventory, prompt, "Search Item by Name or SKU")
            search_inventory(prompt, *search_results) if search_results != nil
        when view_nav[1]                                # Inventory View
            inventory_view(inventory)
        when view_nav[2]                                # Category View
            category_view(prompt, categories, inventory)
        when view_nav[3]                                # Sub-Category View
            sub_category_view(prompt, categories, inventory)
        end

    end

    #                               ! Feature - Search Inventory Item !
    def search_inventory(prompt, search_results, results_printable_array)
        
        # Asks user to choose which item they'd like to view
        chosen_item = choose_item('light_green', prompt, search_results, results_printable_array)

        # Outputs results of search_function method
        # puts results_printable_array ; puts

    end

    #                               ! Feature - Inventory View !
    #                                 Displays entire contents of inventory to user
    def inventory_view(inventory)
        
        system 'clear'
        
        # Presents all inventory items to user using the display_method
        begin

            sub_categories = []
            inventory.each { |hash| sub_categories << hash['sub_cat'] }
            string_in_line(" Current Inventory ".colorize(:light_green), 114) ; puts
            sub_categories.uniq.each{ |i| display_method(inventory, i) }
        rescue NoMethodError
            puts "You don't have any inventory items to view. Add some before using this function."
            return "No items in inventory"
        end

    end

    #                               ! Feature - Category View !
    #                                 Displays all items in chosen category
    def category_view(prompt, categories, inventory)
        
        system 'clear'
            
        # Asks user which category they'd like to view
        choose_categories = []
        categories.each { |hash| choose_categories << hash[:category]}
        category_to_view = prompt.select("Which category would you like to view?", choose_categories)

        # Finds all sub-categories within chosen category
        sub_categories = []
        categories.each { |hash| hash[:sub_categories].each{ |hash| hash.each { |k, v| sub_categories << k }} if hash[:category] == category_to_view }
        
        # Iterate over list of sub_categories within chosen category and display them to the user using display_method
        system 'clear'
        string_in_line(" #{category_to_view.upcase.colorize(:light_green)} ", 114) ; puts
        sub_categories.each { |sub_cat| display_method(inventory, sub_cat.to_s)}

    end

    #                               ! Feature - Sub-Category View !
    #                                 Displays all items in chosen sub-category
    def sub_category_view(prompt, categories, inventory)
        
        system 'clear'
            
        # Asks user which sub_category they'd like to view
        choose_sub_categories = []
        categories.each { |hash| hash[:sub_categories].each { |hash| hash.each { |k, v| choose_sub_categories << k.to_s } } }
        sub_category_to_view = prompt.select("Which sub-category would you like to view?", choose_sub_categories)

        # Calls display_method to display chosen sub_category
        system 'clear'

        display_method(inventory, sub_category_to_view)

    end

    #                               ! Presentation Functions !

    # Creates line of specified length
    def line(length)
        puts '-'*length
    end

    # Centers string of text in a line of the length of your choice
    def string_in_line(string, length)
        puts '-'*((length/2)-(string.length/2))+" #{string} "+'-'*((length/2)-(string.length/2))
    end

end