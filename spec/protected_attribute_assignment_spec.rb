require 'spec_helper'

ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'test_models'")
ActiveRecord::Base.connection.create_table(:test_models) do |t|
    t.string :foo, :bar
end


class TestModel < ActiveRecord::Base
  attr_accessible :foo
  attr_protected :bar
end

describe ProtectedAttributeAssigment do
  context "initializing with an attributes hash and 'new'" do
    subject { TestModel.new(:foo => "foo", :bar => "bar") }

    it "should assign accessible attributes" do
      subject.foo.should == "foo"
    end

    it "should not assign protected attributes" do
      subject.bar.should be_nil
    end
  end

  context "initializing with an attributes hash and 'new_with_protected_attributes'" do
    subject { TestModel.new_with_protected_attributes(:foo => "foo", :bar => "bar") }

    it "should assign accessible attributes" do
      subject.foo.should == "foo"
    end

    it "should assign protected attributes" do
      subject.bar.should == "bar"
    end
  end
end
