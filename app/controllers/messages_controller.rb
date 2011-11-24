class MessagesController < ApplicationController

  def create
    @message = Message.new(params[:message])
    respond_to do |format|
      format.json do 
        render :text => if @message.save
          "1"
        else
          @message.errors.full_messages
        end
      end
    end
  end

end
