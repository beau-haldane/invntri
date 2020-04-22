module ViewMethods

    #                               ! Feature - View Inventory !
    def view_inventory(prompt, inventory, categories)
        
        # View navigation
        view_nav = ['Item Search', 'Inventory View', 'Category View', 'Sub-Cagtegory View']
        
        system 'clear'
        
        navigation = prompt.select("How would you like to view your inventory?", view_nav)
        
        case navigation
        when view_nav[0]                                # Item Search
            search_inventory(*search_function(inventory, prompt, "Search Item by Name or SKU"))
        when view_nav[1]                                # Inventory View
            display_inventory(inventory)
        when view_nav[2]                                # Category View
            display_category(prompt, categories, inventory)
        when view_nav[3]                                # Sub-Category View
            display_sub_category(prompt, categories, inventory)
        end

    end

    # Displays entire contents of inventory to user
    def display_inventory(inventory)
        
        system 'clear'
        
        # Presents all inventory items to user using the display_method
        sub_categories = []
        inventory.each { |hash| sub_categories << hash['sub_cat'] }
        string_in_line(" Current Inventory ".colorize(:light_green), 114) ; puts
        sub_categories.uniq.each{ |i| display_method(inventory, i) }

    end

    def display_category(prompt, categories, inventory)
        
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

    def display_sub_category(prompt, categories, inventory)
        
        system 'clear'
            
        # Asks user which sub_category they'd like to view
        choose_sub_categories = []
        categories.each { |hash| hash[:sub_categories].each { |hash| hash.each { |k, v| choose_sub_categories << k.to_s } } }
        sub_category_to_view = prompt.select("Which sub-category would you like to view?", choose_sub_categories)

        # Calls display_method to display chosen sub_category
        system 'clear'

        display_method(inventory, sub_category_to_view)

    end

    # Neatly displays whichever sub-category is passed to the method to user
    def display_method(inventory, sub_category)
        inventory = inventory.sort_by { |a| [a['cat'], a['sub_cat'], a['sku'] ] }
        string_in_line(" #{sub_category.colorize(:light_green)} ", 114)
        puts 'Item Name:' + ' '*(30 - 'Item Name:'.length) + 'SKU:' + ' '*(20 - 'SKU:'.length) + 'Category:' + ' '*(20 - 'Category:'.length) + 'Sub_Category:' + ' '*(20 - 'Sub-Category:'.length) + 'Qty:' ; puts
        inventory.each do |hash|
            if hash['sub_cat'] == sub_category.to_s
                puts hash['name'] + ' '*(30 - hash['name'].length) + hash['sku'] + ' '*(20 - hash['sku'].length) + hash['cat'] + ' '*(20 - hash['cat'].length) + hash['sub_cat'] + ' '*(20 - hash['sub_cat'].length) + hash['qty'].to_s + ' '*(20 - hash['qty'].to_s.length)
            end
        end 
        line(102) ; puts
    end

end