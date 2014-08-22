class Representative < ActiveRecord::Base
  validates :name, :presence => true

  scope :democrats, -> { where(party_id: 2) }
  scope :republicans, -> { where(party_id: 1) }

  has_and_belongs_to_many :funders
  belongs_to :party
  belongs_to :state
  belongs_to :type

end