module Methods

    #                               ! Presentation Functions !

    # Creates line of specified length
    def line(length)
        puts '-'*length
    end

    # Centers string of text in a line of the length of your choice
    def string_in_line(string, length)
        puts '-'*((length/2)-(string.length/2))+" #{string} "+'-'*((length/2)-(string.length/2))
    end

    #                               ! Feature - Search Inventory !
    def search_inventory(search_results, results_printable_array)
        
        # Outputs results of search_function method
        puts results_printable_array ; puts

    end

    def search_function(inventory, prompt, message)
        
        system 'clear'

        # Ask user to search a term and return all items with the search term in 'name' or 'SKU'
        puts message ; puts
        puts "Search by name or SKU:".colorize(:light_green)
        search = prompt.ask("Search:")
        system 'clear'
        search_results = inventory.select{|item| item['sku'].downcase.include?(search) || item['name'].downcase.include?(search) }

        # Output results of user search
        title = "Showing results for '#{search.colorize(:light_green)}'"
        counter = 1
        string_in_line(title, 130) ; puts
        puts 'Result' + ' '*(10 - 'Result'.length) + 'Item Name:' + ' '*(35 - 'Item Name:'.length) + 'SKU:' + ' '*(20 - 'SKU:'.length) + 'Category:' + ' '*(20 - 'Category:'.length) + 'Sub_Category:' + ' '*(20 - 'Sub-Category:'.length) + 'Qty:' ; puts
        results_printable_array = []
        search_results.each do |hash|
            results_printable_array << "[#{counter}]" + ' '*(10 - "[#{counter}]".length) + hash['name'] + ' '*(35 - hash['name'].length) + hash['sku'] + ' '*(20 - hash['sku'].length) + hash['cat'] + ' '*(20 - hash['cat'].length) + hash['sub_cat'] + ' '*(20 - hash['sub_cat'].length) + hash['qty'].to_s + ' '*(20 - hash['qty'].to_s.length)
            counter += 1
        end 
        

        # Return array of item hashes from search results, along with a printable array of search results
        return search_results, results_printable_array

    end
end