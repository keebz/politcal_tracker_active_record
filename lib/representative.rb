class Representative < ActiveRecord::Base
  validates :name, :presence => true

  has_and_belongs_to_many :funders
  belongs_to :party
  belongs_to :state
  belongs_to :type
end