class SchoolsController < ApplicationController

  # before_filter :country_code, :only => [:index]

  def index
    @school = (params[:school] && School.new(params[:school]))|| School.new
    @school.country_id = params[:country_id]

    # 
    sql = "country_id = :country_id and rank > 0 "
    @school.gre.blank? || sql << " and gre <= :gre"
    @school.gpa.blank? || sql << " and gpa <= :gpa"
    @school.gmat.blank? || sql << " and gmat <= :gmat"
    @school.toefl.blank? || sql << " and toefl <= :toefl"
    @school.ielts.blank? || sql << " and ielts <= :ielts"

    params[:school] ||= {}
    params[:school][:country_id] = params[:country_id]

    @schools = School.where(sql, params[:school]).order("rank").page(params[:page])
  end
end
