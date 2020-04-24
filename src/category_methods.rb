module CategoryMethods

    include Categories

    def add_remove_category(prompt, categories)
        system 'clear'
        nav   = [   'Add Category or Sub-Category',
                    'Remove Category or Sub-Category'  ]
        
                    system 'clear'
        navigation = prompt.select("What would you like to do?", nav)

        # main navigation
        case navigation
        when nav[0]                                # Add Category
            add_category_menu(prompt, categories)
        when nav[1]                                # Remove Category
            
        end

    end

    def add_category_menu(prompt, categories)
        system 'clear'
        nav   = [   'Add Category',
                    'Add Sub-Category'  ]
        
                    system 'clear'
        navigation = prompt.select("What would you like to do?", nav)

        # main navigation
        case navigation
        when nav[0]                                # Add Category
            add_category(prompt, categories)
        when nav[1]                                # Remove Category
            choose_category(prompt, categories)
        end
    end

    def add_category(prompt, categories)
        
        # User inputs category details
        category_name = prompt.ask("New category name:") ; puts
        puts "! Please enter all category-level attributes !"
        puts "! INVNTRI captures #{'name, sku, quantity'.colorize(:light_green)} and #{'cost'.colorize(:light_green)} by default on all items - you do not need to add those attributes here !"
        puts "! A category-level attribute is an attribute that all items in this category have !"
        puts "! For example, all items in the 'Fasteners' category would share the 'Length' attribute !"
        puts "! More specific attributes can be added to your sub-categories as you add them !" ; puts
        
        puts "Enter one attribute per line, enter a blank line when you're done"
        
        category_level_attributes = []

        done = false
        until done == true
            
            attribute = gets.strip
            done = true if attribute == ''
            category_level_attributes << attribute if attribute != ''

        end

        category = Categories::Category.new( categories, category_name, category_level_attributes )
         

        system 'clear'
        puts "Added new category:" ; puts
        puts "#{category_name.colorize(:light_green)}"
        category.category_hash[:category_attributes].each { |attribute| puts "- #{attribute}"} ; puts
            
        add_sub_category(prompt, category_name, categories)
        
    end

    def choose_category(prompt, categories)
        system 'clear'
        category_array = []
        categories.each { |hash| category_array << hash[:category] }
        category_array << "Create new category"
        category_name = prompt.select("Choose category to add new sub-category to:", category_array)

        if category_name == "Create new category"
            add_category(prompt, categories)
        else
            add_sub_category(prompt, category_name, categories)
        end
    end

    def add_sub_category(prompt, category_name, categories)

        # User inputs category details
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

        done = false
        until done == true
            
            attribute = gets.strip
            done = true if attribute == ''
            sub_category_level_attributes << attribute if attribute != ''

        end

        # creates new sub-category hash and adds it to category hash
        sub_category = Categories::SubCategory.new( categories, category_name, sub_category_name, sub_category_level_attributes )

    end

end