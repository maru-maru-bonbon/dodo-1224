class Participants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
