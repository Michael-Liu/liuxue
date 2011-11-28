class Order < ActiveRecord::Base

  belongs_to :teacher, :counter_cache => true
  belongs_to :student, :counter_cache => true
  belongs_to :service

  validates_inclusion_of :status, :in => 1..9

  def total
    price * num
  end
end
