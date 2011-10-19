module ProtectedAttributeAssigment
  def new_with_protected_attributes(attrs)
    attrs.stringify_keys!
    attributes_to_assign = attrs.keys - self.accessible_attributes.to_a + self.protected_attributes.to_a
    protected_attrs = {}
    attributes_to_assign.uniq.each do |attr|
      protected_attrs[attr] = attrs.delete(attr)
    end
    self.new(attrs).tap do |new_object|
      protected_attrs.each do |key, value|
        new_object.send("#{key}=", value) if value rescue NoMethodError
      end
    end
  end
end

class ActiveRecord::Base
  extend ProtectedAttributeAssigment
end