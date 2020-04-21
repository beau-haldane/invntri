module Methods

    #                               ! Feature - Add Item !
    def add_item(categories, prompt)

        system 'clear'

        # Declaring arrays
        key_array   = ['name', 'sku', 'cat', 'sub_cat', 'qty', 'cost' ]
        value_array = [ ]

        # Tells the user what to do
        puts "Add Item to Inventory" ; puts
        puts "Type your answer and press [Enter]".colorize(:light_green)
        puts "[If you don't know some item details, you can edit the item later]".colorize(:light_black)

        # Taking user input
        value_array << prompt.ask("Item name:")
        value_array << prompt.ask("SKU:")
       
        # Create list of categories for the user to choose from
        category_array = []
        categories.each { |hash| category_array << hash[:category] }
        item_category = prompt.select("Category:", category_array)
        value_array << item_category

        # Find hash whose category matches the user's chosen category
        category_hash = categories.find {|x| x[:category] == item_category}

        # Create list of sub-categories for the user to choose from
        sub_category_array  = []
        category_hash[:sub_categories].each{|hash| hash.each{ |k,v| sub_category_array << k } }
        item_sub_category = prompt.select("Sub-Category:", sub_category_array)
        value_array << item_sub_category.to_s

        # Continue taking user input
        value_array << prompt.ask("Quantity:")
        value_array << prompt.ask("Cost per item ($):")

        # Iterate over array of category level attributes & get user input
        category_attributes = category_hash[:category_attributes]
        category_attributes.each do |attribute|
            key_array << attribute
            value_array <<  prompt.ask("#{attribute.capitalize}:")
        end

        # Iterate over array of sub-category level attributes & get user input
        sub_category_attributes = category_hash[:sub_categories].find {|x| x.key?(item_sub_category)}
        sub_category_attributes[item_sub_category].each do |attribute|
            key_array << attribute
            value_array <<  prompt.ask("#{attribute.capitalize}:")
        end

        # Merge key_array and value_array and return item hash
        return Hash[key_array.zip(value_array)]

    end

    #                               ! Feature - Search Inventory !
    def search_inventory(inventory, prompt)
        
        system 'clear'

        # Ask user to search a term and return all items with the search term in 'name' or 'SKU'
        puts "Search Item by Name or SKU" ; puts
        puts "Please enter all or part of the name or SKU of the item you'd like to find:".colorize(:light_green)
        search = prompt.ask("Search:")
        system 'clear'
        search_results = inventory.select{|item| item['sku'].downcase.include?(search) || item['name'].downcase.include?(search) }

        # Output results of user search
        title = "Showing results for '#{search.colorize(:light_green)}'"
        counter = 1
        puts '-'*((115-title.length-2)/2)+" #{title} "+'-'*((130-title.length-2)/2) ; puts
        puts 'Result' + ' '*(10 - 'Result'.length) + 'Item Name:' + ' '*(35 - 'Item Name:'.length) + 'SKU:' + ' '*(20 - 'SKU:'.length) + 'Category:' + ' '*(20 - 'Category:'.length) + 'Sub_Category:' + ' '*(20 - 'Sub-Category:'.length) + 'Qty:' ; puts
        results_printable_array = []
        search_results.each do |hash|
            results_printable_array << "[#{counter}]" + ' '*(10 - "[#{counter}]".length) + hash['name'] + ' '*(35 - hash['name'].length) + hash['sku'] + ' '*(20 - hash['sku'].length) + hash['cat'] + ' '*(20 - hash['cat'].length) + hash['sub_cat'] + ' '*(20 - hash['sub_cat'].length) + hash['qty'].to_s + ' '*(20 - hash['qty'].to_s.length)
            counter += 1
        end 
        puts results_printable_array ; puts

        # Return array of item hashes from search results
        return search_results, results_printable_array
    end
end