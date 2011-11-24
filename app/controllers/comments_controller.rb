class CommentsController < ApplicationController

  def index
    @comments = Comment.includes(:from_user).where(:to_user_id => params[:user_id]).
      order("created_at").page(params[:page])
    respond_to do |format|
      format.json do
        render :text => to_json
      end
    end
  end

  private 
  def to_json
    json = @comments.to_json(:methods => [:time_ago], 
      :include => {:from_user => {:only => [:name], :methods => [:url_middle]}})
    "[#{@comments.total_entries},#{json}]"
  end

end
