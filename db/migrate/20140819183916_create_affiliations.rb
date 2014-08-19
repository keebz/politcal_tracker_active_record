class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
    t.column :funder_id, :int
    t.column :representative_id, :int
    end
  end
end
