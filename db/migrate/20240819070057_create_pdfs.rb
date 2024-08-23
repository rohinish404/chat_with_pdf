class CreatePdfs < ActiveRecord::Migration[7.2]
  def change
    create_table :pdfs do |t|
      t.string :filename

      t.timestamps
    end
  end
end
