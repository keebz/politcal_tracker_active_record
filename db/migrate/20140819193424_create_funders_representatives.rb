class CreateFundersRepresentatives < ActiveRecord::Migration
  def change
    create_table :funders_representatives do |t|
    t.column :funder_id, :int
    t.column :representative_id, :int
    end
  end
end
