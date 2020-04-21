require 'tty-prompt'

# initialize new instance of prompt
prompt = TTY::Prompt.new(symbols: {marker: '-'})

#               ! variables !
inventory = [   { name: 'tension rod chrome 100mm',         sku: 'trod-cr-100', cat: 'hardware', sub_cat: 'tension_rods',   qty: 100,   cost: 1.2,  finish: 'chrome', material: 'cast alloy', length: '100mm',          thread: 'm5' },
                { name: 'tension rod chrome 80mm',          sku: 'trod-cr-80',  cat: 'hardware', sub_cat: 'tension_rods',   qty: 150,   cost: 1,    finish: 'chrome', material: 'cast alloy', length: '80mm',           thread: 'm5' },
                { name: 'standard snare strainer chrome',   sku: 'std-str-cr',  cat: 'hardware', sub_cat: 'strainers',      qty: 15,    cost: 45,   finish: 'chrome', material: 'cast alloy', brand: 'inde drum labs',  type: 'standard' }]

category  = [   
                { hardware: [ 'finish' ], hardware_subs:        [   {tension_rods:  ['length', 'thread']    },
                                                                    {strainers:     ['brand', 'type']       }     ] },
                { drum_heads: [ 'coating' ], drum_heads_subs:   [   {batter_heads:  ['diameter']            },
                                                                    {reso_heads:    ['diameter']            }     ] }
            ]

main_nav  = [   'Add item',
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
    when main_nav[0]                # Add item
        system 'clear'
        puts "#{main_nav[0]} feature coming soon."                       
    when main_nav[1]                # Edit item
        system 'clear'
        puts "#{main_nav[1]} feature coming soon."
    when main_nav[2]                # Remove item
        system 'clear'
        puts "#{main_nav[2]} feature coming soon."
    when main_nav[3]                # Item Search
        system 'clear'
        puts "#{main_nav[3]} feature coming soon."
    when main_nav[4]                # View Inventory
        system 'clear'
        puts "#{main_nav[4]} feature coming soon."
    when main_nav[5]                # Add/Edit Categories
        system 'clear'
        puts "#{main_nav[5]} feature coming soon."
    end
    
    # back to main menu?
    puts ; puts "Back to main menu? [Y|N]"
    input = gets.strip
    exit = true if input == 'n'

end