class Journey < ActiveRecord::Base
  has_many :steps
  belongs_to :value_proposition

  validates :title, presence: true
end
