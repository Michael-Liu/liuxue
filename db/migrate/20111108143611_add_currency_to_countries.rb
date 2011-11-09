class AddCurrencyToCountries < ActiveRecord::Migration
  def self.up
    add_column :countries, :currency, :string, :limit => 10
  end

  def self.down
    remove_column :countries, :currency
  end
end
