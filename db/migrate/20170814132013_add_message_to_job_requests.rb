class AddMessageToJobRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :job_requests, :message, :text
  end
end
