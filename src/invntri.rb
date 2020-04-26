require 'colorize'
require 'tty-font'
require 'tty-prompt'
require 'yaml'

require_relative './classes/category_classes.rb'
require_relative './methods/category_methods.rb'
require_relative './methods/display_methods.rb'
require_relative './methods/item_methods.rb'
require_relative './methods/search_methods.rb'
require_relative './methods/view_methods.rb'

include Categories
include CategoryMethods
include DisplayMethods
include ItemMethods
include SearchMethods
include ViewMethods

# initialize new instance of prompt and font
prompt  = TTY::Prompt.new(symbols: {marker: '-'})
font    = TTY::Font.new(:straight)

#               ! variables !
inventory     = YAML.load(File.open(File.join(File.dirname(__FILE__), './db/inventory.yml')))
categories    = YAML.load(File.open(File.join(File.dirname(__FILE__), './db/categories.yml')))

main_nav      = [   'View Inventory',
                    'Add/Edit Item',
                    'Add/Remove Categories',
                    'Exit'   ]

#               ! main program loop begin !
exit = false
until exit == true
    
    # Sorts inventory hashes by cat, then sub_cat, then sku
    inventory =  inventory.sort_by { |a| [a['cat'], a['sub_cat'], a['sku'] ] }

    # clear terminal
    system 'clear'
    
    # prints app name
    puts font.write("INVNTRI")
    
    # present navigation prompt
    navigation = prompt.select("", main_nav)
    
    # main navigation
    case navigation
    when main_nav[0]                                # View Inventory
        view_inventory(prompt, inventory, categories)
    when main_nav[1]                                # Add/Edit Item
        add_edit_item(inventory, categories, prompt)
    when main_nav[2]                                # Add/Edit Categories
        add_remove_category(prompt, categories)
    when main_nav[3]                                # Add/Edit Item
        return exit = true
    end

    # Writes any changes to inventory.yaml
    File.open("inventory.yml","w") { |file| file.write inventory.to_yaml }
    
    # back to main menu?
    puts
    input = prompt.yes?("Back to main menu?")
    exit = true if input == false

end