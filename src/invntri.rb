require 'colorize'
require 'tty-prompt'

require_relative 'methods.rb'

include Methods

# initialize new instance of prompt
prompt = TTY::Prompt.new(symbols: {marker: '-'})

#               ! variables !
inventory     = [   { 'name'  => 'tension rod chrome 100mm',         'sku' => 'trod-cr-100', 'cat' => 'hardware', 'sub_cat' => 'tension_rods',   'qty' => 100,   'cost' => 1.2,  'finish' => 'chrome',   'length' => '100mm',    'thread' => 'm5' },
                    { 'name'  => 'tension rod chrome 80mm',          'sku' => 'trod-cr-80',  'cat' => 'hardware', 'sub_cat' => 'tension_rods',   'qty' => 150,   'cost' => 1,    'finish' => 'chrome',   'length' => '80mm',     'thread' => 'm5' },
                    { 'name'  => '14inch Remo Coated Ambassador',    'sku' => '14-ctd-amb',  'cat' => 'hardware', 'sub_cat' => 'batter_heads',   'qty' => 15,    'cost' => 45,   'coating' => 'coated',  'diameter' => 14,       'brand' => 'inde drum labs' }]

categories    = [   
                    { category: 'hardware',     category_attributes: [ 'finish' ],  sub_categories:     [   {tension_rods:  ['length', 'thread'] },
                                                                                                            {strainers:     ['brand', 'type'] }     ] },
                    { category: 'drum_heads',   category_attributes: [ 'coating' ], sub_categories:     [   {batter_heads:  ['diameter', 'brand'] },
                                                                                                            {reso_heads:    ['diameter', 'brand'] }     ] }
                ]

main_nav      = [   'Add item',
                    'Edit item',
                    'Remove item',
                    'Item Search',
                    'View inventory',
                    'Add/Edit Categories'   ]

#               ! main program loop begin !
exit = false
until exit == true
    
    # clear terminal
    system 'clear'
    
    # prints app name
    puts 'INVNTRI' ; puts
    
    # present navigation prompt
    navigation = prompt.select("", main_nav)
    
    # main navigation
    case navigation
    when main_nav[0] # Add item
        inventory << add_item(categories, prompt)
    when main_nav[1] # Edit item
            edit_item(prompt, categories, *search_function(inventory, prompt, "Edit Item\nSearch Item to Edit by Name or SKU"))
    when main_nav[2] # Remove item
        system 'clear'
        puts "#{main_nav[2]} feature coming soon."
    when main_nav[3] # Item Search
        search_inventory(*search_function(inventory, prompt, "Search Item by Name or SKU"))
    when main_nav[4] # View Inventory
        system 'clear'
        puts "#{main_nav[4]} feature coming soon."
    when main_nav[5] # Add/Edit Categories
        system 'clear'
        puts "#{main_nav[5]} feature coming soon."
    end
    
    # back to main menu?
    puts ; puts "Back to main menu? [Y|N]"
    input = gets.strip
    exit = true if input == 'n'

end