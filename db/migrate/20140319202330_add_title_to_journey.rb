class AddTitleToJourney < ActiveRecord::Migration
  def change
    add_column :journeys, :title, :text
  end
end
