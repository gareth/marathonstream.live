class AddTitleToStreams < ActiveRecord::Migration[7.0]
  def change
    add_column :streams, :title, :string
  end
end
