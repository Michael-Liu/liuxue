class Message < ActiveRecord::Base
  STATUS = {:unread => 1, :read => 2}

  belongs_to :from_user, :class_name => "User", :foreign_key => "from_user_id"
  belongs_to :to_user, :class_name => "User", :foreign_key => "to_user_id"

end
