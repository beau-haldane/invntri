module Categories
    
    class Category
        
        attr_accessor :category_hash
        # @@categories_hash = []
        
        def initialize ( categories, category, category_attributes )
            @category = category
            @category_attributes = category_attributes
            @category_hash = {category: category, category_attributes: category_attributes, sub_categories: []}

            categories << @category_hash
            File.open("categories.yml","w") { |file| file.write categories.to_yaml }
        end

        def self.delete(categories, category)
            categories.delete_if { |hash| category.include?(hash[:category]) }
            File.open("categories.yml","w") { |file| file.write categories.to_yaml }
        end

    end

    class SubCategory < Category

        def initialize (categories, category, sub_cat_name, sub_cat_attributes)
            @category = category
            @sub_cat_name = sub_cat_name
            @sub_cat_attributes = sub_cat_attributes
            @sub_category_hash = Hash[sub_cat_name, sub_cat_attributes]
            
            categories.each { |hash| hash[:sub_categories] << @sub_category_hash if hash[:category] == @category }
            File.open("categories.yml","w") { |file| file.write categories.to_yaml }
        end

        def self.delete(categories, sub_category)
            categories.each { |hash| hash[:sub_categories].delete_if { |hash| hash.include?(sub_category) } }
            File.open("categories.yml","w") { |file| file.write categories.to_yaml }
        end
    end

end