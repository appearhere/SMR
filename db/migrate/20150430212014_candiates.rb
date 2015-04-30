class Candiates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name,          default: nil, null: false
      t.string :email,         default: nil, null: false
      t.string :identity_type, default: nil, null: false
      t.string :identity_id,   default: nil, null: false

      t.datetime :added_to_workable_at, default: nil, null: true

      t.datetime :last_error_at,      default: nil, null: true
      t.string   :last_error_code,    default: nil, null: true
      t.text     :last_error_message, default: nil, null: true

      t.belongs_to :job, default: nil, null: false, index: true

      t.timestamps
    end
  end
end
