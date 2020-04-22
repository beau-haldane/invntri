require 'yaml'
require 'colorize'
require 'tty-prompt'

require_relative 'methods.rb'
require_relative 'item_methods.rb'
require_relative 'view_methods.rb'
require_relative 'display_methods.rb'
require_relative 'search_methods.rb'

include Methods
include ItemMethods
include ViewMethods
include DisplayMethods
include SearchMethods

# initialize new instance of prompt
prompt = TTY::Prompt.new(symbols: {marker: '-'})

#               ! variables !
inventory   = YAML.load(File.open(File.join(File.dirname(__FILE__), 'inventory.yml')))

categories  = YAML.load(File.open(File.join(File.dirname(__FILE__), 'categories.yml')))

main_nav      = [   'Add Item',
                    'Edit Item',
                    'Remove Item',
                    'View Inventory',
                    'Add/Edit Categories'   ]

#               ! main program loop begin !
exit = false
until exit == true
    
    # Sorts inventory hashes by cat, then sub_cat, then sku
    inventory =  inventory.sort_by { |a| [a['cat'], a['sub_cat'], a['sku'] ] }

    # clear terminal
    system 'clear'
    
    # prints app name
    puts 'INVNTRI' ; puts
    
    # present navigation prompt
    navigation = prompt.select("", main_nav)
    
    # main navigation
    case navigation
    when main_nav[0]                                # Add item
        inventory << add_item(categories, prompt)
    when main_nav[1]                                # Edit item
        edit_item(prompt, categories, *search_function(inventory, prompt, "Edit Item"))
    when main_nav[2]                                # Remove item
        remove_item(inventory, prompt, categories, *search_function(inventory, prompt, "Remove Item"))
    when main_nav[3]                                # View Inventory
        view_inventory(prompt, inventory, categories)
    when main_nav[4]                                # Add/Edit Categories
        system 'clear'
        puts "#{main_nav[4]} feature coming soon."
        File.open("categories.yml","w") { |file| file.write categories.to_yaml } 
    end

    # Writes any changes to inventory.yaml
    File.open("inventory.yml","w") { |file| file.write inventory.to_yaml }
    
    # back to main menu?
    puts
    input = prompt.yes?("Back to main menu?")
    exit = true if input == false

end