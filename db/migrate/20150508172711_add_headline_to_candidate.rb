class AddHeadlineToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :headline, :string, default: nil, null: true
  end
end
