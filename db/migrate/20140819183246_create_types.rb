class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
    	t.column :name, :string
    end
  end
end
