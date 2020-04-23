module Categories
    
    class Category
        
        attr_accessor :category_hash
        # @@categories_hash = []
        
        def initialize (category, category_attributes)
            @category = category
            @category_attributes = category_attributes
            @category_hash = {category: category, category_attributes: category_attributes, sub_categories: []}
        end

        # def return_hash
        #     return 
        # end

        def delete(category)
            @@categories_hash.delete_if { |hash| category.include?(hash[:category]) }
        end

    end

    class SubCategory < Category

        def initialize (category, sub_cat_name, sub_cat_attributes)
            @category = category
            @sub_cat_name = sub_cat_name
            @sub_cat_attributes = sub_cat_attributes
            
            create_hash(@category, @sub_cat_name, @sub_cat_attributes)
        end

        def create_hash(category, sub_cat_name, sub_cat_attributes)
            @@categories_hash.each { |hash| hash[:sub_categories] << Hash[sub_cat_name, sub_cat_attributes]  if hash[:category] == category  }
        end

        def delete(sub_category)
            @@categories_hash.each { |hash| hash[:sub_categories].delete_if { |hash| hash.include?(sub_category) } }
        end
    end

end


# exit = false
# until exit == true

#     system 'clear'

#     consumables = Categories::Category.new( 'consumables', ['some attribute', 'another one'] )
#     glue = Categories::SubCategory.new( 'consumables', 'glue', ['sub_cat_attr', 'sub_cat_attr2'] )
#     tape = Categories::SubCategory.new( 'consumables', 'tape', ['colour', 'length'] )

#     raw_materials = Categories::Category.new( 'raw materials', [''] )
#     timber = Categories::SubCategory.new( 'raw materials', 'timber', ['sub_cat_attr', 'sub_cat_attr2'] )

#     puts Categories::Category.class_variable_get(:@@categories_hash) ; puts

#     # consumables.delete('consumables')

#     glue.delete('glue')

#     puts Categories::Category.class_variable_get(:@@categories_hash) ; puts

#     # puts "New category name:"
#     # cat = gets.strip
#     # puts "Sub-category name:"
#     # sub_cat = gets.strip

#     # puts "Sub-category traits:"
#     # done = false
#     # until done == true
        
#     #     trait = gets.strip
#     #     done = true if trait == ''
#     #     traits << trait if trait != ''

#     # end
#     # cat = Categories::Category.new(cat, sub_cat, traits)

  

#     puts "Would you like to enter another new category? [Y|N]"
#     input = gets.strip
#     exit = true if input == 'n'

# end