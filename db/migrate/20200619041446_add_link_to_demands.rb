class AddLinkToDemands < ActiveRecord::Migration[5.2]
  def change
    add_column :demands, :link, :text
  end
end
