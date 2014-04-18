class CreateStepResources < ActiveRecord::Migration
  def change
    create_table :step_resources do |t|
      t.belongs_to :step, index: true
      t.belongs_to :resource, index: true

      t.timestamps
    end
  end
end
