class CreateUserStats < ActiveRecord::Migration
  def change
    create_table :user_stats do |t|
      t.integer :user_id
      t.integer :nb_contracts, default: 0

      t.timestamps
    end
  end
end
