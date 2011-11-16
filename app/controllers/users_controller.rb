class UsersController < ApplicationController

  before_filter :authenticate_user!
  layout "bg"

  # users#home
  def home
  end

  # def edit_password; end
  # def update_password
    # flash[:notice] = if !params[:old_password].blank? && !params[:new_password].blank?
    #   if params[:new_password] == params[:password_confirmation]
    #     if !current_user.valid_password?(params[:old_password])
    #       [User.human_attribute_name(:old_password),
    #       I18n.t("errors.messages.invalid")].join('')
    #     elsif current_user.update_attributes({:password => params[:new_password]})
    #       I18n.t("errors.success")
    #     else
    #       current_user.errors.full_messages.join("")
    #     end
    #   else
    #     [User.human_attribute_name(:new_password),
    #      I18n.t("errors.messages.equal_to", 
    #             :count => User.human_attribute_name(:password_confirmation))
    #     ].join('')
    #   end
    # else
    #   [User.human_attribute_name(:old_password),
    #   User.human_attribute_name(:new_password),
    #   I18n.t("errors.messages.empty")
    #   ].join(' ')
    # end

    # render "edit_password"
  # end

  # def edit_avatar; end
  # def update_avatar
  #   update_user
  #   render "edit_avatar"
  # end

  # def edit; end
  # def update
  #   update_user
  #   render "edit"
  # end

  # private
  # def update_user
  #   if current_user.update_attributes(params[current_user.type.downcase])
  #     flash[:notice] = I18n.t("errors.success")
  #   end
  # end

end
