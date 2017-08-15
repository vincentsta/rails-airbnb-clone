class AddDataToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :location, :string
    add_column :jobs, :category, :string
    add_column :jobs, :image, :string
  end
end
