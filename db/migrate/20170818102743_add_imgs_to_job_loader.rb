class AddImgsToJobLoader < ActiveRecord::Migration[5.0]
  def change
    add_column :job_loaders, :img, :string
    add_column :job_loaders, :logo, :string
  end
end
