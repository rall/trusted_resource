require 'spec_helper'

class TestModel < ActiveRecord::Base
  attr_accessible :foo
  attr_protected :bar

  def self.columns
    [ ActiveRecord::ConnectionAdapters::Column.new("foo", nil, "", true),
      ActiveRecord::ConnectionAdapters::Column.new("bar", nil, "", true) ]
  end
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
