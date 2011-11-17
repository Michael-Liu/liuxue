class User < ActiveRecord::Base
  has_one :account
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar,
    :default_style => :middle,
    :styles => {:medium => "240x240>", :thumb => "120x120>",
      :middle => "48x48>", :small => "24x24>"},
    :url => "/upload/users/:attachment/:id/:style.:extension",
    :path => "#{RAILS_ROOT}/public/upload/users/:attachment/:id/:style.:extension"

  validates_attachment_size :avatar, :less_that => 5000000 # about 5 Mb
  # validates_attachment_content_type, ;avatar, :content_type => "image/jpg"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :name, :type, :business, :address, :im, :telephone, :about, :avatar, 
    :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at,
    :request_visa_expense, :request_school_expense

  validates_presence_of :name
  validates :name, 
    :length => {:maximum => 30},
    :uniqueness => true

  validates :request_school_expense, :request_visa_expense,
    :format => {:with => /^[1-9]{1}\d{0,4}$/, :allow_blank => true}

  before_create do |user|
    user.account = Account.new
  end

end
