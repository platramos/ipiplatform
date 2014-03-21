class AddValuePropositionIdColumnToJourneyTable < ActiveRecord::Migration
  def change
    add_column :journeys, :value_proposition_id, :integer
    add_index :journeys, :value_proposition_id
  end
end
