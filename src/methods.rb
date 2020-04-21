module Methods


    def add_item(prompt, categories)

        system 'clear'

        # Declaring arrays
        key_array   = ['name', 'sku', 'cat', 'sub_cat', 'qty', 'cost' ]
        value_array = [ ]

        # Tells the user what to do
        puts "Adding new item to Inventory"
        puts "Type your answer and press [Enter]" 
        puts "If you don't know an answer, you can always come back and edit the item later"; puts

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

        # Returns item hash
        return Hash[key_array.zip(value_array)]

    end

end