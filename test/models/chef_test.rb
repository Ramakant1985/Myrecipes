require "test_helper"

class ChefTest < ActiveSupport::TestCase
    
    def setup
        @chef=Chef.new(chefname: "ramakant", email: "ramakant@example.com")
    end
    
    test "chef should be valid" do
        assert @chef.valid?
    end
    
    test "chef name should be present" do 
        @chef.chefname= " "
        assert_not @chef.valid?
    end
    
    test "chef name shoild not be too long" do
        @chef.chefname= "a" * 41
        assert_not @chef.valid?
    end
    
    test "chef name shoild not be too shoet" do
        @chef.chefname="aa"
        assert_not @chef.valid?
    end
    
    test "email must be present" do
        @chef.email=" "
        assert_not @chef.valid?
    end
    
    test "email  sould be bound" do
        @chef.email="a" * 101 + "@example.com"
        assert_not @chef.valid?
    end
    
    test "email address should be unique" do
        dup_chef = @chef.dup
        dup_chef.email = @chef.email.upcase
        @chef.save
        assert_not dup_chef.valid?
    end
    
    test "email validation should accept valid address" do
        valid_address= %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com ]
        valid_address.each do |va|
            @chef.email = va
            assert @chef.valid?, '#{va.inspect} should be valid'
        end
    end
    
     test "email validation should reject invalid address" do
        invalid_address= %w[user@example.com user_at@eee.hello.org user_comming@example.com ]
        invalid_address.each do |iv|
            @chef.email = iv
            assert_not @chef.valid?, '#{iv.inspect} should be invalid'
        end
     end
end