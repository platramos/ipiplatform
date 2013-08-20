class Personality < ActiveRecord::Base
  belongs_to :user
  has_many :personality_traits
  has_many :traits, through: :personality_traits
end
