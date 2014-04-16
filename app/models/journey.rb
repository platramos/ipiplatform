class Journey < ActiveRecord::Base
  has_many :steps
  belongs_to :value_proposition

  accepts_nested_attributes_for :steps
  validates :title, presence: true
end
