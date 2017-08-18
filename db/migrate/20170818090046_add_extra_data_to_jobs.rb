class AddExtraDataToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :extra_data, :text
  end
end
