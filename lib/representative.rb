class Representative < ActiveRecord::Base
  validates :name, :presence => true

end