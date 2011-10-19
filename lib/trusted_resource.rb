require "trusted_resource/version"
require "protected_attributes_assignment"

module TrustedResource
  class Base < ActiveResource::Base
    def load(attributes)
      raise ArgumentError, "expected an attributes Hash, got #{attributes.inspect}" unless attributes.is_a?(Hash)
      @prefix_options, attributes = split_options(attributes)
      attributes.each do |key, value|
        @attributes[key.to_s] =
          case value
            when Array
              resource = find_or_create_resource_for_collection(key)
              value.map do |attrs|
                if attrs.is_a?(Hash)
                  new_resource(resource, attrs)
                else
                  attrs.duplicable? ? attrs.dup : attrs
                end
              end
            when Hash
              resource = find_or_create_resource_for(key)
              new_resource(resource, value)
            else
              value.dup rescue value
          end
      end
      self
    end

    def new_resource(resource, attrs)
      method = resource.respond_to?(:new_with_protected_attributes) ? :new_with_protected_attributes : :new
      resource.send method, attrs
    end
  end
end

class ActiveRecord::Base
  extend ProtectedAttributeAssigment
end