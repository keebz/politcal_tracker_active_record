class CreateFunders < ActiveRecord::Migration
  def change
    create_table :funders do |t|
    	t.column :name, :string
    end
  end
end
