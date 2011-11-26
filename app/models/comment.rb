class Comment < ActiveRecord::Base

  belongs_to :from_user, :class_name => "User", :foreign_key => "from_user_id"
  belongs_to :to_user, :class_name => "User", :foreign_key => "to_user_id"

  belongs_to :service

  self.per_page = 6

  def time_ago
    ActionController::Base.helpers.time_ago_in_words self.created_at
  end

end
