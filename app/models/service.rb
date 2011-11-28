class Service < ActiveRecord::Base

  belongs_to :teacher, :foreign_key => "user_id"
  has_and_belongs_to_many :countries
  has_many :comments
  has_many :orders

  # validates_each :countries do |record, attr, value|
  #   record.errors.add(attr, I18n.t("errors.messages.empty")) if value.empty?
  # end

  validates_numericality_of :expense,
    :only_integer => true,
    :allow_blank => true

  class << self
    def list(params)
      self.joins("inner join countries_services on services.id = countries_services.service_id").
        where("countries_services.country_id = :country_id ", params).includes(:teacher).page(params[:page])
    end
  end

end
