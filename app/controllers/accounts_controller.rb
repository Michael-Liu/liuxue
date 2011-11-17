class AccountsController < ApplicationController

  before_filter :auth
  layout "bg"

  def show
    @account = current_user.account
  end

end
