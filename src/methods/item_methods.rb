module ItemMethods

    def add_edit_item(inventory, categories, prompt)
        nav   = [   'Add Item',
                    'Edit Item',
                    'Remove Item',  ]
        
        system 'clear'
        navigation = prompt.select("Add/Edit Item", nav)

        # main navigation
        case navigation
        when nav[0]                                # Add item
            add_item(inventory, categories, prompt)
        when nav[1]                                # Edit item
            search_results = search_function(inventory, prompt, "Edit Item")
            edit_item(prompt, categories, *search_results) if search_results != nil
        when nav[2]                                # Remove item
            search_results = search_function(inventory, prompt, "Remove Item")
            remove_item(inventory, prompt, categories, *search_results) if search_results != nil
        end
    end
    
    #                               ! Feature - Add Item !
    def add_item(inventory, categories, prompt)

        system 'clear'

        # Declaring arrays
        key_array   = ['cat', 'sub_cat', 'name', 'sku', 'qty', 'cost' ]
        value_array = [ ]

        # Tells the user what to do
        puts "Add Item to Inventory" ; puts
        puts "Type or select your answer and press [Enter]".colorize(:light_green)
        puts "[If you don't know some item details, you can edit the item later]".colorize(:light_black)

        # Create list of categories for the user to choose from
        begin
            category_array = []
            categories.each { |hash| category_array << hash[:category] }
            item_category = prompt.select("Category:", category_array)
            value_array << item_category
        rescue NoMethodError
            system 'clear'
            puts "#{'Category:'.colorize(:light_red)} It looks like you haven't created any categories yet. Please create at least one category before adding an item."
            return
        end

        # Find hash whose category matches the user's chosen category
        category_hash = categories.find {|x| x[:category] == item_category}

        # Check if category has at least 1 sub-category
        if category_hash[:sub_categories].empty?
            puts "Please add at least 1 sub-category to the #{category_hash[:category].colorize(:light_green)} category before adding an item." ; return nil
        end 
        # Create list of sub-categories for the user to choose from
        sub_category_array  = []
        category_hash[:sub_categories].each{|hash| hash.each{ |k,v| sub_category_array << k } }
        item_sub_category = prompt.select("Sub-Category:", sub_category_array)
        value_array << item_sub_category.to_s

        # Taking user input
        value_array << prompt.ask("Item name:" , required: true)
        value_array << prompt.ask("SKU:" , required: true)
        value_array << prompt.ask("Quantity:") do |q| 
            q.validate { |input| input.strip.to_i.to_s == input.strip || input.strip.to_f.to_s == input.strip }
            q.messages[:valid?] = 'Please enter a number'
        end
        value_array << prompt.ask("Cost per item ($):") do |q|
            q.validate { |input| input.strip.to_i.to_s == input.strip || input.strip.to_f.to_s == input.strip }
            q.messages[:valid?] = 'Please enter a number'
        end

        # Iterate over array of category level attributes & get user input
        category_attributes = category_hash[:category_attributes]
        category_attributes.each do |attribute|
            key_array << attribute
            value_array <<  prompt.ask("#{attribute.capitalize}:" , required: true)
        end

        # Iterate over array of sub-category level attributes & get user input
        sub_category_attributes = category_hash[:sub_categories].find {|x| x.key?(item_sub_category)}
        sub_category_attributes[item_sub_category].each do |attribute|
            key_array << attribute
            value_array <<  prompt.ask("#{attribute.capitalize}:" , required: true)
        end

        # Merge key_array and value_array and return item hash
        new_item = Hash[key_array.zip(value_array)]

        # Display new item to user
        display_single_item(new_item, 'light_green') ; puts
        puts "#{new_item['name'].colorize(:light_green)} added to inventory"

        inventory << new_item

    end

    #                               ! Feature - Edit Iitem !
    def edit_item(prompt, categories, search_results, results_printable_array)

        # Asks user to choose which item they'd like to edit
        chosen_item = choose_item('light_green', prompt, search_results, results_printable_array)
        chosen_item_copy = chosen_item.dup
        
        # User chooses which attributes they'd like to edit
        item_attr = []
        chosen_item.each { |k, v| k == 'cat' || k == 'sub_cat' ? next : item_attr << k }
        item_attr_edit = prompt.multi_select("Which attributes you like to edit? (Arrow down to see all options)", item_attr)

        # User gives new values for attributes & values are updated in item hash
        item_attr_edit.each do |key|
            if key == 'qty' || key == 'cost'
                chosen_item_copy[key] = prompt.ask("#{key.capitalize}:") do |q| 
                    q.validate { |input| input.strip.to_i.to_s == input.strip || input.strip.to_f.to_s == input.strip }
                    q.messages[:valid?] = 'Please enter a number'
                end
            else
                chosen_item_copy[key] = prompt.ask("#{key.capitalize}:", required: true)
            end
        end ; puts

        # Present changes to user
        system 'clear'
        string_in_line("Here are your changes to '#{chosen_item['name'].colorize(:light_green)}'", 162)
        chosen_item_copy.each { |k, v| item_attr_edit.include?(k) ? (print k.upcase.colorize(:light_green) + ' '*((v.to_s.length+8)-k.length)) : (print k.upcase + ' '*((v.to_s.length+8)-k.length)) } ; puts
        chosen_item_copy.each { |k, v| item_attr_edit.include?(k) ? (print v.to_s.colorize(:light_green) + ' '*8) : (print v.to_s + ' '*8) } ; puts
        line(150) ; puts

        # Check if user wants to save changes
        save = prompt.yes?("Save your changes to '#{chosen_item['name'].colorize(:light_green)}'?")
        case save
        when true
            chosen_item_copy.each{ |k, v| chosen_item[k] = v }
            puts "Your changes have been saved.".colorize(:light_green)
        when false
            puts "Your changes were not saved.".colorize(:light_red)
        end
        
    end

    #                               ! Feature - Remove Item !

    def remove_item(inventory, prompt, categories, search_results, results_printable_array)
        
        # Asks user to choose which item they'd like to remove
        chosen_item = choose_item('light_red', prompt, search_results, results_printable_array)

        # Check if user wants to save changes
        remove = prompt.yes?("Are you sure you want to remove '#{chosen_item['name'].colorize(:light_red)} from your inventory'?")
        case remove
        when true
            inventory.delete(chosen_item)
            puts "You have removed #{chosen_item['name']}.".colorize(:light_red)
        when false
            puts "You have not removed #{chosen_item['name']}.".colorize(:light_green)
        end

    end

    def choose_item(text_colour, prompt, search_results, results_printable_array)

        # Creating hash for tty-prompt to allow users to choose results
        choose_search_result = Hash[results_printable_array.zip(search_results)]

        # User chooses search result to remove
        chosen_item = prompt.select("", choose_search_result)

        # Display all details of chosen item
        display_single_item(chosen_item, text_colour)
        
        return chosen_item
    end
end