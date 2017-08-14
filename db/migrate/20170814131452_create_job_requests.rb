class CreateJobRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :job_requests do |t|
      t.string :current_status
      t.references :job, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
