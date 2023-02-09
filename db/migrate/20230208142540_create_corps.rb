class CreateCorps < ActiveRecord::Migration[5.2]
  def change
    create_table :corps do |t|
      t.string :nome

      t.timestamps
    end
  end
end
