class Resource < ActiveRecord::Base
  has_many :trait_associations
  has_many :traits, through: :trait_associations
end