class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
    	t.column :name, :string
    end
  end
end
