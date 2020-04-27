module DisplayMethods

# Neatly displays items in whichever sub-category is passed to the method
def display_method(inventory, sub_category)
    begin
        inventory = inventory.sort_by { |a| [a['cat'], a['sub_cat'], a['sku'] ] }
        string_in_line(" #{sub_category.colorize(:light_green)} ", 114)
        puts 'Item Name:' + ' '*(30 - 'Item Name:'.length) + 'SKU:' + ' '*(20 - 'SKU:'.length) + 'Category:' + ' '*(20 - 'Category:'.length) + 'Sub-Category:' + ' '*(20 - 'Sub-Category:'.length) + 'Qty:' ; puts
        inventory.each do |hash|
            if hash['sub_cat'] == sub_category.to_s
                puts hash['name'] + ' '*(30 - hash['name'].length) + hash['sku'] + ' '*(20 - hash['sku'].length) + hash['cat'] + ' '*(20 - hash['cat'].length) + hash['sub_cat'] + ' '*(20 - hash['sub_cat'].length) + hash['qty'].to_s + ' '*(20 - hash['qty'].to_s.length)
            end
        end 
        line(102) ; puts
    rescue NoMethodError
        system 'clear'
        puts "You don't have any inventory items to view. Add some before using this function."
        return
    end
end

def display_single_item(item, text_colour)
    system 'clear'
    string_in_line("#{item['name'].colorize(text_colour.to_sym)}", 162)
    item.each { |k, v| print k.upcase + ' '*((v.to_s.length+8)-k.length) } ; puts
    item.each { |k, v| print v.to_s + ' '*8 } ; puts
    line(150) ; puts
end

end