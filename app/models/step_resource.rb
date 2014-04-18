class StepResource < ActiveRecord::Base
  belongs_to :step
  belongs_to :resource
end
