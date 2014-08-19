class CreateAddPartyId < ActiveRecord::Migration
  def change
    add_column :representatives, :party_id, :int
  end
end
