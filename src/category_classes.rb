module Categories
    
    class Category
        @@categories_hash = []
        
        def initialize ( category, category_attributes)
            @@categories_hash << {category: category, category_attributes: category_attributes, sub_categories: []}
        end

        # def delete(category)
        #     @@categories_hash.tap { |hash| hash.delete(category) }
        # end
    end

    class SubCategory < Category

        def initialize (category, sub_cat_name, sub_cat_attributes)
            @@categories_hash.each { |hash| hash[:sub_categories] << Hash[sub_cat_name, sub_cat_attributes]  if hash[:category] == category  }
        end
    end

end


exit = false
until exit == true

    system 'clear'

    Categories::Category.new( 'consumables', ['some attribute', 'another one'] )
    Categories::SubCategory.new( 'consumables', 'glue', ['sub_cat_attr', 'sub_cat_attr2'] )
    Categories::SubCategory.new( 'consumables', 'tape', ['colour', 'length'] )

    Categories::Category.new( 'raw materials', [''] )
    Categories::SubCategory.new( 'raw materials', 'timber', ['sub_cat_attr', 'sub_cat_attr2'] )

    puts Categories::Category.class_variable_get(:@@categories_hash) ; puts

    # puts "New category name:"
    # cat = gets.strip
    # puts "Sub-category name:"
    # sub_cat = gets.strip

    # puts "Sub-category traits:"
    # done = false
    # until done == true
        
    #     trait = gets.strip
    #     done = true if trait == ''
    #     traits << trait if trait != ''

    # end
    # cat = Categories::Category.new(cat, sub_cat, traits)

  

    puts "Would you like to enter another new category? [Y|N]"
    input = gets.strip
    exit = true if input == 'n'

end