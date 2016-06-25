class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name
      t.string :competition_type
      t.boolean :finished, default: false

      t.timestamps null: false
    end
  end
end
