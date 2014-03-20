class CreateSolvings < ActiveRecord::Migration
  def change
    create_table :solvings do |t|
      t.integer :user_id
      t.integer :problem_id
      t.string :status

      t.timestamps
    end
  end
end
