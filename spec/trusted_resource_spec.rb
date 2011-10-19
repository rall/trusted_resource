require "spec_helper"

class TestResource < TrustedResource::Base; end

describe TestResource, "#load" do
  let(:test_resource) { TestResource.new }
  let(:resource) { stub("resource", :new_with_protected_attributes => true) }
  let(:resource_without_protected_attributes_method) { stub("resource") }

  before do
    TrustedResource::Base.send(:define_method, :split_options) { |arg| ["first argument", arg] }
  end

  context "when the resource has a 'new_with_protected_attributes' method" do
    before do
      test_resource.stub(:find_or_create_resource_for_collection).with(:resources).and_return resource
      test_resource.stub(:find_or_create_resource_for).with(:resource).and_return resource
    end

    context "when loading one resource" do
      it "should call the protected assignment method on the resource" do
        resource.should_receive(:new_with_protected_attributes).with(:attributes => :hash)
        test_resource.load(:resource => { :attributes => :hash })
      end
    end

    context "when loading many resources" do
      it "should call the protected assignment method on each of the resources" do
        resource.should_receive(:new_with_protected_attributes).with(:attributes => :hash)
        test_resource.load(:resources => [{ :attributes => :hash }])
      end
    end
  end

  context "when the resource does not have a 'new_with_protected_attributes' method" do
    before do
      test_resource.stub(:find_or_create_resource_for_collection).with(:resources).and_return resource_without_protected_attributes_method
      test_resource.stub(:find_or_create_resource_for).with(:resource).and_return resource_without_protected_attributes_method
    end

    context "when loading one resource" do
      it "should call the standard 'new' method on the resource" do
        resource_without_protected_attributes_method.should_receive(:new).with(:attributes => :hash)
        test_resource.load(:resource => { :attributes => :hash })
      end
    end

    context "when loading many resources" do
      it "should call the protected assignment method on each of the resources" do
        resource_without_protected_attributes_method.should_receive(:new).with(:attributes => :hash)
        test_resource.load(:resources => [{ :attributes => :hash }])
      end
    end
  end


end
