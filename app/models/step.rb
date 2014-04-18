class Step < ActiveRecord::Base
  has_many :step_resources
  has_many :resources, through: :step_resources

  acts_as_list :scope => :journey
  belongs_to :journey
  validates :name, presence: true

  accepts_nested_attributes_for :resources

  def add_resource(resource)
    self.resources.push(resource)
  end
end
