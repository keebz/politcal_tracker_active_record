class CreateRepresentatives < ActiveRecord::Migration
  def change
    create_table :representatives do |t|
    t.column :name, :string
    t.column :state_id, :int
    t.column :type_id, :int
    end
  end
end
