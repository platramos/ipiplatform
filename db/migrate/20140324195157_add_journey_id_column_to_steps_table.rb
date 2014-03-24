class AddJourneyIdColumnToStepsTable < ActiveRecord::Migration
  def change
    add_column :steps, :journey_id, :integer
    add_index :steps, :journey_id
  end
end
