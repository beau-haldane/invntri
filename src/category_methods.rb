module CategoryMethods

    include Categories

    def add_remove_category(prompt, categories)
        system 'clear'
        nav   = [   'Add Category',
                    'Remove Category'  ]
        
                    system 'clear'
        navigation = prompt.select("What would you like to do?", nav)

        # main navigation
        case navigation
        when nav[0]                                # Add Category
            add_category(prompt, categories)
        when nav[1]                                # Remove Category
            
        end

    end


    def add_category(prompt, categories)
        
        # User inputs category details
        category_name = prompt.ask("New category name:")
        puts "! Please enter all category-level attributes !"
        puts "! INVNTRI captures #{'name, sku, quantity'.colorize(:light_green)} and #{'cost'.colorize(:light_green)} by default on all items - !\n! you do not need to add those attributes here !"
        puts "! A category-level attribute is an attribute that all items in this category have !"
        puts "! For example, all items in the 'Fasteners' category would share the 'Length' attribute !"
        puts "! More specific attributes can be added to your sub-categories as you add them !" ; puts
        
        puts "Enter one attribute per line, enter a blank line when you're done"
        
        category_level_attributes = []

        done = false
        until done == true
            
            trait = gets.strip
            done = true if trait == ''
            category_level_attributes << trait if trait != ''

        end

        category = Categories::Category.new( category_name, category_level_attributes )
        categories << category.category_hash
        File.open("categories.yml","w") { |file| file.write categories.to_yaml } 


            
    end

end