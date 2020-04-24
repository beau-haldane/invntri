module CategoryMethods

    include Categories

    def add_remove_category(prompt, categories)
        
        # Prompts user to choose what they'd like to do
        system 'clear'
        nav   = [   'Add Category or Sub-Category',
                    'Remove Category or Sub-Category'  ]
        
                    system 'clear'
        navigation = prompt.select("What would you like to do?", nav)

        # Main navigation
        case navigation
        when nav[0]                                # Add Category
            add_category_menu(prompt, categories)
        when nav[1]                                # Remove Category
            remove_category(prompt, categories)
        end

    end

    def add_category_menu(prompt, categories)
        
        # Prompts user to choose what they'd like to do
        system 'clear'
        nav   = [   'Add Category',
                    'Add Sub-Category'  ]
        
                    system 'clear'
        navigation = prompt.select("What would you like to do?", nav)

        # Navigation
        case navigation
        when nav[0]                                # Add Category
            add_category(prompt, categories)
        when nav[1]                                # Add Sub-Category
            choose_category(prompt, categories)
        end

    end

    def add_category(prompt, categories)
        
        # User inputs new category details
        category_name = prompt.ask("New category name:") ; puts
        puts "! Please enter all category-level attributes !"
        puts "! INVNTRI captures #{'name, sku, quantity'.colorize(:light_green)} and #{'cost'.colorize(:light_green)} by default on all items - you do not need to add those attributes here !"
        puts "! A category-level attribute is an attribute that all items in this category have !"
        puts "! For example, all items in the 'Fasteners' category would share the 'Length' attribute !"
        puts "! More specific attributes can be added to your sub-categories as you add them !" ; puts
        
        puts "Enter one attribute per line, enter a blank line when you're done"
        
        category_level_attributes = []

        # User inputs all category-level-attributes for new category
        done = false
        until done == true
            
            attribute = gets.strip
            done = true if attribute == ''
            category_level_attributes << attribute if attribute != ''

        end

        # Creates new category
        category = Categories::Category.new( categories, category_name, category_level_attributes )
         
        # Displays new category information to user
        system 'clear'
        puts "Added new category:" ; puts
        puts "#{category_name.colorize(:light_green)}"
        category.category_hash[:category_attributes].each { |attribute| puts "- #{attribute}"} ; puts
        
        # Moves on to add sub-category to newly created category
        add_sub_category(prompt, category_name, categories)
        
    end

    def choose_category(prompt, categories)
        
        # Asks user which category they'd like to add sub-category to
        # Or whether they'd like to create new sub-category
        system 'clear'
        category_array = []
        categories.each { |hash| category_array << hash[:category] }
        category_array << "Create new category"
        category_name = prompt.select("Choose category to add new sub-category to:", category_array)

        # Directs user back to add_category method if they've chosen "Create new category"
        # Else, directs them to add their new sub-category to their chose category
        if category_name == "Create new category"
            add_category(prompt, categories)
        else
            add_sub_category(prompt, category_name, categories)
        end

    end

    def add_sub_category(prompt, category_name, categories)

        # User inputs new sub-category details
        puts "Please add sub-category to #{category_name.colorize(:light_green)}" ; puts
        sub_category_name = prompt.ask("New sub-category name:")
        system 'clear'
        puts "Adding new sub-category: #{sub_category_name.colorize(:light_green)}" ; puts
        puts "! Please enter all sub-category-level attributes !"
        puts "! INVNTRI captures #{'name, sku, quantity'.colorize(:light_green)} and #{'cost'.colorize(:light_green)} by default on all items - !\n! you do not need to add those attributes here !"
        puts "! A sub-category-level attribute is an attribute that all items in this sub-category have !"
        puts "! For example, all items in the 'Screws' sub-category (which is a sub-category of 'Fasteners') would share the 'Gauge' attribute !" ; puts
        
        puts "Enter one attribute per line, enter a blank line when you're done"
        
        sub_category_level_attributes = []

        # User adds sub-category-level attributes to their new sub-category
        done = false
        until done == true
            
            attribute = gets.strip
            done = true if attribute == ''
            sub_category_level_attributes << attribute if attribute != ''

        end

        # creates new sub-category hash and adds it to category hash
        Categories::SubCategory.new( categories, category_name, sub_category_name, sub_category_level_attributes )

        # Displays newly created sub-category to user
        system 'clear'
        puts "Added new sub-category '#{sub_category_name.colorize(:light_green)}' to '#{category_name.colorize(:light_green)}' category:" ; puts
        puts "#{category_name.colorize(:light_green)}"
        categories.each{|hash| hash[:category_attributes].each { |attribute| puts "- #{attribute}"} if hash[:category] == category_name }
        puts "#{sub_category_name.colorize(:light_green)}"
        sub_category_level_attributes.each { |attribute| puts "- #{attribute}"} ; puts

    end

    def remove_category(prompt, categories)

        # User chooses category to remove
        system 'clear'
        category_array = []
        categories.each { |hash| category_array << hash[:category] }
        category_name = prompt.select("Choose category to remove:".colorize(:light_red), category_array)

        # Are you sure?
        system 'clear'
        puts "Are you sure you want to delete the #{category_name.colorize(:light_red)} category?"
        puts "This will permanently delete #{category_name.colorize(:light_red)} and all of its sub-categories" ; puts

        # Shows category information of category to be removed
        puts "#{category_name.colorize(:light_red)}"
        categories.each{|hash| hash[:category_attributes].each { |attribute| puts "- #{attribute}"} if hash[:category] == category_name } ; puts
        categories.each{|hash| hash[:sub_categories].each { |hash| hash.each { |k, v| puts "- #{k.to_s.colorize(:light_red)}" ; v.each { |attribute| puts "  - #{attribute}"} }} if hash[:category] == category_name } ; puts

        # Asks user to confirm removal
        remove = prompt.yes?("Permantently remove #{category_name.colorize(:light_red)}?")
        # Removes chosen category
        Categories::Category.delete(categories, category_name) if remove == true

    end

end