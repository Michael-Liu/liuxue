class RegistrationsController < ::Devise::RegistrationsController

  before_filter :auth, :except => [:new, :create]
  before_filter :init_resource, :except => [:new, :create]
  layout :set_layout

  def edit_password; end
  def update_password
    # update
    update_pwd
    render "edit_password"
  end

  def edit_avatar; end
  def update_avatar
    update_user
    render "edit_avatar"
  end

  def edit; end
  def update
    update_user
    render "edit"
  end

  # teacher information
  def edit_teacher; end
  def update_teacher
    update_user
    render "edit_teacher"
  end

  protected
  def update_pwd

    if resource.update_with_password(params[resource_name])
      # set_flash_message :notice, :updated if is_navigational_format?
      sign_in resource_name, resource, :bypass => true
      set_flash_notice_success if is_navigational_format?
      # respond_with resource, :location => after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      # respond_with_navigational(resource){ render_with_scope :edit }
    end
  end

  def update_user
    # init_resource
    if resource.update_attributes(params[resource_name])
      set_flash_notice_success
    end
    # self.resource = current_user
  end

  def init_resource
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  end

  def set_layout
    if ["new"].include?(params[:action])
      "application"
    else
      "bg"
    end
  end
end
