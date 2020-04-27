module SearchMethods

    #                               ! Search Function !
    # Searches and returns items in inventory whose name or sku include the user's search term
    # Returns two arrays, one is an array of inventory item hashes
    # The second is an array of printable strings containing only the values of each item hash
    # Both arrays are used to create a hash for tty-prompt
    def search_function(inventory, prompt, message)
        
        system 'clear'

        # Ask user to search a term and return all items with the search term in 'name' or 'SKU'
        puts message ; puts

        search_exists = false
        until search_exists == true
        
            puts "Search by name or SKU:".colorize(:light_green)
            search = prompt.ask("Search:", required: true)
            system 'clear'
            # Cancels loop if search term is found in inventory
            search_results = inventory.select{ |item| item['name'].downcase.include?(search) || item['sku'].downcase.include?(search) }
            if search_results.empty?
                back = prompt.yes?("Sorry, no results matching search term '#{search.colorize(:light_green)}', search again?")
                return if back == false
            else
                search_exists = true 
            end

        end
        

        # Output results of user search
        system 'clear'
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