require 'test/unit'
require_relative "../classes/category_classes.rb"
require_relative "../methods/view_methods.rb"

include ViewMethods

class CategoryTests < Test::Unit::TestCase

    # Tests the view_inventory function to see whether it outputs the correct message when the user tries to view an inventory that's empty
    def test_view_inventory

        output = inventory_view( [] )
        assert_equal(output, "No items in inventory")

    end

    # Tests the Categories class to check whether it's initializing properly and creating a hash in the expected format
    def test_add_category

        new_category = Categories::Category.new([], 'test category', ['test attribute 1', 'test attribute 2'])
        assert_equal(new_category.category_hash, {  :category=>"test category", 
                                                    :category_attributes=>["test attribute 1", "test attribute 2"], 
                                                    :sub_categories=>[]} )

    end

    # Tests the SubCategories class to check whether it's initializing properly, creating a hash in the expected format
    # and pushing the sub-category hash to the correct category hash
    def test_add_sub_category

        new_category = Categories::Category.new( [], 'test category', ['test attribute 1', 'test attribute 2'] )
        new_sub_category = Categories::SubCategory.new( new_category.categories, 'test category', 'test sub category', ['test sub attribute 1', 'test sub attribute 2'])
        assert_equal(new_category.category_hash, {  :category=>             "test category",
                                                    :category_attributes=>  ["test attribute 1", "test attribute 2"],
                                                    :sub_categories=>       [{"test sub category"=>["test sub attribute 1", "test sub attribute 2"]}]} )

    end

end