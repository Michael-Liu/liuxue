class Order < ActiveRecord::Base
  belongs_to :teacher, :counter_cache => true
  belongs_to :student, :counter_cache => true
end
