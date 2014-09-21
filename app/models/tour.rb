class Tour < ActiveRecord::Base
  attr_accessible :a, :b, :c, :d, :e, :paid, :id
  
  validates_presence_of :paid, :a, :b, :c, :d, :e
end
