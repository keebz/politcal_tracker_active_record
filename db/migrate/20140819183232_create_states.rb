class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
    	t.column :name, :string
    end
  end
end
