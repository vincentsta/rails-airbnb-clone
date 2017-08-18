class CreateJobLoaders < ActiveRecord::Migration[5.0]
  def change
    create_table :job_loaders do |t|
      t.string :cname
      t.string :cpath
      t.string :clogourl
      t.string :title
      t.string :path
      t.text :tags
      t.string :city
      t.text :shortdesc
      t.text :detailtags
      t.string :imgurl
      t.text :deschtml
      t.text :desctext
      t.text :profilhtml
      t.text :profiltext

      t.timestamps
    end
  end
end
