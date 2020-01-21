ThinkingSphinx::Index.define :product, :with => :real_time do

  indexes name, :sortable => true
  has created_at, :type => :timestamp
  has updated_at, :type => :timestamp
end