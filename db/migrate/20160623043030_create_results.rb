class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :competition, index: true, foreign_key: true
      t.references :athlete, index: true, foreign_key: true
      t.float :value
      t.string :unit

      t.timestamps null: false
    end
  end
end
