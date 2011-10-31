class User < ActiveRecord::Base
  has_one :account
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :name, :type, :business, :address, :im, :telephone, :about

  validates_presence_of :name
  validates :name, 
    :length => {:maximum => 30},
    :uniqueness => true

  before_create do |user|
    user.account = Account.new
  end
end
