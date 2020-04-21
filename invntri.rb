#           ! variables !
inventory = [   { name: 'tension rod chrome 100mm',         sku: 'trod-cr-100', cat: 'hardware', sub_cat: 'tension_rods',   qty: 100,   cost: 1.2,  finish: 'chrome', material: 'cast alloy', length: '100mm',          thread: 'm5' },
                { name: 'tension rod chrome 80mm',          sku: 'trod-cr-80',  cat: 'hardware', sub_cat: 'tension_rods',   qty: 150,   cost: 1,    finish: 'chrome', material: 'cast alloy', length: '80mm',           thread: 'm5' },
                { name: 'standard snare strainer chrome',   sku: 'std-str-cr',  cat: 'hardware', sub_cat: 'strainers',      qty: 15,    cost: 45,   finish: 'chrome', material: 'cast alloy', brand: 'inde drum labs',  type: 'standard' }]

category  = [   
                { hardware: [ 'finish' ], hardware_subs:        [   {tension_rods:  ['length', 'thread']    },
                                                                    {strainers:     ['brand', 'type']       }     ] },
                { drum_heads: [ 'coating' ], drum_heads_subs:   [   {batter_heads:  ['diameter']            },
                                                                    {reso_heads:    ['diameter']            }     ] }
            ]

main_nav  = [   'Add item to inventory',
                'Remove item from inventory',
                'Edit item in inventory',
                'View inventory',
                'Add/Edit Categories',
                'Add/Edit Sub-Categories'   ]

#           ! main program loop !
exit = false
until exit == true
    puts "Would you like to exit? [Y|N]"
    input = gets.strip
    exit = true if input == 'y'
end