class CreateCompaniesRetry < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :location
      t.string :industry
      t.text :description
      t.string :logo
      t.string :picture
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
