class DropResourcesSteps < ActiveRecord::Migration
  def change
    drop_table :resources_steps
  end
end
