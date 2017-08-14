class CreaateJobsRetry < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.integer :monthly_salary
      t.text :description
      t.text :profile
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
