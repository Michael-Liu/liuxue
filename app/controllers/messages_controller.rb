class MessagesController < ApplicationController

  before_filter :auth

  def create
    @message = Message.new(params[:message])
    @message.to_user_id = params[:user_id]
    @message.from_user_id = current_user.id
    respond_to do |format|
      format.json do 
        render :json => if @message.save
          "1"
        else
          @message.errors.full_messages
        end
      end
    end
  end

end
