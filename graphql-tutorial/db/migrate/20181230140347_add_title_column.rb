class AddTitleColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :links, :book_title, :string
  end
end
