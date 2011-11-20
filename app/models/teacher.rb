class Teacher < User
  has_many :orders
  has_and_belongs_to_many :countries

  validates_numericality_of :request_school_expense, :request_visa_expense,
    :only_integer => true

  validates_each :countries do |record, attr, value|
    record.errors.add(attr, I18n.t("errors.messages.empty")) if value.empty?
  end


  def countries_id
    if self.country_ids.blank?
      []
    else
      self.country_ids.split(',')
    end
  end
end
