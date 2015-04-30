class Jobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title,     default: nil, null: false
      t.string :shortcode, default: nil, null: false

      t.index :shortcode, unique: true

      t.timestamps
    end
  end
end
